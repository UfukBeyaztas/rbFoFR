# Simulate data from one of the seven designs
sim_design <- function(design, n, delta = NULL,
                       alternative = c("null", "local"),
                       family = c("hypercube", "overlap"),
                       signs = c(1, 1), seed = NULL) {
  alternative <- match.arg(alternative)
  family <- match.arg(family)
  st <- design_setup(design, delta)
  J <- st$J
  G <- st$Gamma

  if (design == 6 && alternative == "local") G <- st$H / sqrt(n)
  if (design == 7) {
    if (family == "overlap") J <- st$extra$J_overlap
    G <- rbind(signs[1] * st$extra$cvec, signs[2] * st$extra$cvec)
  }
  st$J <- J
  st$Gamma <- G

  out <- gen_fofr(n, st$blocks, st$delta, st$sgrid, st$tgrid, J, G, st$Sigma,
                  scores = st$scores, seed = seed)
  st$alternative <- if (design == 6) alternative else NULL
  st$family <- if (design == 7) family else NULL
  st$signs <- if (design == 7) signs else NULL
  out$setup <- st
  out
}

