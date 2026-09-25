# Observability indicators 1{J is reachable from A_i}
obs_indicator <- function(A, Jlist, blocks, delta) {
  D <- matrix(0, length(A), length(Jlist))
  for (i in seq_along(A)) {
    vis <- reachable_blocks(A[i], blocks, delta)
    for (j in seq_along(Jlist)) D[i, j] <- as.numeric(all(Jlist[[j]] %in% vis))
  }
  D
}

