x <- mtcars$disp; y <- mtcars$mpg

# all hulls
peel_hulls(x, y, num = Inf)

# every third hull
peel_hulls(x, y, num = Inf, by = 3)

# tertile hulls, cut below
peel_hulls(x, y, breaks = seq(0, 1, length.out = 4))

# tertile hulls, cut above
peel_hulls(x, y, breaks = seq(0, 1, length.out = 4), cut = "below")
