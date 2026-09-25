\name{recover_all}
\alias{recover_all}
\title{Recover Visible Scores from Fragments}
\description{
Recovers, for each subject, the scores of the blocks revealed by the
subject's window.
}
\usage{
recover_all(data)
}
\arguments{
  \item{data}{an object of class \code{"rbdata"}.}
}
\details{
For \eqn{k \in K(a)}, the score is recovered exactly by the projection
\deqn{\xi_k = \frac{\langle M_a X, M_a\phi_k\rangle}{\|M_a\phi_k\|^2}.}{xi_k = <M_a X, M_a phi_k> / ||M_a phi_k||^2.}
The denominator is positive because \eqn{\phi_k > 0} inside its support,
and the disjoint supports make the projection exact.

On a grid, the inner products are computed by the trapezoidal rule. A score
is declared unavailable when the squared norm is at most \eqn{10^{-10}}.
Consequently, a block that is visible in continuous time can occasionally be
unavailable numerically, and the numerical availability satisfies
\eqn{\eta_J \le \rho_J}. Scores of blocks that are not revealed are returned
as \code{NA}; they are never imputed.
}
\value{
An \eqn{n \times K}{n x K} matrix of recovered scores, with \code{NA} where
a block is not visible.
}
\seealso{\code{\link{rbfit}}}
\examples{
\dontrun{
## Design 4: recovery error on visible scores is at round-off level
dat <- sim_design(4, n = 500, seed = 1)
xi <- recover_all(dat)
vis <- !is.na(xi)
max(abs(xi[vis] - dat$truth$xi[vis]))
colMeans(vis)   # proportion of subjects seeing each block
}
}
\keyword{manip}
