
<!-- edit README.rmd -->

# gggda

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN](http://www.r-pkg.org/badges/version/gggda)](https://cran.r-project.org/package=gggda)
<!-- badges: end -->

{gggda} extends [{ggplot2}](https://github.com/tidyverse/ggplot2) with
coordinate systems, statistical transformations, and geometric
constructions useful to the analysis and visualization of multivariate
data, including bivariate generalizations of univariate tools and tools
designed for geometric data analysis and ordination.

It is spun off from and designed to interoperate with
[{ordr}](https://github.com/corybrunson/ordr). However, the two packages
remain to be completely harmonized.

## usage

### installation

{gggda} is not yet on CRAN and can be installed as follows using
[{pak}](https://github.com/r-lib/pak):

``` r
pak::pkg_install("corybrunson/gggda")
```

### illustration

Use the new coordinate system to fix the aspect ratio of the plotting
window as well as of the coordinates:

``` r
# rectangular window (custom aspect ratio)
ggplot(mpg, aes(x = displ, y = hwy)) +
  coord_rect(ratio = .1, window_ratio = 1/2) +
  geom_point()
```

![](man/figures/README-coord-1.png)<!-- -->

``` r
# square window (unit aspect ratio)
ggplot(mpg, aes(x = cty, y = hwy)) +
  coord_square(xlim = c(0, NA), ylim = c(0, NA)) +
  geom_point()
```

![](man/figures/README-coord-2.png)<!-- -->

Some new statistical transformations provide new ways of analyzing
bivariate data, for example the depth stat that deploys [the {ddalpha}
package](https://cran.r-project.org/package=ddalpha) and mimics the
density stat by pairing with the contour geom:

``` r
# depth medians and quartiles contours by group
ggplot(mpg, aes(displ, cty, color = drv, fill = drv)) +
  stat_depth(bins = 4) +
  stat_center(fun.ord = depth_median)
```

![](man/figures/README-stat-1.png)<!-- -->

Several new geometric constructions have a wide range of uses, including
biplots, with two-dimensional errorbars an underused example:

``` r
# centroids with 2-standard deviation bars for both variables
ggplot(mpg, aes(displ, cty, color = factor(cyl))) +
  geom_point() +
  geom_pointranges(fun.data = mean_sdl)
```

![](man/figures/README-geom-1.png)<!-- -->

## acknowledgments

### contribute

Any feedback on the package is very welcome! If you encounter confusion
or errors, do create an issue, with a [minimal reproducible
example](https://stackoverflow.com/help/minimal-reproducible-example) if
feasible. If you have requests, suggestions, or your own implementations
for new features, feel free to create an issue or submit a pull request.
Please try to follow the [contributing
guidelines](https://github.com/corybrunson/gggda/blob/main/CONTRIBUTING.md)
and respect the [Code of
Conduct](https://github.com/corybrunson/gggda/blob/main/CODE_OF_CONDUCT.md).

### resources

Development of this package benefitted from the use of equipment and the
support of colleagues at [UConn Health](https://health.uconn.edu/) and
at [UF Health](https://ufhealth.org/).
