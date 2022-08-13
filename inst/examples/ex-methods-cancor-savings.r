# data frame of life-cycle savings across countries
class(LifeCycleSavings)
head(LifeCycleSavings)
savings_pop <- LifeCycleSavings[, c("pop15", "pop75")]
savings_oec <- LifeCycleSavings[, c("sr", "dpi", "ddpi")]
# canonical correlation analysis of age distributions and financial factors
savings_cancor <- cancor_ord(savings_pop, savings_oec)

# wrap as a 'tbl_ord' object
(savings_cancor <- as_tbl_ord(savings_cancor))

# recover canonical weights
get_rows(savings_cancor)
get_cols(savings_cancor)

# augment canonical weights with row names and centers
(savings_cancor <- augment_ord(savings_cancor))

# column-standard biplot of canonical coefficients
savings_cancor %>%
  confer_inertia("rows") %>%
  ggbiplot(aes(label = name, color = .matrix)) +
  theme_bw() +
  geom_rows_vector() +
  geom_rows_text() +
  geom_cols_point() +
  geom_cols_text_repel() +
  scale_color_brewer(limits = c("rows", "cols"), type = "qual") +
  expand_limits(x = c(-.1, .1))

# canonical correlation analysis with scores and correlations included
savings_cca <- cancor_ord(savings_pop, savings_oec, scores = TRUE)
savings_cca <- augment_ord(as_tbl_ord(savings_cca))
head(get_cols(savings_cca))
head(get_cols(savings_cca, elements = "score"))
get_rows(savings_cca, elements = "structure")
get_cols(savings_cca, elements = "structure")

# biplot of interset and intraset correlations with the population data
savings_cca %>%
  confer_inertia("cols") %>%
  ggbiplot(aes(label = name)) +
  theme_biplot() +
  geom_unit_circle() +
  geom_rows_vector(arrow = NULL, elements = "structure") +
  geom_cols_vector(arrow = NULL, elements = "structure", linetype = "dashed") +
  geom_rows_text(elements = "structure", hjust = "outward") +
  geom_cols_text(elements = "structure", hjust = "outward") +
  expand_limits(x = c(-1, 1), y = c(-1, 1))

# biplot with scores as supplemental elements
savings_cca %>%
  confer_inertia("rows") %>%
  ggbiplot(aes(label = name), sec.axes = "cols", scale.factor = 5L) +
  theme_biplot() +
  geom_cols_vector(elements = "active") +
  geom_cols_text_radiate(elements = "active") +
  geom_rows_text(elements = "score", subset = seq(50L))
