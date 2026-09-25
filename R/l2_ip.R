# L2 inner product of two curves on a common grid
l2_ip <- function(f, g, grid) trapz(f * g, grid)

