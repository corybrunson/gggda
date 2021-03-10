# data frame of life-cycle savings across countries
head(LifeCycleSavings)
# canonical correlation analysis of age distributions and financial factors
cancor_ord(
  LifeCycleSavings[, c("pop15", "pop75")],
  LifeCycleSavings[, c("sr", "dpi", "ddpi")]
) %>%
  as_tbl_ord()
stop()
