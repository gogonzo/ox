#' Get index of an `.else` argument
#'
#' Get index of an `.else` argument. Returns index of the potential
#'
#' @param args [`list`]\cr arguments
#' @return `integer(1)` or `integer(0)` when no unnamed list
#' elements.
which_else <- function(args) {
  if (is.null(names(args))) {
    length(args)
  } else {
    last_unnamed <- which(names(args) == "")
    if (length(last_unnamed) == 0) integer(0)
    utils::tail(last_unnamed, 1)
  }
}

#' Get `.else` argument
#'
#' Gets `.else` argument from the arguments list. Technically, last unnamed
#' list object is returned.
#' @inheritParams which_else
#' @return last unnamed `args` list element
get_else <- function(args) {
  idx <- which_else(args)
  if (identical(idx, integer(0))) {
    stop("All arguments are named and .else is not among them. Please specify .else")
  }
  args[[idx]]
}

#' Removes `.else` from arguments list
#'
#' #' Removes `.else` from arguments list. Technically, last unnamed
#' list object is removed.
#' @inheritParams which_else
#' @return last of `args` without `.else`
args_drop_else <- function(args) {
  idx <- which_else(args)
  args[[idx]] <- NULL
  if (length(args) == 0) {
    stop("ox requires at least two arguments. One to as a replacement when `.f`",
         " returns TRUE and other (.else) when `.f` returns FALSE")
  }
  args
}

#' Get index of an `.else` argument
#'
#' Get index of an `.else` argument. Returns index of the potential
#'
#' @inheritParams which_else
#' @inheritParams ox
#' @return `NULL`
validate_fun_args <- function(.f, args) {
  frmls <- if (is.primitive(.f)) formals(args(.f)) else formals(.f)
  extra_args <- setdiff(names(args), names(frmls))

  if (length(extra_args[extra_args != ""]) > 0 && !"..." %in% names(frmls)) {
    stop(
      sprintf("provided function does not accept following argument(s):\n %s",
              paste(extra_args, collapse = " "))
    )
  }
  invisible(NULL)
}
