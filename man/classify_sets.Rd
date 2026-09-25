\name{classify_sets}
\alias{classify_sets}
\alias{hypercube_check}
\title{Resolution Status of Interactions and the Hypercube Conditions}
\description{
\code{classify_sets} computes \eqn{\rho_J} for every interaction up to a
given order. It splits them into estimated, trimmed and non-resolvable
directions. \code{hypercube_check} checks whether a family of interactions
satisfies the conditions of the equal-law hypercube construction.
}
\usage{
classify_sets(blocks, delta, qmax = 2, tau = 0.01)

hypercube_check(Jlist, blocks, delta)
}
\arguments{
  \item{blocks}{block system from \code{\link{make_blocks}}.}
  \item{delta}{window length.}
  \item{qmax}{largest interaction order.}
  \item{tau}{threshold on the co-observation probability.}
  \item{Jlist}{list of index sets.}
}
\details{
The conditional mean of the response given the fragment identifies exactly
the coefficients \eqn{g_J} with \eqn{\rho_J > 0}. At the zero operator, the
Fisher information over all \eqn{2^K} directions has rank \eqn{d} times the
number of resolvable sets. Its kernel consists exactly of the directions
with \eqn{\rho_J = 0}. \code{classify_sets} returns this partition, with the
resolvable directions further split at the threshold \eqn{\tau}.

A direction with \eqn{\rho_J = 0} is absent from the conditional mean. By
itself, this does not make it invisible to the full observed law:
overlapping hidden directions can leave parity information in the
conditional covariance (see \code{\link{parity_stat}}).

A global impossibility result holds under the following conditions. The sets
\eqn{J_1,\dots,J_m} must be pairwise disjoint and share a common order
\eqn{q > p}. Then, for any symmetric scores (Rademacher or Gaussian), the
\eqn{2^m} operators \eqn{G_\sigma = c\sum_i \sigma_i W_{J_i}} have identical
observed-data laws. Moreover, for every \eqn{n},
\deqn{\max_\sigma E\|\hat G - G_\sigma\|^2 \ge \|c\|^2 m.}{max_sigma E||Ghat - G_sigma||^2 >= ||c||^2 m.}
\code{hypercube_check} verifies these conditions.
}
\value{
\code{classify_sets}: a list with the dictionary \code{sets} and its
\code{keys}, the named vector \code{rho}, the keys of the \code{estimated},
\code{trimmed} and \code{nonresolvable} directions, \code{tau}, and the
resolution order \code{p}.

\code{hypercube_check}: a list with \code{valid} (all conditions hold),
\code{m}, \code{q}, \code{p}, \code{disjoint} and \code{same_order}.
}
\seealso{\code{\link{rho_set}}, \code{\link{rbfit}},
\code{\link{fisher_info}}}
\examples{
\dontrun{
blocks <- make_blocks()
cls <- classify_sets(blocks, delta = 0.22, qmax = 3, tau = 0.01)
cls$p
cls$estimated
length(cls$nonresolvable)

## design 2: the pair {1,2} is trimmed once tau exceeds 1/13
classify_sets(blocks, 0.22, qmax = 2, tau = 0.08)$trimmed

## design 7: the disjoint cubic family satisfies the hypercube conditions
hypercube_check(list(c(1, 2, 3), c(4, 5, 6)), blocks, delta = 0.22)$valid
## ... but not after the window grows to 0.38 (p becomes 3)
hypercube_check(list(c(1, 2, 3), c(4, 5, 6)), blocks, delta = 0.38)$valid
}
}
\keyword{math}
