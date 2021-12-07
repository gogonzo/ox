testthat::test_that("validate_f_out.logical silent when length equal to .then", {
  expect_identical(
    validate_f_out(c(TRUE, TRUE, FALSE), len = 3),
    c(TRUE, TRUE, FALSE)
  )
})

testthat::test_that("validate_f_out.logical throws length != .then", {
  expect_error(validate_f_out(c(TRUE, TRUE, FALSE), len = 4), "3!=4")
})

testthat::test_that("validate_f_out.logical throws when NA", {
  expect_error(validate_f_out(c(TRUE, NA), len = 2), "non-finite")
})

testthat::test_that("validate_f_out.int silent if length equal to .then", {
  expect_identical(validate_f_out(seq_len(4), len = 4), seq_len(4))
})


testthat::test_that("validate_f_out.int returns unique when some indices duplicated", {
  expect_identical(validate_f_out(c(1L, 1L, 2L, 3L), len = 4), c(1L, 2L, 3L))
})

testthat::test_that("validate_f_out.int throws when idices are greater than length of .then", {
  expect_error(validate_f_out(c(1L, 2L, 3L, 5L), len = 4), ">4")
})

testthat::test_that("validate_f_out.int throws when NA", {
  expect_error(validate_f_out(c(1L, 2L, NA), len = 4), "non-finite")
})

testthat::test_that("validate_f_out.default throws", {
  expect_error(validate_f_out(c("1", "2"), len = 4), "character")
  expect_error(validate_f_out(c(1.0, 2.0), len = 4), "numeric")
})

testthat::test_that("validate_f_out.default throws when not finite", {
  expect_error(validate_f_out(NULL, len = 4), "NULL")
})

testthat::test_that("check_thenelse_OX does not throw when different classes throws when not finite", {
  expect_silent(check_thenelse_OX(c(1, 2), c("a", "b")))
  expect_silent(check_thenelse_OX(c(1, 2), list(1, 2)))
})

testthat::test_that("check_thenelse_OX throw when lenth of .then and .else differ", {
  expect_error(check_thenelse_OX(c(1, 2), c(1)), "2!=1")
})

testthat::test_that("check_thenelse_OX throw when .then or .else are not atomic or list", {
  expect_error(check_thenelse_OX(c(1, 2), matrix(1)), "`.else`.+matrix array")
  expect_error(check_thenelse_OX(matrix(1), c(1, 2)), "`.then`.+matrix array")
})
