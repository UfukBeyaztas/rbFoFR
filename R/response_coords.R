# Response coordinates on the response basis
response_coords <- function(Y, E, tgrid) {
  out <- matrix(0, nrow(Y), ncol(E))
  for (a in 1:ncol(E)) {
    out[, a] <- apply(Y, 1, function(y) l2_ip(y, E[, a], tgrid))
  }
  out
}

