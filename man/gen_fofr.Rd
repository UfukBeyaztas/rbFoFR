\name{gen_fofr}
\alias{gen_fofr}
\title{Generate Data from the Localized-Score Model}
\description{
Simulates fragmented predictors and response curves from the finite
multilinear model with localized predictor basis and Gaussian errors.
}
\usage{
gen_fofr(n, blocks, delta, sgrid, tgrid, Jlist, Gamma, Sigma,
         scores = c("rademacher", "gaussian"),
         Phi = NULL, E = NULL, seed = NULL)
}
\arguments{
  \item{n}{sample size.}
  \item{blocks}{block system from \code{\link{make_blocks}}.}
  \item{delta}{window length in \eqn{(0,1]}.}
  \item{sgrid, tgrid}{predictor and response grids.}
  \item{Jlist}{list of index sets of the active interactions; use
    \code{integer(0)} for the intercept.}
  \item{Gamma}{coefficient matrix with one row per element of \code{Jlist}
    and \eqn{d} columns.}
  \item{Sigma}{\eqn{d \times d}{d x d} covariance matrix of the error
    coordinates.}
  \item{scores}{distribution of the scores: \code{"rademacher"}
    (\eqn{\pm 1} with probability 1/2) or \code{"gaussian"} (standard
    normal).}
  \item{Phi, E}{optional predictor and response bases.}
  \item{seed}{optional random seed.}
}
\details{
The data are generated from
\deqn{X_i = \sum_{k=1}^K \xi_{ik}\phi_k, \qquad
Y^\star_i = \sum_{j} \gamma_{J_j} W_{J_j}(X_i) + \varepsilon_i, \qquad
Y_i(t) = e(t)^\top Y^\star_i,}{X_i = sum_k xi_ik phi_k,  Y*_i = sum_j gamma_Jj W_Jj(X_i) + eps_i,  Y_i(t) = e(t)' Y*_i,}
where \eqn{\varepsilon_i \sim N_d(0,\Sigma)}. Windows start at
\eqn{A_i \sim U[0,1-\delta]}, independently of the scores, and
\eqn{A_i = 0} when \eqn{\delta = 1}.

With Gaussian scores, \eqn{X} is a Gaussian process with
\eqn{C^\infty} paths. The resolution barrier holds for any symmetric scores,
so it is not an artifact of the Rademacher case.

The latent quantities are returned in \code{truth} for evaluation only. The
estimators never use them.
}
\value{
An object of class \code{"rbdata"} with an extra component \code{truth}, a
list containing the scores \code{xi}, the full curves \code{Xfull}, the
Walsh features \code{W}, the conditional mean coordinates \code{mu}, the
response coordinates \code{Ystar}, and \code{Jlist}, \code{Gamma},
\code{Sigma} and \code{scores}.
}
\seealso{\code{\link{sim_design}}, \code{\link{rbdata}}}
\examples{
\dontrun{
## a design of your own: one resolvable pair and one hidden triple
blocks <- make_blocks()
sgrid <- seq(0, 1, length.out = 301)
tgrid <- seq(0, 1, length.out = 81)
J <- list(c(3, 4), c(1, 2, 3))
G <- rbind(c(1, 0.5), c(0.8, -0.4))
dat <- gen_fofr(500, blocks, delta = 0.22, sgrid, tgrid, J, G,
                Sigma = diag(c(0.6, 0.4)), seed = 1)
sapply(J, rho_set, blocks = blocks, delta = 0.22)
}
}
\keyword{datagen}
