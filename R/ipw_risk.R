# Exact risk of the IPW estimator and the local minimax constant
ipw_risk <- function(rho, Gamma, Sigma, n) {
  EY2 <- sum(Gamma^2) + sum(diag(Sigma))
  exact <- rep(NA, length(rho))
  pos <- rho > 0
  exact[pos] <- (EY2 / rho[pos] - rowSums(Gamma^2)[pos]) / n
  lam <- sum(diag(Sigma)) * sum(1 / rho[pos])
  list(exact_risk = exact, lam_constant = lam, lam_risk = lam / n)
}

