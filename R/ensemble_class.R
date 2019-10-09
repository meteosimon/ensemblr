#' Coerce object to ensemble.
#'
#' Generic function to coerce objects to objects of class ensemble.
#'
#' The default methods applies \code{as.matrix}.
#'
#' @param x An object.
#' @return An object of class ensemble.
#' @export
as_ensemble <- function(x, ...) {
  UseMethod("as_ensemble")
}

#' @describeIn as_ensemble Default method. 
#' @export
as_ensemble.default <- function(x, ...) {
  x <- as.matrix(x)
  class(x) <- c("ensemble", class(x))
  x
}

#' @method mean ensemble
#' @export
mean.ensemble <- function(x, ...) {
  rval <- rowMeans(x, ...)
  rval
}





