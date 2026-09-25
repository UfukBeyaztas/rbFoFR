# Error measures of a fit on test data
evaluate_fit <- function(fit, test, Jtrue, Gtrue) {
  err <- operator_error(fit, Jtrue, Gtrue)
  pr <- predict(fit, test)

  xh <- recover_all(test)
  D <- obs_indicator(test$A, Jtrue, test$blocks, test$delta)
  signal <- walsh_features(xh, D, Jtrue) %*% Gtrue
  signal_mse <- mean(rowSums((pr$Ystar - signal)^2))

  ys <- response_coords(test$Y, test$E, test$tgrid)
  pe <- prediction_error(pr$Ystar, ys)

  c(operator_total = err$total,
    operator_estimated = err$estimated,
    operator_threshold = err$threshold,
    operator_nonresolvable = err$nonresolvable,
    fragment_signal_mse = signal_mse,
    response_mse = pe$mse,
    response_relative = pe$relative)
}

