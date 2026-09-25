# Measure of the order-r co-observation band
band_measure <- function(r, delta) {
  if (any(delta < 0 | delta > 1)) stop("'delta' must lie in [0, 1]")
  r * delta^(r - 1) - (r - 1) * delta^r
}

