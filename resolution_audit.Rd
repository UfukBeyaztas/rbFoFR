\name{resolution_audit}
\alias{resolution_audit}
\title{Resolution Audit of a Uniform Window Design}
\description{
For each interaction order \eqn{r = 1, \dots, Q}, reports the volume of
tuples whose co-observation probability is at least \code{tau}, next to the
unthresholded band volume. It then returns the largest order that meets a
coverage criterion.
}
\usage{
resolution_audit(delta, Q = 5, tau = 0.05, floor_prop = 0.02,
                 nmc = 20000, seed = NULL)
}
\arguments{
  \item{delta}{window length.}
  \item{Q}{largest order examined.}
  \item{tau}{threshold on the co-observation probability.}
  \item{floor_prop}{minimum thresholded volume for an order to be counted
    as supported.}
  \item{nmc}{number of Monte Carlo points per order.}
  \item{seed}{optional random seed.}
}
\details{
Under uniform windows of length \eqn{\delta}, the function estimates the
volume \eqn{V_r(\tau) = \lambda_r\{s : \rho_r(s) \ge \tau\}} by Monte Carlo.
It returns the volume for each order together with the band volume
\eqn{r\delta^{r-1}-(r-1)\delta^r}, and \eqn{r^\ast}, the largest order whose thresholded volume is at least
\code{floor_prop}.

The thresholded volume has the closed form
\eqn{V_r(\tau) = rLb^{r-1} - (r-1)b^r}. Here \eqn{t = \tau(1-\delta)},
\eqn{L = 1-2t} and \eqn{b = \delta - t}. This closed form can be used to
check the Monte Carlo value; at \eqn{\delta = 0.30} and \eqn{\tau = 0.05} it
gives 0.4227, 0.1587, 0.0544 and 0.0177 for orders 2 to 5. A positive
threshold lowers the volume even when all windows have the same length.

The value \eqn{r^\ast} describes direct co-observation under the chosen
threshold. It does not say which orders are identified. Identification is
decided by \eqn{\rho_J} and the resolution order (see
\code{\link{classify_sets}}). This function audits the controlled uniform
design; the empirical interval audit of the paper (Algorithm 1) works from
recorded interval endpoints.
}
\value{
A list with components \code{table} (a data frame with columns
\code{order}, \code{reachable} and \code{band}), \code{r_star}, \code{tau}
and \code{floor_prop}.
}
\seealso{\code{\link{band_measure}}, \code{\link{classify_sets}}}
\examples{
\dontrun{
aud <- resolution_audit(delta = 0.30, Q = 5, tau = 0.05,
                        nmc = 200000, seed = 1)
aud$table
aud$r_star

## closed-form benchmark for comparison
t0 <- 0.05 * (1 - 0.30); L <- 1 - 2 * t0; b <- 0.30 - t0
sapply(2:5, function(r) r * L * b^(r - 1) - (r - 1) * b^r)
}
}
\keyword{math}
