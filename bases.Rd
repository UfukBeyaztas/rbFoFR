\name{bases}
\alias{phi_basis}
\alias{response_basis}
\title{Predictor and Response Bases}
\description{
\code{phi_basis} tabulates the localized orthonormal predictor functions
\eqn{\phi_1,\dots,\phi_K}. \code{response_basis} tabulates an orthonormal
response basis \eqn{e_1,\dots,e_d}.
}
\usage{
phi_basis(blocks, sgrid)

response_basis(d, tgrid, tol = 1e-10)
}
\arguments{
  \item{blocks}{block system from \code{\link{make_blocks}}.}
  \item{sgrid, tgrid}{predictor and response grids.}
  \item{d}{number of response basis functions.}
  \item{tol}{tolerance for numerical degeneracy in the Gram--Schmidt
    step.}
}
\details{
Each \eqn{\phi_k} is a normalized \eqn{C^\infty} bump,
\eqn{\phi_k(s) \propto \exp\{-1/(1-z^2)\}} for \eqn{|z|<1}, where \eqn{z}
maps \eqn{I_k} onto \eqn{(-1,1)}. It is zero off \eqn{I_k}, positive inside,
and has unit \eqn{L^2} norm. Since the supports are disjoint, the system is
orthonormal and \eqn{\langle X, \phi_k \rangle = \xi_k}. Positivity inside
\eqn{I_k} is what allows a revealed score to be recovered from a partial
view of its support.

The response basis starts with the constant function, followed by
\eqn{\cos(2\pi t)}, \eqn{\sin(2\pi t)}, \eqn{\cos(4\pi t)}, and so on. The
functions are orthonormalized with the trapezoidal inner product. For
\eqn{d = 2}, this gives \eqn{e_1 = 1} and
\eqn{e_2 = \sqrt{2}\cos(2\pi t)}, as in the simulations.
}
\value{
\code{phi_basis}: a \code{length(sgrid)} by \eqn{K} matrix.
\code{response_basis}: a \code{length(tgrid)} by \eqn{d} matrix.
}
\seealso{\code{\link{make_blocks}}, \code{\link{rbdata}}}
\examples{
\dontrun{
sgrid <- seq(0, 1, length.out = 301)
Phi <- phi_basis(make_blocks(), sgrid)
matplot(sgrid, Phi, type = "l", lty = 1)

E <- response_basis(2, seq(0, 1, length.out = 81))
}
}
\keyword{manip}
