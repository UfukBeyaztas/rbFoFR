\name{parity_stat}
\alias{parity_stat}
\title{Visible Parity Statistic}
\description{
Computes a statistic from the second conditional moment that reveals the
product of the signs of two overlapping non-resolvable interactions.
}
\usage{
parity_stat(data, Jpair, component = 1)
}
\arguments{
  \item{data}{an object of class \code{"rbdata"}.}
  \item{Jpair}{list of two index sets \eqn{J_1} and \eqn{J_2}.}
  \item{component}{response coordinate used.}
}
\details{
Non-resolvability (\eqn{\rho_J = 0}) removes a direction from the
conditional mean, but not necessarily from the full observed law. Suppose
\eqn{G = c(\sigma_1 W_{J_1} + \sigma_2 W_{J_2})} with Rademacher scores, and
the symmetric difference \eqn{J_1 \triangle J_2} is resolvable. Then the
conditional covariance of the response depends on \eqn{\sigma_1\sigma_2}.
The statistic
\deqn{T_n = \frac{\sum_i B_i (Y^\star_{i})^2 \prod_{k \in J_1\triangle J_2}\hat\xi_{ik}}{\sum_i B_i},}{T_n = sum_i B_i Y_i^2 prod_{k in J1 symdiff J2} xi_ik / sum_i B_i,}
where \eqn{B_i} indicates that the symmetric difference is observed,
converges to \eqn{2c^2\sigma_1\sigma_2}. The joint flip
\eqn{(\sigma_1,\sigma_2) \to (-\sigma_1,-\sigma_2)} leaves the observed law
unchanged. In contrast, for disjoint families satisfying
\code{\link{hypercube_check}}, no such statistic exists, because all
\eqn{2^m} sign patterns give the same observed law.
}
\value{
A list with \code{statistic} (\eqn{T_n}), \code{sym_diff} (the symmetric
difference), \code{rho} (its co-observation probability) and \code{n_seen}
(the number of subjects who observe it).
}
\seealso{\code{\link{hypercube_check}}, \code{\link{sim_design}}}
\examples{
\dontrun{
## Design 7, overlapping family {1,3}, {1,2,3}: T_n -> 2 * sigma1 * sigma2
Jpair <- list(c(1, 3), c(1, 2, 3))
for (sg in list(c(1, 1), c(1, -1), c(-1, 1), c(-1, -1))) {
  dat <- sim_design(7, n = 30000, family = "overlap", signs = sg, seed = 1)
  cat(sg, " T_n =", round(parity_stat(dat, Jpair)$statistic, 3),
      " expected =", 2 * prod(sg), "\n")
}

## Design 7, hypercube family: the two antipodal vertices give the same law
for (sg in list(c(1, 1), c(-1, -1))) {
  dat <- sim_design(7, n = 1000, family = "hypercube", signs = sg, seed = 2)
  y <- dat$truth$Ystar[, 1]
  cat(sg, " mean =", round(mean(y), 3), " var =", round(var(y), 3), "\n")
}
}
}
\keyword{htest}
