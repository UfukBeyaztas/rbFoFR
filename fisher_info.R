# Fisher information at the null
fisher_info <- function(rho, Sigma) {
  kronecker(diag(rho, nrow = length(rho)), solve(Sigma))
}

