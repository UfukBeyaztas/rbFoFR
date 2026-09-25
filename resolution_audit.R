# Resolution audit
resolution_audit <- function(delta, Q = 5, tau = 0.05, floor_prop = 0.02,
                             nmc = 20000, seed = NULL) {
  if (!is.null(seed)) set.seed(seed)
  reach <- numeric(Q)
  band <- numeric(Q)
  for (r in seq_len(Q)) {
    band[r] <- band_measure(r, delta)
    if (delta == 1) {
      reach[r] <- as.numeric(tau <= 1)
    } else {
      U <- matrix(stats::runif(nmc * r), nmc, r)
      lo <- apply(U, 1, min)
      hi <- apply(U, 1, max)
      rho <- pmax(0, pmin(lo, 1 - delta) - pmax(0, hi - delta)) / (1 - delta)
      reach[r] <- mean(rho >= tau)
    }
  }
  idx <- which(reach >= floor_prop)
  r_star <- if (length(idx)) max(idx) else 0
  list(table = data.frame(order = seq_len(Q), reachable = reach,
                          band = band),
       r_star = r_star, tau = tau, floor_prop = floor_prop)
}

