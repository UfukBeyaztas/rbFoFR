# Resolution-aware fit of the identifiable component
rbfit <- function(data, qmax = 2, tau = 0.01, method = c("ipw", "ratio")) {
  if (!inherits(data, "rbdata")) stop("'data' must be an 'rbdata' object")
  method <- match.arg(method)

  cls <- classify_sets(data$blocks, data$delta, qmax = qmax, tau = tau)
  sets <- cls$sets
  rho <- as.numeric(cls$rho)

  xihat <- recover_all(data)
  Ystar <- response_coords(data$Y, data$E, data$tgrid)
  D <- obs_indicator(data$A, sets, data$blocks, data$delta)
  Fm <- walsh_features(xihat, D, sets)

  if (method == "ipw") {
    ghat <- est_ipw(Fm, Ystar, rho)
  } else {
    ghat <- est_ratio(Fm, Ystar, D)
  }
  ghat[!is.finite(ghat)] <- 0
  keep <- rho >= tau
  ghat[!keep, ] <- 0
  rownames(ghat) <- cls$keys
  colnames(ghat) <- paste0("e", 1:ncol(ghat))

  out <- list(coefficients = ghat, method = method, sets = sets,
              keys = cls$keys, rho = rho, kept = keep,
              report = list(estimated = cls$estimated,
                            trimmed = cls$trimmed,
                            nonresolvable = cls$nonresolvable),
              p = cls$p, qmax = qmax, tau = tau, delta = data$delta,
              n = data$n, xihat = xihat, D = D, features = Fm)
  class(out) <- "rbfit"
  out
}

