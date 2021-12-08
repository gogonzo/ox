fun <- function(xx, test, ...) {
  message(paste(as.character(match.call())[-1], collapse = ""))
  FALSE
}

testthat::test_that("ox returns .then when condition is TRUE - only two args", {
  testthat::expect_identical(ox(isTRUE, TRUE, .else = character(0)), TRUE)
})

testthat::test_that("xo returns .else when condition is FALSE - only two args", {
  testthat::expect_identical(ox(isTRUE, FALSE, .else = character(0)), character(0))
})

testthat::test_that("fun is called with all arguments - latest as .else", {
  testthat::expect_message(
    testthat::expect_identical(ox(fun, 1, 2, 3, 4, 5, 6), 6),
    "123456"
  )
})

testthat::test_that("fun is called with all arguments - first as .then", {
  testthat::expect_message(
    testthat::expect_identical(ox(Negate(fun), 1, 2, 3, 4, 5, 6), 1),
    "123456"
  )
})

testthat::test_that("fun is called with all arguments except .else and .then, returns .else", {
  testthat::expect_message(
    testthat::expect_identical(ox(fun, 1, .then = 2, 3, 4, 5, .else = 6), 6),
    "1345"
  )
  testthat::expect_message(
    testthat::expect_identical(ox(.else = 6, fun, .then = 1, 2, 3, 4, 5), 6),
    "2345"
  )
  testthat::expect_message(
    testthat::expect_identical(ox(fun, 1, 2, .else = 6, 3, 4, .then = 5), 6),
    "1234"
  )
})

testthat::test_that("fun is called with all arguments except .else and .then, returns .then", {
  fum <- Negate(fun)
  testthat::expect_message(
    testthat::expect_identical(ox(fum, 1, .then = 2, 3, 4, 5, .else = 6), 2),
    "1345"
  )
  testthat::expect_message(
    testthat::expect_identical(ox(.else = 6, fum, .then = 1, 2, 3, 4, 5), 1),
    "2345"
  )
  testthat::expect_message(
    testthat::expect_identical(ox(fum, 1, 2, .else = 6, 3, 4, .then = 5), 5),
    "1234"
  )
})

testthat::test_that("xo is identical to negate ox", {
  testthat::expect_identical(
    ox(Negate(isTRUE), TRUE, .else = character(0)),
    xo(isTRUE, TRUE, .else = character(0))
  )
})
