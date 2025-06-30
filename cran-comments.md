## version 0.1.0

This is the initial release.
Local checks were performed both with the current CRAN version 3.5.2 of {ggplot2} and with the current development version (2025 Jun 30).

## R CMD checks

### Test environments

* local OS X install, R 4.4.2
  * `devtools::check()`
  * `devtools::check(env_vars = c('_R_CHECK_DEPENDS_ONLY_' = "true"))`
  * `devtools::check(manual = TRUE, remote = TRUE)`
* Win-Builder
  * `devtools::check_win_oldrelease()`
  * `devtools::check_win_release()`
  * `devtools::check_win_devel()`

### local results

### Win-Builder results
