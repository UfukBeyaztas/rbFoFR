# Recover the visible scores of all subjects
recover_all <- function(data) {
  out <- matrix(NA, data$n, data$blocks$K)
  for (i in 1:data$n) {
    out[i, ] <- recover_scores(data$Xwin[i, ], data$A[i], data$blocks,
                               data$delta, data$Phi, data$sgrid)
  }
  out
}

