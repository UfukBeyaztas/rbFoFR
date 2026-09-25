# Place the true coefficients in the fitted dictionary
truth_matrix <- function(sets, Jtrue, Gtrue) {
  keys <- sapply(sets, set_key)
  tkeys <- sapply(Jtrue, set_key)
  idx <- match(tkeys, keys)
  if (anyNA(idx)) stop("a true direction is not in the fitted dictionary")
  gt <- matrix(0, length(sets), ncol(Gtrue))
  gt[idx, ] <- Gtrue
  gt
}

