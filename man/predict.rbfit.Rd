\name{predict.rbfit}
\alias{predict.rbfit}
\title{Prediction from a Fragment}
\description{
Predicts the responses of new subjects from their own observed fragments,
using a fitted \code{"rbfit"} object.
}
\usage{
\method{predict}{rbfit}(object, newdata, \dots)
}
\arguments{
  \item{object}{an object of class \code{"rbfit"}.}
  \item{newdata}{an object of class \code{"rbdata"} with the new fragments.}
  \item{\dots}{not used.}
}
\details{
For a new subject, the prediction is
\eqn{\hat m = \sum_J \hat g_J Z_J}. Here \eqn{Z_J} is the product of the
recovered scores in \eqn{J} when the new window reveals all of them, and zero
otherwise.

Directions that the new window does not reveal have conditional mean zero
given the fragment, so the best fragment predictor omits them. As a
consequence, prediction and operator recovery are different targets: a fit
can predict well from fragments while leaving the non-resolvable part of the
operator completely unknown.
}
\value{
A list with components
\item{Ystar}{\eqn{n \times d}{n x d} matrix of predicted response
  coordinates.}
\item{Y}{\eqn{n \times}{n x} \code{length(tgrid)} matrix of predicted
  response curves.}
}
\seealso{\code{\link{rbfit}}, \code{\link{evaluate_fit}}}
\examples{
\dontrun{
## Design 5: fully observed curves (delta = 1), Gaussian scores
train <- sim_design(5, n = 500, seed = 1)
test <- sim_design(5, n = 500, seed = 2)
fit <- rbfit(train, qmax = 1, tau = 0.01)
pr <- predict(fit, test)

## integrated squared error against the latent signal G(X)
truth <- test$truth$mu \%*\% t(test$E)
curve_mise(pr$Y, truth, test$tgrid)
}
}
\keyword{regression}
