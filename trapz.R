# Trapezoidal rule
trapz <- function(y, x) {
  if (length(y) != length(x)) stop("'y' and 'x' must have the same length")
  ok <- is.finite(y)
  y <- y[ok]
  x <- x[ok]
  m <- length(x)
  if (m < 2) return(0)
  sum(diff(x) * (y[-1] + y[-m]) / 2)
}

