testthat::test_that("OX keep values from .then for idx (logical)", {
  expect_identical(
    OX(is.na, c(1, NA, 3), .else = c(2, 2, 2)),
    c(2, NA, 2)
  )
})

testthat::test_that("OX replaces values from .else for !idx (logical)", {
  expect_identical(
    OX(Negate(is.na), c(1, NA, 3), .else = c(2, 2, 2)),
    c(1, 2, 3)
  )
})

testthat::test_that("OX keep values from .then for idx (logical)", {
  expect_identical(
    OX(`>`, x = c(1, 2, 3, 4), y = c(4, 3, 2, 1)),
    c(4, 3, 3, 4)
  )
})

testthat::test_that("OX replaces values from .else for !idx (logical)", {
  expect_identical(
    OX(`<=`, x = c(1, 2, 3, 4), y = c(4, 3, 2, 1)),
    c(1, 2, 2, 1)
  )
})

testthat::test_that("OX keep values from .then for idx (integer)", {
  which_na <- function(x) which(is.na(x))
  expect_identical(
    OX(which_na, c(1, NA, 3), .else = c(2, 2, 2)),
    c(2, NA, 2)
  )
})

testthat::test_that("OX replaces values from .else for !idx (integer)", {
  which_not_na <- function(x) which(!is.na(x))
  expect_identical(
    OX(which_not_na, c(1, NA, 3), .else = c(2, 2, 2)),
    c(1, 2, 3)
  )
})


testthat::test_that("OX keep values from .then for idx (integer)", {
  which_gt <- function(x, y) which(x > y)
  expect_identical(
    OX(which_gt, x = c(1, 2, 3, 4), y = c(4, 3, 2, 1)),
    c(4, 3, 3, 4)
  )
})

testthat::test_that("OX replaces values from .else for -idx (integer)", {
  which_eas <- function(x, y) which(x <= y)
  expect_identical(
    OX(which_eas, x = c(1, 2, 3, 4), y = c(4, 3, 2, 1)),
    c(1, 2, 2, 1)
  )
})

testthat::test_that("OX keep values from .then for idx", {
  expect_identical(
    OX(is.na, c(1, NA, 3), .else = 2),
    c(2, NA, 2)
  )
})

testthat::test_that("OX keep values from .else for idx", {
  expect_identical(
    OX(Negate(is.na), c(1, NA, 3), .else = 2),
    c(1, 2, 3)
  )
})

testthat::test_that("OX drops indices when .else is NULL", {
  expect_identical(
    OX(is.na, c(1L, NA_integer_, 3L), .else = character(0)),
    NA_integer_
  )
})


testthat::test_that("OX drops indices when .else is NULL", {
  expect_identical(
    OX(Negate(is.na), c(1, NA, 3), .else = integer(0)),
    c(1, 3)
  )
})

testthat::test_that("OX drops indices when .else is NULL", {
  expect_length(
    OX(Negate(is.na), c(NA, NA, NA), .else = integer(0)),
    0
  )
})

testthat::test_that("XO returns inverted values", {
  expect_identical(
    OX(Negate(is.na), c(1, NA, 3), .else = c(2, 2, 2)),
    XO(is.na, c(1, NA, 3), .else = c(2, 2, 2))
  )
  expect_identical(
    OX(`<=`, c(1, 2, 3), c(2, 2, 2)),
    XO(`>`, c(1, 3, 3), c(2, 2, 2))
  )
})
