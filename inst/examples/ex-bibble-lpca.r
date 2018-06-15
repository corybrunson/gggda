
data(finches)

finches_mat <- as.matrix(dplyr::select(finches, -Island))
rownames(finches_mat) <- finches$Island

finches_lsvd <- as_bibble(logisticSVD(finches_mat))
# ILLUSTRATE ROLE-REVERSAL BETWEEN U AND V
ggbiplot(finches_lsvd, aes(x = LSC1, y = LSC2)) +
  geom_u_vector(aes(x = LSC1 * .01, y = LSC2 * .01)) +
  geom_u_text(aes(x = LSC1 * .01, y = LSC2 * .01, label = .name), size = 3) +
  geom_v_label(aes(label = .name), size = 3, alpha = .5)

finches_lpca <- as_bibble(logisticPCA(finches_mat))
ggbiplot(finches_lpca, aes(x = LPC1, y = LPC2)) +
  geom_u_vector(aes(x = LPC1 * .01, y = LPC2 * .01)) +
  geom_u_text(aes(x = LPC1 * .01, y = LPC2 * .01, label = .name), size = 3) +
  geom_v_label(aes(label = .name), size = 3, alpha = .5)
