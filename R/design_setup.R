# Settings of the simulation designs
design_setup <- function(design, delta = NULL) {
  if (!(design %in% 1:7)) stop("'design' must be one of 1, ..., 7")

  blocks <- make_blocks(centers = c(0.075, 0.445, 0.845), per_cluster = 2,
                        width = 0.03, gap = 0.06)
  sgrid <- seq(0, 1, length.out = 301)
  tgrid <- seq(0, 1, length.out = 81)
  Sigma <- matrix(c(0.60, 0.15, 0.15, 0.40), 2, 2)
  scores <- "rademacher"
  dlt <- 0.22
  tau <- 0.01
  qmax <- 2
  H <- NULL
  extra <- list()

  ## five resolvable directions shared by designs 1, 3, 4 and 6
  J5 <- list(3, 4, c(3, 4), c(5, 6), c(1, 2))
  G5 <- rbind(c( 1.00, -0.40),
              c(-0.70,  0.50),
              c( 0.90,  0.30),
              c(-0.60, -0.80),
              c( 0.50,  0.20))
  cvec <- c(1.00, -0.50)

  if (design == 1) {
    J <- J5
    G <- G5
  }
  if (design == 2) {
    J <- list(3, c(3, 4), c(5, 6), c(1, 2))
    G <- rbind(c( 0.70, -0.25),
               c( 0.75,  0.25),
               c(-0.55, -0.65),
               c( 0.95,  0.35))
    extra$tau_grid <- c(0.005, 0.025, 0.05, 0.08, 0.10)
  }
  if (design %in% c(3, 4)) {
    J <- c(J5, list(c(1, 2, 3), c(4, 5, 6)))
    G <- rbind(G5, cvec, -cvec)
    rownames(G) <- NULL
    qmax <- 3
    if (design == 3) {
      dlt <- if (is.null(delta)) 0.22 else delta
      extra$delta_grid <- c(0.12, 0.22, 0.30, 0.38, 0.46, 1.00)
    } else {
      scores <- "gaussian"
    }
  }
  if (design == 5) {
    blocks <- make_blocks(centers = c(0.14, 0.38, 0.62, 0.86),
                          per_cluster = 1, width = 0.18, gap = 0.01)
    sgrid <- seq(0, 1, length.out = 101)
    tgrid <- seq(0, 1, length.out = 61)
    Sigma <- diag(c(0.20, 0.16))
    scores <- "gaussian"
    dlt <- 1
    qmax <- 1
    J <- list(integer(0), 1, 2, 3, 4)
    G <- rbind(c( 0.00,  0.00),
               c( 0.65,  0.15),
               c(-0.55,  0.20),
               c( 0.45, -0.15),
               c(-0.35, -0.10))
  }
  if (design == 6) {
    J <- J5
    H <- rbind(c( 0.70, -0.30),
               c(-0.55,  0.35),
               c( 0.65,  0.20),
               c(-0.45, -0.55),
               c( 0.55,  0.15))
    G <- matrix(0, length(J), 2)
  }
  if (design == 7) {
    J <- list(c(1, 2, 3), c(4, 5, 6))
    G <- rbind(cvec, cvec)
    rownames(G) <- NULL
    qmax <- 3
    extra$J_overlap <- list(c(1, 3), c(1, 2, 3))
    extra$cvec <- cvec
  }

  list(design = design, blocks = blocks, delta = dlt, sgrid = sgrid,
       tgrid = tgrid, Sigma = Sigma, scores = scores, J = J, Gamma = G,
       H = H, qmax = qmax, tau = tau, extra = extra)
}

