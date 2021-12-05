get_then <- function(args) {
  idx <- which_then(args)
  if (identical(idx, integer(0))) {
    stop("All arguments are named and .then is not among them. Please specify .then")
  }
  args[[idx]]
}

args_drop_then <- function(args) {
  idx <- which_then(args)
  args[[idx]] <- NULL
  if (length(args) == 0) {
    stop("ie requires at least two arguments to be specified")
  }
  args
}

which_then <- function(args) {
  if (is.null(names(args))) {
    length(args)
  } else {
    last_unnamed <- which(names(args) == "")
    if (length(last_unnamed) == 0) integer(0)
    tail(last_unnamed, 1)
  }
}


validate_fun_args <- function(fun, args) {
  frmls <- if (is.primitive(fun)) formals(args(fun)) else formals(fun)
  extra_args <- setdiff(names(args), names(frmls))

  if (length(extra_args[extra_args != ""]) > 0) {
    stop(
      sprintf("provided function does not accept following argument(s):\n %s",
              paste(extra_args, collapse = " "))
    )
  }
  invisible(NULL)
}
