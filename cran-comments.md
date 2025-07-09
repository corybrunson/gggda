## version 0.1.1

With apologies to the CRAN team, this patch fixes a bug that arose while debugging the last issue before submission.
Tests have been introduced to catch similar bugs in future.

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

There were no ERRORs or WARNINGs.
Two NOTEs were consistently produced:

```
❯ checking package dependencies ... NOTE
  Package suggested but not available for checking: ‘mlpack’

❯ checking for future file timestamps ... NOTE
  unable to verify current time
```

The first is intentional, as in {ordr}; the relevant functionality locates any of three "engine" packages to run the required operation.
The second is presumably due to internet speeds.

The third check additionally produced the "New submission" NOTE.

Some checks also produced the following NOTE:

```
❯ checking dependencies in R code ... NOTE
  Namespaces in Imports field not imported from:
    ‘dplyr’ ‘tidyr’
    All declared Imports should be used.
```

I believe this is in error; both packages are used internally via the double-colon operator `::`.

### Win-Builder results

There were no ERRORs or WARNINGs.
Notably, the "not imported" NOTE did not arise.
All NOTEs not seen above are addressed below.

The following names and words are spelled as intended ("al" appears as part of "&al"):

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

The following URLs work for me:

```
Found the following (possibly) invalid URLs:
  URL: https://stackoverflow.com/help/minimal-reproducible-example
    From: README.md
    Status: 404
    Message: Not Found
  URL: https://www.jud.ct.gov/superiorcourt/
    From: inst/doc/gggda.html
    Status: Error
    Message: Timeout was reached [www.jud.ct.gov]:
      Failed to connect to www.jud.ct.gov port 443 after 21050 ms: Could not connect to server
```
