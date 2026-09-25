# Prediction from a fitted model
predict.rbfit <- function(object, newdata, ...) {
  if (missing(newdata) || !inherits(newdata, "rbdata"))
    stop("'newdata' must be an 'rbdata' object")
  xh <- recover_all(newdata)
  D <- obs_indicator(newdata$A, object$sets, newdata$blocks, newdata$delta)
  Fm <- walsh_features(xh, D, object$sets)
  ys <- Fm %*% object$coefficients
  list(Ystar = ys, Y = ys %*% t(newdata$E))
}

