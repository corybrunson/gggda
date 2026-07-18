## version 0.2.0

This version contains part of a series of upgrades but was triggered by the need to patch a bug introduced by a change to the {mlpack} API; see (#19).

## R CMD checks

### Test environments

* local OS X install, R 4.5.3
  * `devtools::check()`
  * `devtools::check(env_vars = c('_R_CHECK_DEPENDS_ONLY_' = "true"))`
  * `devtools::check(manual = TRUE, remote = TRUE)`
* Win-Builder
  * `devtools::check_win_oldrelease()`
  * `devtools::check_win_release()`
  * `devtools::check_win_devel()`

### local results

There were no ERRORs, WARNINGs, or NOTEs.

### Win-Builder results

There were no ERRORs or WARNINGs.

The following URLs were each NOTEd by one or more checks but work for me:

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
