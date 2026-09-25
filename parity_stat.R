# Visible parity statistic
parity_stat <- function(data, Jpair, component = 1) {
  sd <- sym_diff(Jpair[[1]], Jpair[[2]])
  xh <- recover_all(data)
  ys <- response_coords(data$Y, data$E, data$tgrid)
  z <- xh[, sd, drop = FALSE]
  seen <- rowSums(is.na(z)) == 0
  w <- apply(z[seen, , drop = FALSE], 1, prod)
  list(statistic = mean(ys[seen, component]^2 * w),
       sym_diff = sd, rho = rho_set(sd, data$blocks, data$delta),
       n_seen = sum(seen))
}

