# Check the hypercube conditions
hypercube_check <- function(Jlist, blocks, delta) {
  m <- length(Jlist)
  q <- unique(sapply(Jlist, length))
  disjoint <- TRUE
  if (m > 1) {
    for (i in 1:(m - 1)) {
      for (j in (i + 1):m) {
        if (length(intersect(Jlist[[i]], Jlist[[j]])) > 0) disjoint <- FALSE
      }
    }
  }
  p <- resolution_order(blocks, delta)
  same_order <- length(q) == 1
  list(valid = same_order && disjoint && q[1] > p,
       m = m, q = q, p = p, disjoint = disjoint, same_order = same_order)
}

