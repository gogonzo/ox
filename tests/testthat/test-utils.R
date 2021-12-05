testthat::test_that("which_then returns index of the last unnamed list element", {
  expect_identical(which_then(list(1, "a", 2, 3)), 4L)
  expect_identical(which_then(list(a = 1, "a", b = 2)), 2L) #todo: maybe it should throw an error - if .then not specified it should be listed as the last
  expect_identical(which_then(list(a = 1, "a", b = 2, "b")), 4L)
})

testthat::test_that("which_then returns empty integer when all list elements are named", {
  expect_identical(which_then(list(a = 1, b = 2, c = 3)), integer(0))
})

testthat::test_that("get_then returns the last unnamed list element", {
  expect_identical(get_then(list(a = 1, b = 2, 3, c = 4)), 3)
})

testthat::test_that("get_then errors when all list elements are named", {
  expect_error(
    get_then(list(a = 1, b = 2, c = 4)),
    "All arguments are named and .then is not among them. Please specify .then"
  )
})

testthat::test_that("args_drop_then drops latest unnamed index", {
  expect_identical(args_drop_then(list(a = 1, b = 2, 3, c = 4)), list(a = 1, b = 2, c = 4))
})

testthat::test_that("validate_args returns null when all args match function formals", {
  testthat::expect_null(validate_fun_args(isTRUE, list(x = 1)))
})

testthat::test_that("validate_args returns null when all args match primitive formals", {
  testthat::expect_null(validate_fun_args(fun = is.null, args = list(x = 1)))
})

testthat::test_that("validate_args throws when some args does not match function formals", {
  testthat::expect_error(
    validate_fun_args(isTRUE, list(x = 1, extra = 1)),
    "provided function does not accept following"
  )
  testthat::expect_error(
    validate_fun_args(fun = is.null, args = list(x = 1, extra = 1)),
    "provided function does not accept following"
  )
})




