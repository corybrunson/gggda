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

Two NOTEs were consistently produced:

```
❯ checking package dependencies ... NOTE
  Package suggested but not available for checking: ‘mlpack’

❯ checking for future file timestamps ... NOTE
  unable to verify current time
```

The first is intentional, as in {ordr}; the relevant functionality locates any of three "engine" packages to run the required operation.
The second is a recurring pattern in my checks, presumably due to internet speeds.

### Win-Builder results



```
Possibly misspelled words in DESCRIPTION:
  Gower (25:5)
  Jolliffe (19:5)
  Podani (28:74)
  Rouanet (30:5)
  Rousseeuw (17:43)
  Wickham's (31:5)
  al (17:54)
  biplots (21:19)
  bivariate (15:33)
  multivariable (12:27, 14:19, 27:64)
  univariable (13:60)
```



```
Found the following (possibly) invalid URLs:
  URL: https://corybrunson.github.io/gggda/
    From: DESCRIPTION
          man/gggda.Rd
    Status: 404
    Message: Not Found
  URL: https://stackoverflow.com/help/minimal-reproducible-example
    From: README.md
    Status: 404
    Message: Not Found
  URL: https://www.jud.ct.gov/superiorcourt/
    From: inst/doc/gggda.html
    Status: Error
    Message: Timeout was reached [www.jud.ct.gov]:
      Failed to connect to www.jud.ct.gov port 443 after 21296 ms: Could not connect to server
```
