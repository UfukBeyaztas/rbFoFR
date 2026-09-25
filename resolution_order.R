# Resolution order p
resolution_order <- function(blocks, delta) {
  lo <- blocks$lower - delta
  hi <- blocks$upper
  pts <- sort(unique(c(lo, hi, 0, 1 - delta)))
  pts <- pts[pts >= 0 & pts <= 1 - delta]
  m <- length(pts)
  cand <- unique(c(pts, (pts[-1] + pts[-m]) / 2))
  max(sapply(cand, function(a) sum(a > lo & a < hi)))
}

