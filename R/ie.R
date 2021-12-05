#' Short hand if-else
#'
#' Short hand if-else functions for easy values switching.
#' `ie` evaluates function returning a single logical value and depending on the
#' result returning:
#' * on `TRUE` - `ie` returns `...[1]`. First element in `...` is considered
#' as a  positive-replacement.
#' * on `FALSE` - `ie` returns `.else` (negative-replacement).
#'
#' To invert switch one can use `nie` which is equivalent of
#' `ie(Negate(fun), ..., .else)`.
#' @param fun [`function`]\cr
#' @param ... \cr
#'  arguments passed to the `fun` in the same order.
#' @param .else \cr
#'  negative-replacement. NOTE that if `.else` is not specified directly by naming
#'  argument then the last unnamed argument (from `...`) will be considered as a
#'  replacement (it will not be used in the `fun`).
#'
#' @examples
#' # return don't switch if TRUE
#' ie(is.null, NULL, "y")
#' ie(grepl, x = "some text", pattern = "word", .else = "does not contain a word")
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
#' nie(grepl, x = "some text", pattern = "word", .else = "does not contain a word")
#' @export
nie <- function(fun, ..., .else) {
  ie(fun = Negate(fun), ..., .else = .else)
}

