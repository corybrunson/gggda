# Depth median

Compute the depth median of a data set.

## Usage

``` r
depth_median(x, notion = "zonoid", ...)
```

## Arguments

- x:

  Matrix of data whose depth median is to be calculated; see
  [`ddalpha::depth.()`](https://rdrr.io/pkg/ddalpha/man/depth..html).

- notion:

  The name of the depth notion (shall also work with a user-defined
  depth function named `"depth.<name>"`).

- ...:

  Additional parameters passed to the depth functions.

## Value

A one-row matrix of depth median coordinates.

## Details

This function is called internally by
[`stat_bagplot()`](stat_bagplot.md) and can be passed to
[`stat_center()`](stat_center.md) but is also exported directly for data
analysis.

## Examples

``` r
# sample median
iris %>% 
  subset(select = -Species) %>% 
  depth_median()
#> Sepal.Length  Sepal.Width Petal.Length  Petal.Width 
#>          6.0          2.9          4.5          1.5 
# groupwise medians
iris %>% 
  split(~ Species) %>% 
  lapply(subset, select = -Species) %>% 
  lapply(depth_median) %>% 
  simplify2array() %>% t() %>% as.data.frame()
#>            Sepal.Length Sepal.Width Petal.Length Petal.Width
#> setosa              5.0         3.4          1.5         0.2
#> versicolor          5.7         2.8          4.1         1.3
#> virginica           7.1         3.0          5.9         2.1
```
