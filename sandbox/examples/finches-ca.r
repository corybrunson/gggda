# Correspondence analysis of Sanderson finches data
data(finches)
finches %>%
  ca::ca() %>%
  as_tbl_ord() %>%
  confer_inertia(.5) %>%
  augment() %>%
  print() -> finches_ca
finches_ca %>%
  ggbiplot(aes(label = .name)) +
  geom_rows_text(aes(alpha = .inertia), color = "royalblue3") +
  geom_cols_text(aes(alpha = .inertia), color = "darkred") +
  scale_alpha_continuous(range = c(.3, 1), guide = "none") +
  ggtitle(
    "Symmetric CA biplot of the Galapagos island finches",
    "Label opacity encodes row/column inertia"
  ) +
  expand_limits(x = c(-1, 6))
