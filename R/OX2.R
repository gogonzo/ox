#' @name vectorized-ox
#' @title Vectorized `ox`
#'
#' @description Switch the values of the vector by another on specific indices.
#' @param .f (`function`) evaluated as `.f(...)`. Must return a vector of
#' indices, which defines elements which values will be replaced by `.else`.
#' @inheritParams ox
#'
#' @details
#'
#' \if{html}{\figure{uml2.jpg}{options: width="75\%" alt="Figure: uml2.jpg"}}
#' \if{latex}{\figure{uml2.jpg}{options: width=7cm}}
#'
#' #' `OX` evaluates function `.f` which returns a vector of indices which
#' are then decide which values of `.then` are replaced by `else`.
#' ```
#' .then[idx] <- .else[idx]
#' ```
#' Consequence of above is that `idx = .f(...)` should be a logical vector of
#' the same length as `.then`, or integer vector of length `< length(.then)`.
#' Length of `.then` should be also the same as length of `.else`
#'
#' To invert the switch one can use `XO` which is equivalent of
#' `OX(Negate(.f), ..., .then, .else)`.
#'
#' @examples
#' # switch values of vector by
#' OX(is.na, c(1, NA, 3), .else = c(2, 2, 2))
#' @export
OX <- function(.f, ..., .then = list(...)[[1]], .else = rev(list(...))[[1]]) {
  check_thenelse_OX(.then, .else)
  fun_args <- list(...)
  out <- do.call(what = .f, args = fun_args)
  out <- validate_f_out(out, length(.then))
  .then[out] <- .else[out]
  .then
}



#' @rdname vectorized-ox
#' @examples
#' XO(is.na, c(1, NA, 3), .else = c(2, 2, 2))
#' @export
XO <- function(.f, ..., .then = list(...)[[1]], .else = rev(list(...))[[1]]) {
  OX(.f = Negate(.f), ..., .then = .then,.else = .else)
}
