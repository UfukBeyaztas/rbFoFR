# S3 method
print.rbfit <- function(x, digits = 3, ...) {
  cat("Resolution-aware function-on-function fit\n")
  cat("  method:", x$method, "  n:", x$n, "  delta:", x$delta,
      "  resolution order p:", x$p, "\n")
  cat("  qmax:", x$qmax, "  tau:", x$tau, "\n")
  cat("  directions estimated:", length(x$report$estimated),
      "  trimmed:", length(x$report$trimmed),
      "  non-resolvable:", length(x$report$nonresolvable), "\n\n")
  est <- x$coefficients[x$kept, , drop = FALSE]
  tab <- cbind(rho = x$rho[x$kept], est)
  print(round(tab, digits))
  invisible(x)
}

