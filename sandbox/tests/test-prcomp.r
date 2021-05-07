# principal components analysis (`prcomp`) examples

# calculate several `prcomp`s
x <- USPersonalExpenditure
p <- prcomp(x, center = FALSE, scale = FALSE)
p2 <- prcomp(x, center = TRUE, scale = FALSE)
p3 <- prcomp(x, center = TRUE, scale = TRUE)

# access the 'U' and 'V' matrices
recover_u(p)
recover_v(p)
recover_u(p2)
recover_v(p2)
recover_u(p3)
recover_v(p3)

# access the names of the artificial coordinates
recover_coord(p)
recover_coord(p2)
recover_coord(p3)

# check that the distances between the original and recovered values are small
range(as.matrix(x) - reconstruct(p))
range(as.matrix(x) - reconstruct(p2))
range(as.matrix(x) - reconstruct(p3))

# wrap `p`, `p2`, and `p3` as 'tbl_ord' objects
b <- as_tbl_ord(p)
b2 <- as_tbl_ord(p2)
b3 <- as_tbl_ord(p3)

# augment methods
augment_u(b)
augment_v(b)
augmentation_coord(b)
augment_u(b2)
augment_v(b2)
augmentation_coord(b2)
augment_u(b3)
augment_v(b3)
augmentation_coord(b3)

# data frames
fortify(b)
fortify(b2)
fortify(b3)

# unadjusted biplot of scores and loadings (using centered and scaled data)
gg <- ggbiplot(b3) +
  geom_u_point() +
  geom_v_vector()
gg
# add radiating text for loadings
gg + geom_v_text_radiate(aes(label = .name))

# "principal component biplot" of Gabriel
# (move `diag(sqrt(nrow(x)), dim(b3), dim(b3))` from U to V)
s <- sqrt(nrow(get_u(b3)))
ggbiplot(b3) +
  geom_u_point(aes(x = PC1 * s, y = PC2 * s)) +
  geom_v_vector(aes(x = PC1 / s, y = PC2 / s))

# effect of conferring inertia (using centered and scaled data)
set.seed(739806)
get_conference(b3)
ggbiplot(b3, aes(label = .name)) +
  geom_u_point() +
  geom_u_text_repel() +
  geom_v_vector() +
  geom_v_text_radiate()
(b3_cov <- confer_inertia(b3, c(0, 1)))
ggbiplot(b3_cov, aes(label = .name)) +
  geom_u_point() +
  geom_u_text_repel() +
  geom_v_vector() +
  geom_v_text_radiate()
(b3_symm <- confer_inertia(b3, c(.5, .5)))
ggbiplot(b3_symm, aes(label = .name)) +
  geom_u_point() +
  geom_u_text_repel() +
  geom_v_vector() +
  geom_v_text_radiate()
