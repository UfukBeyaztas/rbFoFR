# rbFoFR

**Nonlinear function-on-function regression from fragments**

`rbFoFR` fits the identifiable component of a nonlinear function-on-function
regression operator when each predictor curve is observed only on a window of
fixed length. 

## What the package does

The model is `Y = G(X) + e`, where the predictor is

```
X = xi_1 phi_1 + ... + xi_K phi_K
```

with known smooth functions `phi_k` having pairwise disjoint supports and
independent, symmetric, standardized scores `xi_k`. The operator is a finite sum

```
G(X) = sum_J g_J W_J(X),     W_J(X) = prod_{k in J} xi_k,
```

over index sets `J`, with function-valued coefficients `g_J`.

Each curve is seen only on `[A, A + delta]`, so a window reveals the score
`xi_k` only when it overlaps the support of `phi_k`. The co-observation
probability of an interaction is `rho_J`, the probability that one window
reveals every score in `J`, and the resolution order `p` is the largest number
of scores a single window can reveal.

The package implements the resulting three-way split of the operator:

* directions with `rho_J >= tau` are **estimated**, by inverse probability
  weighting when the window law is known, or by a complete-case ratio
  estimator when it is not;
* directions with `0 < rho_J < tau` are **trimmed** and reported;
* directions with `rho_J = 0` are **non-resolvable**: they are absent from the
  conditional mean of the response given the fragment, and no estimator can
  recover them at any sample size.

Nothing is reconstructed: scores that a window does not reveal are never
imputed. The package also provides the co-observation geometry, the Fisher
information and risk benchmarks, data generators for the seven simulation
designs of the paper, and tools for separating operator error from prediction
error.

## Installation

The package is on GitHub. Install it with either `remotes` or `devtools`:

```r
# install.packages("remotes")
remotes::install_github("UfukBeyaztas/rbFoFR")
```

```r
# install.packages("devtools")
devtools::install_github("UfukBeyaztas/rbFoFR")
```

To include the help pages (recommended, since every function is documented):

```r
remotes::install_github("UfukBeyaztas/rbFoFR", build_manual = TRUE)
```

`rbFoFR` needs R (>= 3.5.0) and uses only `stats` and `utils`, so there are no
other dependencies and nothing to compile.

## Documentation

The reference manual is included in the repository as
[`rbFoFR_0.1.0.pdf`](rbFoFR_0.1.0.pdf). After installation, the same pages are
available from R:

```r
library(rbFoFR)
help(package = "rbFoFR")
?rbfit
?sim_design
```

## Quick start

### The design geometry

```r
library(rbFoFR)

# six bumps in three clusters, as in the paper
blocks <- make_blocks()

resolution_order(blocks, delta = 0.22)   # p = 2
rho_set(c(3, 4), blocks, 0.22)           # 0.244: a resolvable pair
rho_set(c(1, 2, 3), blocks, 0.22)        # 0: non-resolvable

cls <- classify_sets(blocks, delta = 0.22, qmax = 3, tau = 0.01)
cls$estimated       # 10 directions
cls$nonresolvable   # 12 directions
```

### Fitting

```r
train <- sim_design(1, n = 500, seed = 1)
test  <- sim_design(1, n = 1000, seed = 2)

fit <- rbfit(train, qmax = 2, tau = 0.01, method = "ipw")
fit
coef(fit)

# prediction from a new fragment
pr <- predict(fit, test)

# operator error and fragment-signal error are different targets
round(evaluate_fit(fit, test, train$setup$J, train$setup$Gamma), 3)
```

`rbfit` takes an `"rbdata"` object. Simulated data already carry that class;
for your own fragments, build one with

```r
dat <- rbdata(Xwin, Y, A, sgrid, tgrid, blocks, delta, d = 2)
```

where `Xwin` holds the predictor values inside each subject's window and `NA`
elsewhere, `Y` the response curves, and `A` the window starting points.

### The resolution barrier

```r
# design 3 at delta = 0.22: the cubic terms {1,2,3} and {4,5,6} are invisible
dat <- sim_design(3, n = 1000, delta = 0.22, seed = 3)
f3  <- rbfit(dat, qmax = 3)

f3$report$nonresolvable
operator_error(f3, dat$setup$J, dat$setup$Gamma)$nonresolvable   # 2.5, at any n
```

### Information and risk

```r
st  <- design_setup(6)
rho <- sapply(st$J, rho_set, blocks = st$blocks, delta = st$delta)

fisher_info(rho, st$Sigma)                       # diag(rho) kronecker Sigma^{-1}
ipw_risk(rho, st$Gamma, st$Sigma, n = 1)$lam_constant   # 28.917
```

## Function reference

| Group | Functions |
| --- | --- |
| Fitting | `rbfit`, `predict.rbfit`, `coef.rbfit`, `print.rbfit` |
| Data | `rbdata`, `gen_fofr`, `sim_design`, `design_setup` |
| Design geometry | `make_blocks`, `resolution_order`, `rho_set`, `rho_r`, `band_measure`, `classify_sets`, `resolution_audit` |
| Bases and scores | `phi_basis`, `response_basis`, `recover_all` |
| Theory | `fisher_info`, `ipw_risk`, `hypercube_check`, `parity_stat` |
| Evaluation | `evaluate_fit`, `operator_error`, `truth_matrix`, `prediction_error`, `curve_mise` |

## The simulation designs

`sim_design(design, n, ...)` generates one sample from any of the seven designs
in the paper; `design_setup(design)` returns their settings.

| Design | What it isolates |
| --- | --- |
| 1 | Resolvable nonlinear effects, all directions estimable |
| 2 | Thresholding a rare interaction (`rho = 1/13`) |
| 3 | Changing resolution, `delta` from 0.12 to 1 |
| 4 | Gaussian predictor scores |
| 5 | Full observation, `delta = 1` |
| 6 | Local information at the null and under `H / sqrt(n)` |
| 7 | Equal observed laws, and visible parity in an overlapping family |

Designs 3, 6, and 7 take extra arguments:

```r
sim_design(3, n = 1000, delta = 0.38, seed = 1)                  # window length
sim_design(6, n = 1600, alternative = "local", seed = 2)         # H / sqrt(n)
sim_design(7, n = 30000, family = "overlap", signs = c(1, -1), seed = 3)
```

## License

GPL (>= 2).

## Contact

Ufuk Beyaztas, Department of Statistics, Marmara University
<ufuk.beyaztas@marmara.edu.tr>
