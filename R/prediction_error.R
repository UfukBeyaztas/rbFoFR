# Prediction error relative to the mean predictor
prediction_error <- function(Yhat, Y) {
  mse <- mean(rowSums((Yhat - Y)^2))
  ybar <- matrix(colMeans(Y), nrow(Y), ncol(Y), byrow = TRUE)
  base <- mean(rowSums((ybar - Y)^2))
  list(mse = mse, baseline = base, relative = mse / base)
}

