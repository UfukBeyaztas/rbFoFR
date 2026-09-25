# Orthonormal response basis
response_basis <- function(d, tgrid, tol = 1e-10) {
  if (d < 1) stop("'d' must be at least 1")
  raw <- matrix(0, length(tgrid), d)
  raw[, 1] <- 1
  a <- 2
  freq <- 1
  while (a <= d) {
    raw[, a] <- cos(2 * pi * freq * tgrid)
    a <- a + 1
    if (a <= d) {
      raw[, a] <- sin(2 * pi * freq * tgrid)
      a <- a + 1
    }
    freq <- freq + 1
  }
  E <- matrix(0, length(tgrid), d)
  for (a in 1:d) {
    v <- raw[, a]
    if (a > 1) {
      for (b in 1:(a - 1)) v <- v - l2_ip(v, E[, b], tgrid) * E[, b]
    }
    nv <- sqrt(l2_ip(v, v, tgrid))
    if (!is.finite(nv) || nv <= tol)
      stop("response basis is numerically degenerate")
    E[, a] <- v / nv
  }
  E
}

