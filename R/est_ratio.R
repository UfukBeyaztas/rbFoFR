# Complete-case ratio estimator (unknown design law)
est_ratio <- function(Fm, Ystar, D) {
  out <- matrix(0, ncol(Fm), ncol(Ystar))
  for (j in 1:ncol(Fm)) {
    nj <- sum(D[, j])
    if (nj > 0) out[j, ] <- colSums(Fm[, j] * Ystar) / nj
  }
  out
}

