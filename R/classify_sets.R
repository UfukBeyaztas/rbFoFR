# Classify index sets by resolution status
classify_sets <- function(blocks, delta, qmax = 2, tau = 0.01) {
  sets <- all_subsets(blocks$K, qmax)
  rho <- sapply(sets, rho_set, blocks = blocks, delta = delta)
  keys <- sapply(sets, set_key)
  names(rho) <- keys
  list(sets = sets, keys = keys, rho = rho,
       estimated = keys[rho >= tau],
       trimmed = keys[rho > 0 & rho < tau],
       nonresolvable = keys[rho <= 0],
       tau = tau, p = resolution_order(blocks, delta))
}

