# Observed Walsh features
walsh_features <- function(xihat, D, Jlist) {
  n <- nrow(xihat)
  Fm <- matrix(0, n, length(Jlist))
  for (j in seq_along(Jlist)) {
    J <- Jlist[[j]]
    if (length(J) == 0) {
      w <- rep(1, n)
    } else {
      w <- apply(xihat[, J, drop = FALSE], 1,
                 function(z) if (anyNA(z)) 0 else prod(z))
    }
    Fm[, j] <- w * D[, j]
  }
  Fm
}

