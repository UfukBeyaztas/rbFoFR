# Inverse probability weighted estimator (known design law)
est_ipw <- function(Fm, Ystar, rho) {
  n <- nrow(Ystar)
  out <- matrix(0, ncol(Fm), ncol(Ystar))
  for (j in 1:ncol(Fm)) {
    if (rho[j] > 0) {
      out[j, ] <- colSums(Fm[, j] * Ystar) / (n * rho[j])
    } else {
      out[j, ] <- NA
    }
  }
  out
}

