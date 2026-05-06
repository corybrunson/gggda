# sample median
iris %>% 
  subset(select = -Species) %>% 
  depth_median()
# groupwise medians
iris %>% 
  split(~ Species) %>% 
  lapply(subset, select = -Species) %>% 
  lapply(depth_median) %>% 
  simplify2array() %>% t() %>% as.data.frame()
