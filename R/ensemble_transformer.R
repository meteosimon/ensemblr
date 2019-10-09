#' Ensemble standard deviation
#'
#' Compute the ensemble standard deviation.
#'
#' Apply \code{sd} on each row of the ensemble.
#'
#' @param x An ensemble.
#' @param ... passed to \code{sd}.
#' @export
ens_sd <- function(x, ...) {
  apply(x, 1, sd, ...) 
}


