# ensures that the resolutions of the axes and the dimensions of the plotting
# window respect the specified aspect ratios
p <- ggplot(mtcars, aes(mpg, hp/10)) + geom_point()
p + coord_rect(ratio = 1)
p + coord_rect(ratio = 1, window_ratio = 2)
p + coord_rect(ratio = 1, window_ratio = 1/2)
# offset squares
p + coord_rect(xlim = c(15, 30))
p + coord_rect(ylim = c(15, 30))
# infeasible to synchronize breaks
p + coord_rect(ratio = 5)
p + coord_rect(ratio = 1/5)

# force square (even excluding some geometric constructions)
p + coord_square(xlim = c(0, 30), ylim = c(20, 40))

# disable break synchronization
p + 
  scale_x_continuous(limits = c(-10, 60)) +
  coord_rect(ratio = 1, window_ratio = 1/2)
p + 
  scale_x_continuous(limits = c(-10, 60)) +
  coord_rect(ratio = 1, window_ratio = 1/2, sync_breaks = FALSE)
