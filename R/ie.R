#' Short hand `ifelse`
#'
#' Short hand `ifelse` functions for easy values switching.
#' * `ie` (if-else) - returns replacement if condition is `TRUE`.
#' * `ei` (else-if) - returns replacement if condition is `FALSE`.
#' @param fun [`function`]\cr
#' @param ...\cr
#'  arguments passed to the `fun` in the same order.
#' @param .then\cr
#'  replacement object. NOTE that if `.then` is not specified as named argument
#'  then the last unnamed argument will be taken as a replacement (it will
#'  not be used in the `fun`).
#'
#' @examples
#' # return replacement ("y") if it's NULL
#' ie(is.null, NULL, "y")
#'
#' ie(function(x, min, max) nchar(x) >= min && nchar(x) <= max,
#'    x = "x", min = 0, max = 1,
#'    .then = "test passed")
#'
#' @export
ie <- function(fun, ..., .then) {
  fun_args <- list(...)
  stopifnot(length(fun_args) >= 1)

  if (missing(.then)) {
    .then <- get_then(fun_args)
    fun_args <- args_drop_then(fun_args)
  }
  condition <- do.call(what = fun, args = fun_args)

  if (condition) .then else fun_args[[1]]
}

#' @rdname ie
#' @inheritParams ie
#' @examples
#' # return replacement ("y") if it's not a character
#' ei(is.character, NULL, "y")
#'
#' ei(function(x, min, max) nchar(x) >= min && nchar(x) <= max,
#'    x = "test", min = 20, max = Inf
#'    .then = "replacement")
#' @export
ei <- function(fun, ..., .then) {
  fun_args <- list(...)
  stopifnot(length(fun_args) >= 1)

  if (missing(.then)) {
    .then <- get_then(fun_args)
    fun_args <- args_drop_then(fun_args)
  }
  validate_fun_args(fun, fun_args)

  condition <- do.call(what = fun, args = fun_args)
  if (!condition) .then else fun_args[[1]]
}

