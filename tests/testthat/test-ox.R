fun <- function(xx, test, ...) {
  message(paste(as.character(match.call())[-1], collapse = ""))
  FALSE
}

testthat::test_that("ox returns input when condition is TRUE - only two args", {
  testthat::expect_identical(ox(isTRUE, TRUE, character(0)), TRUE)
  testthat::expect_identical(ox(isTRUE, TRUE, .else = character(0)), TRUE)
})

testthat::test_that("xo returns .else when condition is FALSE - only two args", {
  testthat::expect_identical(ox(isTRUE, FALSE, character(0)), character(0))
  testthat::expect_identical(ox(isTRUE, FALSE, .else = character(0)), character(0))
})

testthat::test_that("fun is called with all arguments except .else which is returned", {
  testthat::expect_message(
    testthat::expect_identical(ox(fun, 1, 2, 3, 4, 5, .else = 6), 6),
    "12345"
  )
  testthat::expect_message(
    testthat::expect_identical(ox(.else = 6, fun, 1, 2, 3, 4, 5), 6),
    "12345"
  )
  testthat::expect_message(
    testthat::expect_identical(ox(fun, 1, 2, .else = 6, 3, 4, 5), 6),
    "12345"
  )
})

testthat::test_that("fun is called with all arguments except latest unnamed arg (.else)", {
  testthat::expect_message(
    testthat::expect_identical(ox(fun, 1, 2, 3, 4, 5, 6), 6),
    "12345"
  )
  testthat::expect_message(
    testthat::expect_identical(ox(fun, xx = 1, test = 2, a = 3, b = 4, 6, c = 5), 6),
    "12345"
  )

  testthat::expect_message(
    testthat::expect_identical(ox(fun, xx = 1, test = 2, 3, b = 4, 6, c = 5), 6),
    "12345"
  )
})

testthat::test_that("fun is called with following args order: x, test, ... (except the last unnamed - .else)", {
  testthat::expect_message(
    testthat::expect_identical(ox(fun, xx = 1, z = 2, test = 3, 4, 6, a = 5), 6),
    "13245"
  )
})

testthat::test_that("xo throws an error when extra argument is added", {
  testthat::expect_error(
    ox(isTRUE, x = 1, .else = 2, extra = 3),
    "provided function does not accept following"
  )
})

testthat::test_that("xo throws an error when only one argument added", {
  testthat::expect_error(
    ox(isTRUE, x = 1),
    "All arguments are named and .else is not among them. Please specify .else"
  )
  testthat::expect_error(
    ox(isTRUE, .else = 1),
    "ox requires at least two arguments. One to"
  )
})

testthat::test_that("xo is identical to negate ox", {
  testthat::expect_identical(
    ox(Negate(isTRUE), TRUE, character(0)),
    xo(isTRUE, TRUE, character(0))
  )
})
