# Symmetric difference of two index sets
sym_diff <- function(J1, J2) sort(union(setdiff(J1, J2), setdiff(J2, J1)))

