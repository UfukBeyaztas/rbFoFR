\name{rbdata}
\alias{rbdata}
\title{Fragmented Function-on-Function Data}
\description{
Collects fragmented predictor curves, response curves, window starts and the
localized design into one object of class \code{"rbdata"}. This object is
the input of \code{\link{rbfit}}.
}
\usage{
rbdata(Xwin, Y, A, sgrid, tgrid, blocks, delta, d = 2, Phi = NULL, E = NULL)
}
\arguments{
  \item{Xwin}{\eqn{n \times}{n x} \code{length(sgrid)} matrix of predictor
    values, with \code{NA} outside each subject's window.}
  \item{Y}{\eqn{n \times}{n x} \code{length(tgrid)} matrix of response
    curves.}
  \item{A}{vector of window starting points, in \eqn{[0, 1-\delta]}.}
  \item{sgrid, tgrid}{predictor and response grids on \eqn{[0,1]}.}
  \item{blocks}{block system from \code{\link{make_blocks}}.}
  \item{delta}{window length.}
  \item{d}{number of response basis functions; used when \code{E} is
    \code{NULL}.}
  \item{Phi}{optional predictor basis; by default
    \code{phi_basis(blocks, sgrid)}.}
  \item{E}{optional orthonormal response basis; by default
    \code{response_basis(d, tgrid)}.}
}
\details{
Subject \eqn{i} contributes the observed datum
\eqn{D_i = (A_i, M_{A_i}X_i, Y_i)}. The masking operator \eqn{M_a} keeps
the predictor on \eqn{[a, a+\delta]}.

The fitting functions assume the following:
\itemize{
  \item the window start is independent of the predictor and the error;
  \item window starts are uniform on \eqn{[0,1-\delta]}; this is used to
    compute \eqn{\rho_J} for the IPW estimator;
  \item the localized system \eqn{\{\phi_k\}} is known.
}
When \code{delta = 1}, all curves are fully observed and \code{A} should be
zero.
}
\value{
An object of class \code{"rbdata"}: a list with components \code{n},
\code{A}, \code{Xwin}, \code{Y}, \code{sgrid}, \code{tgrid}, \code{delta},
\code{blocks}, \code{Phi} and \code{E}.
}
\seealso{\code{\link{gen_fofr}}, \code{\link{sim_design}}, \code{\link{rbfit}}}
\examples{
\dontrun{
## wrap fragments produced elsewhere (here taken from a simulated sample)
sim <- sim_design(1, n = 300, seed = 1)
dat <- rbdata(Xwin = sim$Xwin, Y = sim$Y, A = sim$A,
              sgrid = sim$sgrid, tgrid = sim$tgrid,
              blocks = sim$blocks, delta = sim$delta, d = 2)
rbfit(dat, qmax = 2)
}
}
\keyword{datasets}
