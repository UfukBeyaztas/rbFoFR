# Smooth bump supported on [l, u]
bump_fun <- function(s, l, u) {
  z <- (2 * s - l - u) / (u - l)
  out <- numeric(length(s))
  inside <- abs(z) < 1
  out[inside] <- exp(-1 / (1 - z[inside]^2))
  out
}

