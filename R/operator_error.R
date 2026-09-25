# Operator error split by resolution status
operator_error <- function(fit, Jtrue, Gtrue) {
  gt <- truth_matrix(fit$sets, Jtrue, Gtrue)
  sq <- rowSums((fit$coefficients - gt)^2)
  names(sq) <- fit$keys
  rho <- fit$rho
  tau <- fit$tau
  list(total = sum(sq),
       estimated = sum(sq[rho >= tau]),
       threshold = sum(sq[rho > 0 & rho < tau]),
       nonresolvable = sum(sq[rho <= 0]),
       nonresolvable_truth = sum(rowSums(gt^2)[rho <= 0]),
       per_set = sq)
}

