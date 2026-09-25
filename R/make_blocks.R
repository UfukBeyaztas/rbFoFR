# Disjoint block system
make_blocks <- function(centers = c(0.075, 0.445, 0.845), per_cluster = 2,
                        width = 0.03, gap = 0.06) {
  lower <- numeric(0)
  upper <- numeric(0)
  cl <- numeric(0)
  for (i in seq_along(centers)) {
    shift <- (seq_len(per_cluster) - (per_cluster + 1) / 2) * gap
    l <- centers[i] + shift - width / 2
    lower <- c(lower, l)
    upper <- c(upper, l + width)
    cl <- c(cl, rep(i, per_cluster))
  }
  if (any(lower <= 0) || any(upper >= 1))
    stop("all blocks must lie inside (0, 1)")
  o <- order(lower)
  K <- length(lower)
  blocks <- list(lower = lower[o], upper = upper[o], cluster = cl[o], K = K)
  if (K > 1 && any(blocks$lower[-1] <= blocks$upper[-K]))
    stop("blocks overlap")
  blocks
}

