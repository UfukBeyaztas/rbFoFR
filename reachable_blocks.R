# Blocks reachable from a window starting at a
reachable_blocks <- function(a, blocks, delta) {
  which(a > blocks$lower - delta & a < blocks$upper)
}

