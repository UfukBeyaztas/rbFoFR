# Localized orthonormal predictor basis
phi_basis <- function(blocks, sgrid) {
  K <- blocks$K
  Phi <- matrix(0, length(sgrid), K)
  for (k in 1:K) {
    b <- bump_fun(sgrid, blocks$lower[k], blocks$upper[k])
    nb <- sqrt(l2_ip(b, b, sgrid))
    if (!(nb > 0)) stop("block ", k, " has no grid points; use a finer 'sgrid'")
    Phi[, k] <- b / nb
  }
  Phi
}

