# Generate data from the nonlinear fragmented model
gen_fofr <- function(n, blocks, delta, sgrid, tgrid, Jlist, Gamma, Sigma,
                     scores = c("rademacher", "gaussian"),
                     Phi = NULL, E = NULL, seed = NULL) {
  scores <- match.arg(scores)
  Gamma <- as.matrix(Gamma)
  d <- ncol(Gamma)
  if (is.null(Phi)) Phi <- phi_basis(blocks, sgrid)
  if (is.null(E)) E <- response_basis(d, tgrid)
  if (nrow(Gamma) != length(Jlist)) stop("nrow(Gamma) must equal length(Jlist)")
  if (any(dim(Sigma) != c(d, d))) stop("'Sigma' must be d by d")
  if (!is.null(seed)) set.seed(seed)
  K <- blocks$K

  if (scores == "rademacher") {
    xi <- matrix(sample(c(-1, 1), n * K, replace = TRUE), n, K)
  } else {
    xi <- matrix(stats::rnorm(n * K), n, K)
  }
  if (delta == 1) {
    A <- rep(0, n)
  } else {
    A <- stats::runif(n, 0, 1 - delta)
  }

  Xfull <- xi %*% t(Phi)
  Xwin <- Xfull
  for (i in 1:n) {
    Xwin[i, sgrid < A[i] | sgrid > A[i] + delta] <- NA
  }

  W <- matrix(1, n, length(Jlist))
  for (j in seq_along(Jlist)) {
    J <- Jlist[[j]]
    if (length(J) > 0) W[, j] <- apply(xi[, J, drop = FALSE], 1, prod)
  }
  mu <- W %*% Gamma
  eps <- matrix(stats::rnorm(n * d), n, d) %*% chol(Sigma)
  Ystar <- mu + eps
  Y <- Ystar %*% t(E)

  out <- rbdata(Xwin, Y, A, sgrid, tgrid, blocks, delta, d = d,
                Phi = Phi, E = E)
  out$truth <- list(xi = xi, Xfull = Xfull, W = W, mu = mu, Ystar = Ystar,
                    Jlist = Jlist, Gamma = Gamma, Sigma = Sigma,
                    scores = scores)
  out
}

