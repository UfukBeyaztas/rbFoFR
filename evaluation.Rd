\name{evaluation}
\alias{evaluate_fit}
\alias{operator_error}
\alias{truth_matrix}
\alias{prediction_error}
\alias{curve_mise}
\title{Operator and Prediction Errors}
\description{
Error measures that separate operator recovery from prediction from a
fragment.
}
\usage{
evaluate_fit(fit, test, Jtrue, Gtrue)

operator_error(fit, Jtrue, Gtrue)

truth_matrix(sets, Jtrue, Gtrue)

prediction_error(Yhat, Y)

curve_mise(pred, truth, grid)
}
\arguments{
  \item{fit}{an object of class \code{"rbfit"}.}
  \item{test}{an \code{"rbdata"} object with independent test subjects.}
  \item{Jtrue, Gtrue}{true index sets and coefficient matrix, for example
    \code{setup$J} and \code{setup$Gamma} of \code{\link{sim_design}}.}
  \item{sets}{list of index sets of a dictionary.}
  \item{Yhat, Y}{matrices of predicted and observed response coordinates.}
  \item{pred, truth}{matrices of predicted and true curves, one row per
    subject.}
  \item{grid}{grid on which the curves are tabulated.}
}
\details{
Because the Walsh functionals and the response basis are orthonormal, the
operator loss is
\eqn{L_{op} = \|\hat G - G\|^2_{L^2(P_X)} = \sum_J \|\hat\gamma_J - \gamma_J\|^2}.
Coefficients are extended by zero outside the dictionary.
\code{operator_error} splits this loss into three parts:
\itemize{
  \item the estimated directions (\eqn{\rho_J \ge \tau});
  \item the trimmed directions (\eqn{0 < \rho_J < \tau});
  \item the non-resolvable directions (\eqn{\rho_J = 0}).
}
For the truncated estimators, the last two parts are exactly the threshold
bias and the energy absent from the conditional mean.

\code{evaluate_fit} also computes the fragment-signal loss
\eqn{L_{sig} = N^{-1}\sum_i \|\hat m_i - m_i\|^2}. Here
\eqn{m_i = \sum_J \gamma_J Z_{iJ}} is the true signal that is visible in test
subject \eqn{i}'s fragment. It also computes the response loss and the
response loss relative to the mean predictor. A low fragment-signal loss can
coexist with a large operator loss.

\code{curve_mise} is the mean integrated squared error between curves,
computed by the trapezoidal rule. It is used in design 5.
}
\value{
\code{evaluate_fit}: a named vector with \code{operator_total},
\code{operator_estimated}, \code{operator_threshold},
\code{operator_nonresolvable}, \code{fragment_signal_mse},
\code{response_mse} and \code{response_relative}.

\code{operator_error}: a list with \code{total}, \code{estimated},
\code{threshold}, \code{nonresolvable}, \code{nonresolvable_truth} (the true
energy of the non-resolvable directions) and \code{per_set}.

\code{truth_matrix}: the true coefficients aligned with \code{sets}.

\code{prediction_error}: a list with \code{mse}, \code{baseline} and
\code{relative}.

\code{curve_mise}: a number.
}
\seealso{\code{\link{rbfit}}, \code{\link{predict.rbfit}}}
\examples{
\dontrun{
## Design 3 at delta = 0.22: large operator loss, small fragment loss
R <- 20
res <- t(replicate(R, {
  tr <- sim_design(3, n = 1000, delta = 0.22)
  te <- sim_design(3, n = 1000, delta = 0.22)
  f <- rbfit(tr, qmax = 3, tau = 0.01)
  evaluate_fit(f, te, tr$setup$J, tr$setup$Gamma)
}))
colMeans(res)[c("operator_total", "operator_nonresolvable",
                "fragment_signal_mse")]

## Design 1: error of each direction
dat <- sim_design(1, n = 1000, seed = 1)
fit <- rbfit(dat, qmax = 2)
round(operator_error(fit, dat$setup$J, dat$setup$Gamma)$per_set, 4)
}
}
\keyword{regression}
