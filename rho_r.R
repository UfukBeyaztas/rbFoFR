# Co-observation probability of a point set under uniform window starts
rho_r <- function(s, delta) {
  if (delta == 1) return(1)
  lo <- max(0, max(s) - delta)
  hi <- min(min(s), 1 - delta)
  max(0, hi - lo) / (1 - delta)
}

