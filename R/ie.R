#' Short hand if-else
#'
#' Short hand if-else function for simple values switching.
#' @param .f (`function`) evaluated as `.f(...)`. Must return single logical value
#' @param ...  arguments passed to the `.f`. First element of `...` will be
#'   considered as a positive-replacement (so called "then").
#' @param .else  negative-replacement. NOTE that if `.else` is not specified
#'  directly by naming argument then the last unnamed argument (from `...`) will
#'  be considered as a replacement (it will not be used in the `.f`).
#'
#' @details
#'
#' \if{html}{\figure{uml.jpg}{options: width="75\%" alt="Figure: uml.jpg"}}
#' \if{latex}{\figure{uml.jpg}{options: width=7cm}}
#'
#' #' `ox` evaluates function `.f` which returns a single logical value and and
#' depending on the result `ox` returns:
#' * on `TRUE` (then) - `ox` returns `...[1]`. First element in `...` is considered
#' as a  positive-replacement.
#' * on `FALSE` (else) - `ox` returns `.else` (negative-replacement).
#'
#' To invert the switch one can use `xo` which is equivalent of
#' `ox(Negate(.f), ..., .else)`.
#'
#' @examples
#' # return don't switch if TRUE
#' ox(NULL, .f = is.null, 1)
#' ox("text", .f = is, "character", "not a character")
#'
#' @export
ox <- function(.f, ..., .else) {
  fun_args <- list(...)
  if (length(fun_args) == 0) {
    stop("ox requires at least two arguments. One to as a replacement when `.f`",
         " returns TRUE and other (.else) when `.f` returns FALSE")
  }

  if (missing(.else)) {
    .else <- get_else(fun_args)
    fun_args <- args_drop_else(fun_args)
  }
  validate_fun_args(.f, fun_args)
  condition <- do.call(what = .f, args = fun_args)
  if (!condition) .else else fun_args[[1]]
}

#' @rdname ox
#' @examples
#' # return replacement `y` if is TRUE
#' xo(NULL, .f = is.null, 1)
#' xo("text", .f = is, "character", "not a character")
#' @export
xo <- function(.f, ..., .else) {
  ox(.f = Negate(.f), ..., .else = .else)
}

