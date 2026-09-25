\name{coobservation}
\alias{band_measure}
\alias{rho_r}
\alias{rho_set}
\alias{resolution_order}
\title{Co-Observation Geometry}
\description{
Functions that describe what a window of length \eqn{\delta} can observe
jointly:
\itemize{
  \item the volume of the order-\eqn{r} co-observation band;
  \item the co-observation probability of a tuple of locations or of an
    index set;
  \item the resolution order \eqn{p}.
}
}
\usage{
band_measure(r, delta)

rho_r(s, delta)

rho_set(J, blocks, delta)

resolution_order(blocks, delta)
}
\arguments{
  \item{r}{interaction order (may be a vector).}
  \item{delta}{window length in \eqn{[0,1]}.}
  \item{s}{numeric vector of locations in \eqn{[0,1]}.}
  \item{J}{index set, a vector of block indices.}
  \item{blocks}{block system from \code{\link{make_blocks}}.}
}
\details{
The band \eqn{B_r(\delta)} contains the tuples of \eqn{r} locations whose
range is at most \eqn{\delta}. Its volume is
\deqn{\lambda_r\{B_r(\delta)\} = r\delta^{r-1} - (r-1)\delta^r.}{lambda_r(B_r(delta)) = r delta^(r-1) - (r-1) delta^r.}
This decreases geometrically in \eqn{r}. For example, at
\eqn{\delta = 0.2}, the values for orders 2 to 5 are 36\%, 10.4\%, 2.72\% and
0.672\%.

For window starts that are uniform on \eqn{[0,1-\delta]}, the probability
that one window contains all of \code{s} is
\deqn{\rho_r(s) = \frac{\{\min(s_{(1)}, 1-\delta) - \max(s_{(r)}-\delta, 0)\}_+}{1-\delta}.}{rho_r(s) = [min(s_min, 1-delta) - max(s_max - delta, 0)]_+ / (1-delta).}
For \eqn{r \ge 2}, \eqn{1/\rho_r} is not integrable over the band, which is
why the estimators use a positive threshold.

A window starting at \eqn{a} reveals block \eqn{k} when
\eqn{a \in (l_k - \delta, u_k)}. So
\deqn{\rho_J = \frac{|(\max_{k\in J}(l_k-\delta),\ \min_{k\in J} u_k) \cap [0, 1-\delta]|}{1-\delta},}{rho_J = |(max_k (l_k - delta), min_k u_k) intersect [0, 1-delta]| / (1-delta),}
computed exactly, and \eqn{\rho_\emptyset = 1}.

The resolution order \eqn{p = \sup_a |K(a)|} is the largest number of blocks
revealed by one window. It is computed exactly by sweeping the interval
endpoints. Every interaction of order larger than \eqn{p} is
non-resolvable.
}
\value{
\code{band_measure}: the band volume. \code{rho_r} and \code{rho_set}: a
probability. \code{resolution_order}: an integer.
}
\seealso{\code{\link{classify_sets}}, \code{\link{resolution_audit}}}
\examples{
\dontrun{
## band volumes at delta = 0.2
round(band_measure(2:5, 0.2), 4)

rho_r(c(0.30, 0.40), delta = 0.22)

blocks <- make_blocks()
rho_set(c(1, 2), blocks, 0.22)     # 1/13, the rare pair of design 2
rho_set(c(1, 2, 3), blocks, 0.22)  # 0: non-resolvable
resolution_order(blocks, 0.22)     # p = 2
resolution_order(blocks, 0.38)     # p = 3
}
}
\keyword{math}
