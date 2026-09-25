\name{rbfit}
\alias{rbfit}
\alias{print.rbfit}
\alias{coef.rbfit}
\title{Resolution-Aware Estimation of the Identifiable Component}
\description{
Estimates the Walsh coefficients \eqn{g_J} of all interactions of order at
most \code{qmax} whose co-observation probability is at least \code{tau}.
The remaining directions are set to zero. They are reported separately as
trimmed or non-resolvable. This is Algorithm 2 of the paper.
}
\usage{
rbfit(data, qmax = 2, tau = 0.01, method = c("ipw", "ratio"))

\method{print}{rbfit}(x, digits = 3, \dots)

\method{coef}{rbfit}(object, \dots)
}
\arguments{
  \item{data}{an object of class \code{"rbdata"}, created by
    \code{\link{rbdata}}, \code{\link{gen_fofr}} or \code{\link{sim_design}}.}
  \item{qmax}{largest interaction order in the dictionary.}
  \item{tau}{threshold on the co-observation probability; directions with
    \eqn{\rho_J \ge \tau} are estimated.}
  \item{method}{\code{"ipw"} for the inverse-probability weighted estimator
    (known window law), or \code{"ratio"} for the complete-case ratio
    estimator (unknown window law).}
  \item{x, object}{an object of class \code{"rbfit"}.}
  \item{digits}{number of digits printed.}
  \item{\dots}{not used.}
}
\details{
The dictionary contains all \eqn{J \subseteq \{1,\dots,K\}} with
\eqn{|J| \le} \code{qmax}, including the empty set (the intercept). It is
split into three groups: \eqn{J_\tau = \{\rho_J \ge \tau\}}, the trimmed set
\eqn{\{0 < \rho_J < \tau\}}, and the non-resolvable set
\eqn{\{\rho_J = 0\}}.

For each subject, the visible scores are recovered from the masked curve by
\eqn{\xi_k = \langle M_a X, M_a\phi_k\rangle / \|M_a\phi_k\|^2}
(see \code{\link{recover_all}}). Invisible scores are never imputed. The
response is represented by its coordinates \eqn{Y^\star} on the response
basis. With \eqn{\Delta_{iJ} = 1\{J \subseteq K(A_i)\}}, the two estimators
are
\deqn{\hat g_J = \frac{1}{n\rho_J}\sum_{i=1}^n \Delta_{iJ} Y^\star_i W_J(X_i),
\qquad
\tilde g_J = \frac{\sum_i \Delta_{iJ} Y^\star_i W_J(X_i)}{\sum_i \Delta_{iJ}},}{ghat_J = sum_i Delta_iJ Y_i W_J(X_i) / (n rho_J),   gtilde_J = sum_i Delta_iJ Y_i W_J(X_i) / sum_i Delta_iJ,}
with \eqn{\tilde g_J = 0} when no subject observes \eqn{J}.

The IPW estimator is unbiased for \eqn{g_J}, with risk
\eqn{n^{-1}\{\rho_J^{-1} E\|Y\|^2 W_J^2 - \|g_J\|^2\}}. Near the zero
operator it attains the local asymptotic minimax constant
\eqn{\mathrm{tr}(\Sigma)\sum_J \rho_J^{-1}}. The ratio estimator has the same
local limit, but it is biased at finite \eqn{n} by the factor
\eqn{1-(1-\rho_J)^n}.

The truncated fit satisfies the exact decomposition
\deqn{E\|\hat G_\tau - G\|^2 = \sum_{J \in J_\tau} E\|\hat g_J - g_J\|^2
+ \sum_{0<\rho_J<\tau} \|g_J\|^2 + \sum_{\rho_J = 0} \|g_J\|^2.}{E||Ghat - G||^2 = stochastic + threshold bias + non-resolvable energy.}
The three terms are the stochastic error, the threshold bias, and the energy
absent from the conditional mean. Only the first term decreases with
\eqn{n}.

Because each coefficient is estimated separately, the estimate of a given
direction does not depend on which other directions are in the dictionary.
}
\value{
An object of class \code{"rbfit"}, a list with components:
\item{coefficients}{matrix of estimated coefficients, one row per dictionary
  set (row names are set keys, with \code{"{}"} for the intercept) and one
  column per response basis function.}
\item{method}{the estimator used.}
\item{sets, keys}{the dictionary, as a list of index sets and as keys.}
\item{rho}{co-observation probabilities of the dictionary sets.}
\item{kept}{logical, \code{rho >= tau}.}
\item{report}{list with the keys of the \code{estimated}, \code{trimmed} and
  \code{nonresolvable} directions.}
\item{p}{resolution order.}
\item{qmax, tau, delta, n}{settings and sample size.}
\item{xihat, D, features}{recovered scores, observability indicators and
  observed Walsh features.}
\code{coef} returns the coefficient matrix. \code{print} shows a summary and
the estimated coefficients.
}
\seealso{
\code{\link{predict.rbfit}}, \code{\link{evaluate_fit}},
\code{\link{classify_sets}}, \code{\link{ipw_risk}}
}
\examples{
\dontrun{
## Design 1: all active directions are resolvable
train <- sim_design(1, n = 1000, seed = 1)
fit <- rbfit(train, qmax = 2, tau = 0.01, method = "ipw")
fit
coef(fit)
fit$report$trimmed

## unknown window law: complete-case ratio estimator
fit_ratio <- rbfit(train, qmax = 2, tau = 0.01, method = "ratio")

## Design 3 at delta = 0.22: the cubic terms {1,2,3} and {4,5,6} are
## non-resolvable and are reported, not estimated
dat <- sim_design(3, n = 1000, delta = 0.22, seed = 2)
fit3 <- rbfit(dat, qmax = 3, tau = 0.01)
fit3$p
c("1,2,3", "4,5,6") \%in\% fit3$report$nonresolvable

## Design 2: the same sample under the threshold grid of the paper
dat2 <- sim_design(2, n = 500, seed = 3)
st <- dat2$setup
for (tau in st$extra$tau_grid) {
  f <- rbfit(dat2, qmax = 2, tau = tau)
  err <- operator_error(f, st$J, st$Gamma)
  cat("tau =", tau, " kept =", sum(f$kept),
      " loss =", round(err$total, 3),
      " threshold bias =", round(err$threshold, 3), "\n")
}
}
}
\keyword{regression}
