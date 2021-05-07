library(ordr)
context("classical multi-dimensional scaling, class 'cmds")

fit_cmds <- cmdscale_ord(eurodist, k = 6)

test_that("`as_tbl_ord()` coerces 'cmds' objects", {
  expect_true(valid_tbl_ord(as_tbl_ord(fit_cmds)))
})
