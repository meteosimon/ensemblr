TODOs
=====

* A function `apply_rank()`, that would that the rank structure
    of one ensemble and apply it to another ensemble, i.e.,
    from the raw ensemble to an ensemble of quantiles drawn from
    calibrated margins. `apply_rank()` could have such an interface:

```
#' @param x An ensemble to be ranked.
#' @param origin An ensemble providing the ranks to be applied.
apply_rank(x, origin, ...)
```

* Wrap `predict()` and `apply_rank()` for ECC (requires predict methods with
    `type = "quantile"`):

```
ecc_q <- function(model, newdata, origin_name, ...) {
  # --- predict quantiles ---
  k <- nmembers(newdata[[origin_name]])
  probs <- seq_len(k) / (k + 1)
  fit <- predict(model, newdata = newdata, type = "quantile", at = probs)

  # --- apply ranks ---
  apply_rank(x = fit, origin = newdata[[origin_name]])
}
```

* `nmemebers()` to get the number of members of the ensemble.

* Find a way to allow predictions with an `ensemble` that doesnot
    contain realization of the ensemble, but parametric descriptions
    of the margins.



