fun <- function(xx, test, ...) {
  message(paste(as.character(match.call())[-1], collapse = ""))
  TRUE
}

testthat::test_that("ie returns .then when condition is true - only two args", {
  testthat::expect_identical(ie(isTRUE, TRUE, character(0)), character(0))
  testthat::expect_identical(ie(isTRUE, TRUE, .then = character(0)), character(0))
})

testthat::test_that("ie returns input when condition is false - only two args", {
  testthat::expect_identical(ie(isTRUE, FALSE, character(0)), FALSE)
  testthat::expect_identical(ie(isTRUE, FALSE, .then = character(0)), FALSE)
})

testthat::test_that("ie ", {
  expect_identical(ie(is, "test", "character", character(0)), character(0))
  expect_identical(ie(is, "test", "character", .then = character(0)), character(0))
})

testthat::test_that("fun is called with all arguments except .then which is returned", {
  testthat::expect_message(
    testthat::expect_identical(ie(fun, 1, 2, 3, 4, 5, .then = 6), 6),
    "12345"
  )
  testthat::expect_message(
    testthat::expect_identical(ie(.then = 6, fun, 1, 2, 3, 4, 5), 6),
    "12345"
  )
  testthat::expect_message(
    testthat::expect_identical(ie(fun, 1, 2, .then = 6, 3, 4, 5), 6),
    "12345"
  )
})

testthat::test_that("fun is called with all arguments except latest unnamed arg (.then)", {
  testthat::expect_message(
    testthat::expect_identical(ie(fun, 1, 2, 3, 4, 5, 6), 6),
    "12345"
  )
  testthat::expect_message(
    testthat::expect_identical(ie(fun, xx = 1, test = 2, a = 3, b = 4, 6, c = 5), 6),
    "12345"
  )

  testthat::expect_message(
    testthat::expect_identical(ie(fun, xx = 1, test = 2, 3, b = 4, 6, c = 5), 6),
    "12345"
  )
})

testthat::test_that("fun is called with following args order: x, test, ... (except the last unnamed - .then)", {
  testthat::expect_message(
    testthat::expect_identical(ie(fun, xx = 1, z = 2, test = 3, 4, 6, a = 5), 6),
    "13245"
  )
})

testthat::test_that("ie throws an error when extra arg is used", {
   testhath::expect_error(
     ie(is, "test", "character", extra_arg = "", .then = "elo"),
     ""
   )
})


testthat::test_that("second argument is returned if condition is TRUE - three arguments, one named", {
  expect_identical(ie(is, object = "test", "character", character(0)), character(0))
  expect_identical(ie(is, object = "test", class2 = "character", character(0)), character(0))
  expect_error(ie(is, object = "test", class2 = "character", extraarg = "", character(0)))
  expect_identical(ie(fun, xx = "test", "a", "b", "c", d = "d", character(0)), character(0))
  expect_error(ie(is, object = "test", character(0)), character(0))
  expect_identical(ie(is, "test"), character(0))
})
