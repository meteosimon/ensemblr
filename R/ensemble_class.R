#' Coerce object to ensemble.
#'
#' Generic function to coerce objects to objects of class ensemble.
#'
#' The default methods applies \code{as.matrix}.
#'
#' @param x An object.
#' @param ... Further arguments, unused in default method.
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
  rowMeans(x, ...)
}

#' @method median ensemble
#' @importFrom stats median
#' @export
median.ensemble <- function(x, na.rm = FALSE, ...) {
  apply(x, 1, stats::median, na.rm = na.rm, ...)
}

#' @method quantile ensemble
#' @importFrom stats quantile
#' @export
quantile.ensemble <- function(x, ...) {
  apply(x, 1, stats::quantile, ...)
}

#' Access the number of ensemble members. 
#'
#' @param x An enemble.
#' @export
nmembers <- function(x) {
  ncol(x)
}	



