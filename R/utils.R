#' Check `.f` output
#'
#' Checks whether `.f` has needed length
#' @param idx (`logical`, `integer`)
#' @param len (`integer`) length of `.then`
#' @return `idx` if `logical` and `unique(idx)` if numeric.
#' @keywords internal
validate_f_out <- function(idx, len) {
  if (is.null(idx)) {
    stop("`.f(...)` returned NULL.",
         "\n  Can't replace values of `.then[.f(...)] <- .else[.f(...)]`",
         call. = FALSE)
  }

  UseMethod("validate_f_out")
}

#' @export
validate_f_out.default <- function(idx, len) {
  stop("`.f(...)` generated output of class(es): ", paste(class(idx), collapse = " "),
       "\n  Only integer and logical are supported.",
       call. = FALSE)
}

#' @export
validate_f_out.integer <- function(idx, len) {
  if (any(!is.finite(idx))) {
    stop("`.f(...)` returned some non-finite values.",
         "\n  Can't replace values of `.then[.f(...)] <- .else[.f(...)]`",
         call. = FALSE)
  }

  if (length(idx) > len) {
    stop("Length of `.f(...)` output (integer) should not be greater than length
         of `.then`: ",
         length(idx), ">", len,
         "\n  Can't replace values of `.then[.f(...)] <- .else[.f(...)]`",
         call. = FALSE)
  }
  if (any(idx > len)) {
    stop("Some indexes returned by `.f(...)` are greater than length of `.then`: >",
         len,
         "\n  Can't replace values of `.then[.f(...)] <- .else[.f(...)]`",
         call. = FALSE)
  }
  unique(idx)
}

#' @export
validate_f_out.logical <- function(idx, len) {
  if (any(is.na(idx))) {
    stop("`.f(...)` returned some non-finite values.",
         "\n  Can't replace values of `.then[.f(...)] <- .else[.f(...)]`",
         call. = FALSE)
  }

  if (length(idx) != len) {
    stop("Length of `.f(...)` output (logical) should be the same as length of `.then`: ",
         length(idx), "!=", len,
         "\n  Can't replace values of `.then[.f(...)] <- .else[.f(...)]`",
         call. = FALSE)
  }
  idx
}

#' Checks .then and .else for OX
#'
#' Checks if .then and .else are fine. If they have supported classes and
#' if their length is the same.
#' @inheritParams vectorized-ox
#' @return `NULL` invisible.
#' @keywords internal
check_thenelse_OX <- function(.then, .else) { # nolint
  if (!inherits(.then, c("list", "logical", "integer", "numeric", "character", "factor"))) {
    stop("`.then` specified as: ", paste(class(.then), collapse = " "),
    "\n  OX accepts only atomic vectors and lists", call. = FALSE)
  }

  if (!inherits(.else, c("list", "logical", "integer", "numeric", "character", "factor", "NULL"))) {
    stop("`.else` specified as: ", paste(class(.else), collapse = " "),
         "\n  OX accepts only atomic vectors and lists", call. = FALSE)
  }

  if (length(.then) != length(.else) && length(.else) > 1) {
    stop("Different length of `.then` and `.else`: ",
         length(.then), "!=", length(.else),
         "\n  Can't replace values of `.then` by values of `.else`",
         call. = FALSE)
  }
  invisible(NULL)
}

#' Indices inversion
#'
#' Inverts the indices to select the rest. For example when `idx` is `logical`
#' then `[!idx]`, if `integer` then `[-idx]`
#'
#' @inheritParams validate_f_out
#' @return object identical to `idx` input but with inverted values.
#' @keywords internal
invert_indices <- function(idx) {
  if (is.logical(idx)) {
    !idx
  } else if (is.integer(idx)) {
    -idx
  } else {
    stop("only integer and logical values possible for indices.")
  }
}
