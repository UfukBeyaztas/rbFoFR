\name{design_setup}
\alias{design_setup}
\title{Settings of the Seven Simulation Designs}
\description{
Returns the block system, grids, error covariance, score distribution, true
operator and tuning values of each simulation design in the paper.
}
\usage{
design_setup(design, delta = NULL)
}
\arguments{
  \item{design}{integer from 1 to 7.}
  \item{delta}{window length; used only in design 3, where it defaults to
    0.22.}
}
\details{
Designs 1--4, 6 and 7 share the following settings:
\itemize{
  \item \eqn{K = 6} bumps of width 0.03 centred at 0.045, 0.105, 0.415,
    0.475, 0.815 and 0.875;
  \item 301- and 81-point grids;
  \item \eqn{d = 2}, with error covariance \eqn{\Sigma} having variances
    0.60 and 0.40 and covariance 0.15;
  \item window length \eqn{\delta = 0.22}.
}
Coefficient rows are listed in the order of the index sets.
\describe{
  \item{Design 1 (resolvable nonlinear effects).}{Rademacher scores. The
    active sets are \{3\}, \{4\}, \{3,4\}, \{5,6\} and \{1,2\}, with rows
    (1,-0.4), (-0.7,0.5), (0.9,0.3), (-0.6,-0.8) and (0.5,0.2). Every active
    direction has \eqn{\rho_J > 0}. Uses \code{qmax = 2} and
    \eqn{n \in \{200, 500, 1000\}}.}
  \item{Design 2 (thresholding a rare interaction).}{The active sets are
    \{3\}, \{3,4\}, \{5,6\} and \{1,2\}, with rows (0.70,-0.25),
    (0.75,0.25), (-0.55,-0.65) and (0.95,0.35). Here
    \eqn{\rho_{\{1,2\}} = 1/13}, so thresholds 0.08 and 0.10 discard \{1,2\}
    and add squared bias 1.025. Uses
    \eqn{\tau \in \{0.005, 0.025, 0.05, 0.08, 0.10\}} (in
    \code{extra$tau_grid}) and \eqn{n \in \{100, 250, 500, 1000\}}.}
  \item{Design 3 (changing resolution).}{Uses the design 1 operator plus
    \eqn{\gamma_{\{1,2,3\}} = c} and \eqn{\gamma_{\{4,5,6\}} = -c}, with
    \eqn{c = (1,-0.5)}. Uses \code{qmax = 3},
    \eqn{\delta \in \{0.12, 0.22, 0.30, 0.38, 0.46, 1\}} (in
    \code{extra$delta_grid}) and \eqn{n \in \{300, 1000\}}. For
    \eqn{\delta \le 0.30}, the two cubic terms are non-resolvable and
    contribute omitted energy 2.5.}
  \item{Design 4 (Gaussian scores).}{Uses the design 3 operator at
    \eqn{\delta = 0.22} with standard normal scores, and
    \eqn{n \in \{250, 500, 1000, 2000\}}.}
  \item{Design 5 (full observation).}{\eqn{\delta = 1}, \eqn{K = 4} bumps
    of width 0.18 centred at 0.14, 0.38, 0.62 and 0.86, Gaussian scores,
    101- and 61-point grids, and \eqn{\Sigma = \mathrm{diag}(0.20, 0.16)}.
    Singleton effects with rows (0.65,0.15), (-0.55,0.20), (0.45,-0.15) and
    (-0.35,-0.10). Uses \code{qmax = 1} and
    \eqn{n \in \{100, 250, 500\}}.}
  \item{Design 6 (local information).}{Uses the five design 1 directions.
    The operator is zero or \eqn{H/\sqrt{n}}, where \eqn{H} (component
    \code{H}) has rows (0.70,-0.30), (-0.55,0.35), (0.65,0.20),
    (-0.45,-0.55) and (0.55,0.15). Uses
    \eqn{n \in \{200, 400, 800, 1600\}}. The information constant is
    \eqn{\mathrm{tr}(V) = 28.917}.}
  \item{Design 7 (equal laws and visible parity).}{The hypercube family
    \eqn{c(\sigma_1 W_{\{1,2,3\}} + \sigma_2 W_{\{4,5,6\}})} and the
    overlapping family \eqn{c(\sigma_1 W_{\{1,3\}} + \sigma_2 W_{\{1,2,3\}})},
    with \eqn{c = (1,-0.5)}. Both families are listed in \code{extra}.}
}
}
\value{
A list with components \code{design}, \code{blocks}, \code{delta},
\code{sgrid}, \code{tgrid}, \code{Sigma}, \code{scores}, \code{J} (true index
sets), \code{Gamma} (true coefficients), \code{H} (design 6 only),
\code{qmax}, \code{tau} and \code{extra} (design-specific grids and
families).
}
\seealso{\code{\link{sim_design}}}
\examples{
\dontrun{
st <- design_setup(3)
st$J
st$extra$delta_grid

## geometry of design 3 across window lengths
for (dl in st$extra$delta_grid) {
  rho <- sapply(st$J, rho_set, blocks = st$blocks, delta = dl)
  cat("delta =", dl, " p =", resolution_order(st$blocks, dl),
      " omitted energy =", sum(rowSums(st$Gamma^2)[rho == 0]), "\n")
}
}
}
\keyword{datagen}
