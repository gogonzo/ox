#' Short hand if-else
#'
#' Short hand if-else functions for simple values switching.
#' @param .f (`function`)\cr
#' to be applied on  `...`. Must return single logical value.
#' @param ...  arguments passed to the `.f`.
#' @param .then A positive-replacement. NOTE, that if `.then` is not specified
#'  directly by named argument then the first argument from `...` will
#'  be taken.
#' @param .else A negative-replacement. NOTE, that if `.else` is not specified
#'  directly by named argument then the last argument from `...` will
#'  be considered as a replacement.
#'
#' @details
#'
#' \if{html}{\figure{uml1.jpg}{options: width="75\%" alt="Figure: uml1.jpg"}}
#' \if{latex}{\figure{uml1.jpg}{options: width=7cm}}
#'
#' `ox` evaluates function `.f` which returns a single logical value and
#' depending on the result `ox` returns:
#' * on `TRUE` returns `.then`.
#' * on `FALSE` returns `.else`.
#'
#' It's important to note is that `.then` and `.else` have a default values set
#' as the first and the last element of the `...`. This means that they don't
#' have to be specified if both are arguments of `.f`.\cr
#' If any of them are not arguments of `.f` then this argument should be
#' specified directly as `.then` or `.else`, otherwise it will be passed to the
#' function.\cr\cr
#' As, far as `.then` and `.else` won't be specified order of arguments in `...`
#' matters for `ox` but it's up to you if they are passed in the correct order
#' to the `.f`. Then one, might consider name the argument so `.f` will be
#' executed as expected. Consider following example
#' ```
#' greater_than_by <- function(x, y, by) x > (y + by)
#' ox(greater_than_by, x = 5, by = 3, y = 3)
#' ```
#' In above, one needs to move `y` to the end so that it will be considered as
#' `.else`.
#'
#' To invert the switch one can use `xo` which is equivalent of
#' `ox(Negate(.f), ..., .then, .else)`.
#'
#' @return object identical to `.then` or `.else` depending on the condition
#' result.
#' @examples
#' # if (is.null(NULL)) NULL else 1
#' ox(NULL, .f = is.null, .else = 1)
#'
#' # if (is("text", "character")) "text" else "not a character"
#' ox("text", .f = is, "character", .else = "not a character")
#'
#' # if (1 > 2) 1 else 2
#' ox(`>`, 1, 2)
#' @export
ox <- function(.f, ..., .then = list(...)[[1]], .else = rev(list(...))[[1]]) {
  fun_args <- list(...)
  condition <- do.call(what = .f, args = fun_args)
  if (!condition) .else else .then
}

#' @rdname ox
#' @examples
#' # if (!is.null(NULL)) NULL else 1
#' xo(NULL, .f = is.null, .else = 1)
#'
#' # if (!is("text", "character")) "text" else "not a character"
#' xo("text", .f = is, "character", .else = "not a character")
#'
#' # if (!1 > 2) 1 else 2
#' xo(`>`, 1, 2)
#' @export
xo <- function(.f, ..., .then = list(...)[[1]], .else = rev(list(...))[[1]]) {
  ox(.f = Negate(.f), ..., .then = .then, .else = .else)
}
