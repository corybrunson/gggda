# Performance measures can be regressed on the artificial coordinates of
# ordinated vehicle specs. Because the ordination of specs ignores performance,
# these coordinates will probably not be highly predictive. The gradient of each
# performance measure along the artificial axes is visualized by projecting the
# regression coefficients onto the ordination biplot.

# data frame of vehicle performance measures
mtcars %>%
  subset(select = c(mpg, qsec)) %>%
  as.matrix() %>%
  print() -> mtcars_perf
# scaled principal components analysis of vehicle specs
mtcars %>%
  subset(select = c(cyl, disp, hp, drat, wt, vs, carb)) %>%
  princomp(cor = TRUE) %>%
  as_tbl_ord() %>%
  print() -> mtcars_specs_pca
# regress performance measures on principal components
lm(mtcars_perf ~ get_rows(mtcars_specs_pca)) %>%
  as_tbl_ord() %>%
  print() -> mtcars_pca_lm
# regression biplot
ggbiplot(mtcars_specs_pca, aes(label = .name),
         sec.axes = "rows", scale.factor = .5) +
  theme_minimal() +
  geom_rows_text(size = 3) +
  geom_cols_vector(data = mtcars_pca_lm) +
  geom_cols_text_radiate(data = mtcars_pca_lm) +
  expand_limits(x = c(-2.5, 2))
# multidimensional scaling based on a scaled cosine distance of vehicle specs
mtcars %>%
  subset(select = c(cyl, disp, hp, drat, wt, vs, carb)) %>%
  scale() %>%
  proxy::dist(method = "cosine") %>%
  cmdscale_ord() %>%
  as_tbl_ord() %>%
  print() -> mtcars_specs_cmds
# regress performance measures on principal coordinates
lm(mtcars_perf ~ get_rows(mtcars_specs_cmds)) %>%
  as_tbl_ord() %>%
  print() -> mtcars_cmds_lm
# regression biplot
ggbiplot(mtcars_specs_cmds, aes(label = .name),
         sec.axes = "rows", scale.factor = 3) +
  theme_minimal() +
  geom_rows_text(size = 3) +
  geom_cols_vector(data = mtcars_cmds_lm) +
  geom_cols_text_radiate(data = mtcars_cmds_lm) +
  expand_limits(x = c(-2.25, 1.25), y = c(-2, 1.5))
