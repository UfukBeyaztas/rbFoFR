# Fragmented function-on-function data
rbdata <- function(Xwin, Y, A, sgrid, tgrid, blocks, delta, d = 2,
                   Phi = NULL, E = NULL) {
  Xwin <- as.matrix(Xwin)
  Y <- as.matrix(Y)
  n <- nrow(Xwin)
  if (nrow(Y) != n || length(A) != n)
    stop("'Xwin', 'Y' and 'A' must refer to the same number of subjects")
  if (ncol(Xwin) != length(sgrid)) stop("ncol(Xwin) must equal length(sgrid)")
  if (ncol(Y) != length(tgrid)) stop("ncol(Y) must equal length(tgrid)")
  if (is.null(Phi)) Phi <- phi_basis(blocks, sgrid)
  if (is.null(E)) E <- response_basis(d, tgrid)
  out <- list(n = n, A = A, Xwin = Xwin, Y = Y, sgrid = sgrid, tgrid = tgrid,
              delta = delta, blocks = blocks, Phi = Phi, E = E)
  class(out) <- "rbdata"
  out
}

