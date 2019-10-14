#' Rank ensemble members.
#'
#' Take the rank structure from the \code{origin} ensemble and
#' apply it to the \code{x} ensemble.
#'
#' @param x An ensemble to be ranked.
#' @param origin An ensemble providing the ranks to be applied.
#' @param ... Not used yet.
#' @export
apply_rank <- function(x, origin, ...) {
  # --- checks ---
  n <- nrow(x)       ##  MUST MATCH!!!
  k <- nmembers(x)   ##  MUST MATCH!! 

  # --- sort x ---
  x <- apply(x, 1, sort)       # returns k x n matrix rather than n x k
                               #   however, x will be re-ordered by using
                               #   vector integer subsetting

  # --- get ranks of origin ---
  rnk <- apply(origin, 1, rank, ties.method = "random")   # again k x n matrix

  # --- apply ranks ---
  # First modify vector of ranks by adding
  # 0, 0, ..., 0, k, k, ..., k, 2*k, 2*k, ..., 2*k, ..., k*(n-1), k*(n-1), ..., k*(n-1)
  # so that the zeros refer to the first obs in the ensemble, and so on
  rnk <- rnk + rep((seq_len(n) - 1) * k, each = k)
  x <- matrix(x[rnk], ncol = k, nrow = n, byrow = TRUE)
  class(x) <- c("ensemble", class(x))
  x
}

#' Ensemble copula coupling.
#'
#' Apply empirical ensemble copula coupling.
#' The functions wrap the predicting of quantiles and re-ordering of ranks.
#'
#' @param model A fitted model object.
#' @param newdata A data.frame with new data to predict on.
#' @param origin_name A character. The name of the \code{ensemble} variable in
#'        \code{newdata}, from which the ranks will be applied to the predicted
#'        quantiles.
#' @param ... Not used yet.
#' @export
ecc_q <- function(model, newdata, origin_name, ...) {
  # --- predict quantiles ---
  k <- nmembers(newdata[[origin_name]])
  probs <- seq_len(k) / (k + 1)          # equi-distant probabilities
  fit <- stats::predict(model, newdata = newdata, type = "quantile", at = probs)

  # --- apply ranks ---
  apply_rank(x = fit, origin = newdata[[origin_name]])
}

#' @rdname ecc_q
ecc_r <- function(model, newdata, origin_name, ...) {
  # --- predict quantiles ---
  k <- nmembers(newdata[[origin_name]])
  probs <- stats::runif(k)             # random probabilities for random quantiles
  fit <- stats::predict(model, newdata = newdata, type = "quantile", at = probs)

  # --- apply ranks ---
  apply_rank(x = fit, origin = newdata[[origin_name]])
}



