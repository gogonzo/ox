#' @name vectorized-ox
#' @title Vectorized `ox`
#'
#' @description Switch the values of the vector by another on specific indices.
#' @inheritParams ox
#' @param .f (`function`)\cr
#'  evaluated as `.f(...)`. Must return a vector of indices (`logical` or `integer`),
#'  which defines which values will be replaced by `.else`.
#' @param .then (`list`, `atomic`, `NULL`)\cr
#'  A positive-replacement.
#'  NOTE, that if `.then` is not specified directly by named argument then the
#'  first argument from `...` will be taken.
#' @param .else (`list`, `atomic`, `NULL`)\cr
#'  A negative-replacement. Should be of length equal to length of `.then`, or
#'  single value or `NULL`.
#'  NOTE, that if `.else` is not specified directly by named argument then the
#'  last argument from `...` will be considered as a replacement.
#'
#' @details
#'
#' \if{html}{\figure{uml2.jpg}{options: width="75\%" alt="Figure: uml2.jpg"}}
#' \if{latex}{\figure{uml2.jpg}{options: width=7cm}}
#'
#' #' `OX` evaluates function `.f` which returns a vector of indices which
#' are then decide which values of `.then` are replaced by `else`.
#' ```
#' .then[!idx] <- .else[!idx]
#' ```
#' Consequence of above is that `idx = .f(...)` should be a `logical` vector or
#' `integer` vector which would be valid indices for `.then` and `.else`.
#' This means that `.then` and `.else` should be of the same length, but there
#' are two exceptions:
#' * when `.else` is a single value, than this value will replace `.then` at
#' returned indices `.then[!idx] <- .else`
#' * when `.else` is `NULL`
#'
#' To invert the switch one can use `XO` which is equivalent of
#' `OX(Negate(.f), ..., .then, .else)`.
#'
#' @examples
#' # switch values of the vector when condition is true
#' OX(is.na, c(1, NA, 3), .else = c(2, 2, 2))
#' @return `atomic` or `list`. Returned object is a `.then` object with elements
#' replaced by `.else` depending on a result of the logical condition.
#' @export
OX <- function(.f, ..., .then = list(...)[[1]], .else = rev(list(...))[[1]]) { # nolint
  OX_default(.f = .f, ..., .then = .then, .else = .else, .invert = TRUE)
}

#' @rdname vectorized-ox
#' @examples
#'
#' # use OX to invert negate the condition
#' XO(is.na, c(1, NA, 3), .else = c(2, 2, 2))
#' @export
XO <- function(.f, ..., .then = list(...)[[1]], .else = rev(list(...))[[1]]) { # nolint
  OX_default(.f = .f, ..., .then = .then, .else = .else, .invert = FALSE)
}

#' Utility function to run OX
#'
#' @inheritParams vectorized-ox
#' @param .invert (`logical(1)`) whether to invert the indices
#' @keywords internal
OX_default <- function(.f, ..., .then = list(...)[[1]], .else = rev(list(...))[[1]], .invert = FALSE) { # nolint
  check_thenelse_OX(.then, .else)
  fun_args <- list(...)
  out <- do.call(what = .f, args = fun_args)
  out <- validate_f_out(out, length(.then))
  if (.invert) out <- invert_indices(out)
  .then[out] <- if (length(.else) == 0) {
    # drop indices by selecting others
    return(.then[invert_indices(out)])
  } else if (length(.else) == 1) {
    .else
  } else {
    .else[out]
  }
  .then
}
