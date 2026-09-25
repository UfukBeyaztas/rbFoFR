# Integrated squared error of predicted curves
curve_mise <- function(pred, truth, grid) {
  pred <- as.matrix(pred)
  truth <- as.matrix(truth)
  mean(sapply(1:nrow(pred), function(i) trapz((pred[i, ] - truth[i, ])^2, grid)))
}

