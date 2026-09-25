\name{information}
\alias{fisher_info}
\alias{ipw_risk}
\title{Fisher Information and Risk Benchmarks}
\description{
\code{fisher_info} computes the observed-data Fisher information at the zero
operator. \code{ipw_risk} computes the exact risk of the IPW estimator and
the local asymptotic minimax constant.
}
\usage{
fisher_info(rho, Sigma)

ipw_risk(rho, Gamma, Sigma, n)
}
\arguments{
  \item{rho}{co-observation probabilities of the directions.}
  \item{Sigma}{\eqn{d \times d}{d x d} error covariance.}
  \item{Gamma}{true coefficient matrix, with rows aligned with \code{rho}.
    Use \code{\link{truth_matrix}} to place the true coefficients in a
    dictionary.}
  \item{n}{sample size.}
}
\details{
Consider the Gaussian-error submodel with Rademacher scores. With the
coefficients stacked by interaction and then by response coordinate, the
information at \eqn{\Gamma = 0} is
\deqn{I(0) = \mathrm{diag}(\rho_{J_1},\dots,\rho_{J_M}) \otimes \Sigma^{-1}.}{I(0) = diag(rho_J1, ..., rho_JM) kronecker Sigma^{-1}.}
It is diagonal in the interaction index even when the sets overlap. This
follows from Walsh orthogonality, not from disjointness. Directions with
\eqn{\rho_J = 0} have zero information because their scores vanish
identically.

For resolvable directions, the local asymptotic minimax constant for squared
loss is \eqn{\mathrm{tr}\{I(0)^{-1}\} = \mathrm{tr}(\Sigma)\sum_J \rho_J^{-1}},
and the IPW estimator attains it. The exact risk of IPW for Rademacher
scores is
\deqn{E\|\hat g_J - g_J\|^2 = \frac{1}{n}\left\{\frac{\|\Gamma\|_F^2 + \mathrm{tr}(\Sigma)}{\rho_J} - \|g_J\|^2\right\}.}{E||ghat_J - g_J||^2 = { (||Gamma||_F^2 + tr(Sigma)) / rho_J - ||g_J||^2 } / n.}
Adding the squared norms of trimmed coefficients gives the continuous
reference risk used in the simulations. These are continuous-observation
values; a fixed grid slightly reduces the numerical availability of scores.
}
\value{
\code{fisher_info}: the \eqn{Md \times Md}{Md x Md} information matrix.

\code{ipw_risk}: a list with \code{exact_risk} (the risk of each direction,
\code{NA} when \eqn{\rho_J = 0}), \code{lam_constant}
(\eqn{\mathrm{tr}(\Sigma)\sum\rho_J^{-1}}) and \code{lam_risk}
(\code{lam_constant / n}).
}
\seealso{\code{\link{rbfit}}, \code{\link{classify_sets}}}
\examples{
\dontrun{
## Design 6: information constant tr(V) = 28.917
st <- design_setup(6)
rho <- sapply(st$J, rho_set, blocks = st$blocks, delta = st$delta)
I0 <- fisher_info(rho, st$Sigma)
sum(diag(solve(I0)))
ipw_risk(rho, st$Gamma, st$Sigma, n = 1)$lam_constant

## Monte Carlo check at the null: mean of n * ||Gamma_hat||^2
## over the five directions (IPW is computed direction by direction)
keys <- sapply(st$J, paste, collapse = ",")
n <- 800
loss <- replicate(100, {
  d0 <- sim_design(6, n = n, alternative = "null")
  g <- coef(rbfit(d0, qmax = 2, tau = 0.01))[keys, ]
  n * sum(g^2)
})
mean(loss)

## local alternative: signed error along H is centred at zero
proj <- replicate(100, {
  dl <- sim_design(6, n = n, alternative = "local")
  g <- coef(rbfit(dl, qmax = 2, tau = 0.01))[keys, ]
  sqrt(n) * sum((g - st$H / sqrt(n)) * st$H) / sqrt(sum(st$H^2))
})
mean(proj)

## Design 1: continuous IPW risks 1.478, 0.591 and 0.296
s1 <- design_setup(1)
cls <- classify_sets(s1$blocks, s1$delta, qmax = 2, tau = 0.01)
gt <- truth_matrix(cls$sets, s1$J, s1$Gamma)
sapply(c(200, 500, 1000), function(n)
  sum(ipw_risk(cls$rho, gt, s1$Sigma, n)$exact_risk[cls$rho >= 0.01]))
}
}
\keyword{math}
