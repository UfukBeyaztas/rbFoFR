# Co-observation probability of an index set
rho_set <- function(J, blocks, delta) {
  if (length(J) == 0 || delta == 1) return(1)
  lo <- max(max(blocks$lower[J] - delta), 0)
  hi <- min(min(blocks$upper[J]), 1 - delta)
  max(0, hi - lo) / (1 - delta)
}

