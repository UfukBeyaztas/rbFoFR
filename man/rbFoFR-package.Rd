\name{rbFoFR-package}
\alias{rbFoFR-package}
\alias{rbFoFR}
\docType{package}
\title{Nonlinear Function-on-Function Regression from Fragments}
\description{
Tools for nonlinear function-on-function regression when each predictor curve
is observed only on a window \eqn{[A, A+\delta]} of fixed length
\eqn{\delta}. The package separates the part of the regression operator that
the observed data identify from the part that they cannot identify, and
estimates the former without reconstructing unobserved parts of the curves.
}
\details{
The model is \eqn{Y = G(X) + \varepsilon}, where the predictor is
\eqn{X = \sum_{k=1}^K \xi_k \phi_k}. The \eqn{\phi_k} are known smooth
functions with pairwise disjoint supports \eqn{I_k}. The scores \eqn{\xi_k}
are independent, have mean zero and variance one, and are symmetric about
zero. The operator is a finite sum
\deqn{G(X) = \sum_{J \subseteq \{1,\dots,K\}} g_J W_J(X), \qquad
W_J(X) = \prod_{k \in J} \xi_k,}{G(X) = sum_J g_J W_J(X),  W_J(X) = prod_{k in J} xi_k,}
where each coefficient \eqn{g_J} is a function in the response space. The
set \eqn{J} is called an interaction of order \eqn{|J|}.

A window starting at \eqn{a} reveals the score \eqn{\xi_k} when it overlaps
\eqn{I_k} on an interval of positive length. The co-observation probability
of an interaction is \eqn{\rho_J = P\{J \subseteq K(A)\}}. The interaction
\eqn{J} is resolvable when \eqn{\rho_J > 0}. The resolution order \eqn{p} is
the largest number of scores that one window reveals.

The main results implemented are as follows.
\itemize{
  \item The conditional mean of \eqn{Y} given the fragment identifies exactly
    the coefficients \eqn{g_J} with \eqn{\rho_J > 0}, through
    \eqn{g_J = \rho_J^{-1} E[1\{J \subseteq K(A)\} Y W_J(X)]}.
  \item Pairwise disjoint interactions of order larger than \eqn{p} generate
    distinct operators with identical observed-data laws. This gives a
    minimax lower bound that does not decrease with the sample size.
  \item At the zero operator, the Fisher information is
    \eqn{\mathrm{diag}(\rho_J) \otimes \Sigma^{-1}}. The inverse-probability
    weighted (IPW) estimator attains the local asymptotic minimax constant
    \eqn{\mathrm{tr}(\Sigma) \sum_J \rho_J^{-1}} on resolvable directions.
}

The main functions are grouped as follows.
\describe{
  \item{Fitting:}{\code{\link{rbfit}} (Algorithm 2 of the paper) and
    \code{\link{predict.rbfit}}.}
  \item{Data:}{\code{\link{rbdata}}, \code{\link{gen_fofr}},
    \code{\link{sim_design}} and \code{\link{design_setup}} (the seven
    simulation designs).}
  \item{Design geometry:}{\code{\link{make_blocks}},
    \code{\link{resolution_order}}, \code{\link{rho_set}},
    \code{\link{classify_sets}}, \code{\link{band_measure}} and
    \code{\link{resolution_audit}}.}
  \item{Theory and evaluation:}{\code{\link{fisher_info}},
    \code{\link{ipw_risk}}, \code{\link{hypercube_check}},
    \code{\link{parity_stat}} and \code{\link{evaluate_fit}}.}
}
}
\author{
Ufuk Beyaztas \email{ufuk.beyaztas@marmara.edu.tr}
}
\keyword{package}
