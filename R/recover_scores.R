# Recover the visible scores of one fragment
recover_scores <- function(xwin, a, blocks, delta, Phi, sgrid, tol = 1e-10) {
  xi <- rep(NA, blocks$K)
  vis <- reachable_blocks(a, blocks, delta)
  inwin <- !is.na(xwin)
  if (length(vis) == 0 || !any(inwin)) return(xi)
  s <- sgrid[inwin]
  x <- xwin[inwin]
  for (k in vis) {
    pk <- Phi[inwin, k]
    den <- trapz(pk * pk, s)
    if (den > tol) xi[k] <- trapz(x * pk, s) / den
  }
  xi
}

