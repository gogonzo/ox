#' Short hand `ifelse`
#'
#' Short hand `ifelse` functions for easy values switching.
#' * `ie` (if-else) - returns first argument from `...` if `TRUE`,
#'  returns `.else` otherwise.
#' * `nie` (negative it-else) - returns `.else` if `TRUE` and first argument
#'  from `...` otherwise.
#' @param fun [`function`]\cr
#' @param ... \cr
#'  arguments passed to the `fun` in the same order.
#' @param .else \cr
#'  replacement object. NOTE that if `.else` is not specified as named argument
#'  else the last unnamed argument will be taken as a replacement (it will
#'  not be used in the `fun`).
#'
#' @examples
#' # return don't switch if TRUE
#' ie(is.null, NULL, "y")
#'
#' ie(function(x, min, max) nchar(x) >= min && nchar(x) <= max,
#'    x = "x", min = 0, max = 1,
#'    .else = "test passed")
#'
#' @export
ie <- function(fun, ..., .else) {
  fun_args <- list(...)
  if (length(fun_args) == 0) {
    stop("ie requires at least two arguments. One to as a replacement when `fun`",
         " returns TRUE and other (.else) when `fun` returns FALSE")
  }

  if (missing(.else)) {
    .else <- get_else(fun_args)
    fun_args <- args_drop_else(fun_args)
  }
  validate_fun_args(fun, fun_args)
  condition <- do.call(what = fun, args = fun_args)
  if (!condition) .else else fun_args[[1]]
}

#' @rdname ie
#' @examples
#' # return replacement `y` if is TRUE
#' nie(is.null, NULL, "y")
#'
#' nie(function(x, min, max) nchar(x) >= min && nchar(x) <= max,
#'    x = "test", min = 20, max = Inf,
#'    .else = "replacement")
#' @export
nie <- function(fun, ..., .else) {
  ie(fun = Negate(fun), ..., .else = .else)
}

