# All subsets of 1:K with at most qmax elements (empty set included)
all_subsets <- function(K, qmax = K) {
  out <- list(integer(0))
  for (q in seq_len(min(qmax, K))) {
    out <- c(out, utils::combn(K, q, simplify = FALSE))
  }
  out
}

