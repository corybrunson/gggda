# Bagplots

Construct medians, bags, fences, and outlier specifications for
bagplots.

## Usage

``` r
stat_bagplot(
  mapping = NULL,
  data = NULL,
  geom = "bagplot",
  position = "identity",
  fraction = 0.5,
  coef = 3,
  median = TRUE,
  fence = TRUE,
  outliers = TRUE,
  show.legend = NA,
  inherit.aes = TRUE,
  ...
)
```

## Arguments

- mapping:

  Set of aesthetic mappings created by
  [`aes()`](https://ggplot2.tidyverse.org/reference/aes.html). If
  specified and `inherit.aes = TRUE` (the default), it is combined with
  the default mapping at the top level of the plot. You must supply
  `mapping` if there is no plot mapping.

- data:

  The data to be displayed in this layer. There are three options:

  If `NULL`, the default, the data is inherited from the plot data as
  specified in the call to
  [`ggplot()`](https://ggplot2.tidyverse.org/reference/ggplot.html).

  A `data.frame`, or other object, will override the plot data. All
  objects will be fortified to produce a data frame. See
  [`fortify()`](https://ggplot2.tidyverse.org/reference/fortify.html)
  for which variables will be created.

  A `function` will be called with a single argument, the plot data. The
  return value must be a `data.frame`, and will be used as the layer
  data. A `function` can be created from a `formula` (e.g.
  `~ head(.x, 10)`).

- geom:

  The geometric object to use to display the data for this layer. When
  using a `stat_*()` function to construct a layer, the `geom` argument
  can be used to override the default coupling between stats and geoms.
  The `geom` argument accepts the following:

  - A `Geom` ggproto subclass, for example `GeomPoint`.

  - A string naming the geom. To give the geom as a string, strip the
    function name of the `geom_` prefix. For example, to use
    `geom_point()`, give the geom as `"point"`.

  - For more information and other ways to specify the geom, see the
    [layer
    geom](https://ggplot2.tidyverse.org/reference/layer_geoms.html)
    documentation.

- position:

  A position adjustment to use on the data for this layer. This can be
  used in various ways, including to prevent overplotting and improving
  the display. The `position` argument accepts the following:

  - The result of calling a position function, such as
    `position_jitter()`. This method allows for passing extra arguments
    to the position.

  - A string naming the position adjustment. To give the position as a
    string, strip the function name of the `position_` prefix. For
    example, to use `position_jitter()`, give the position as
    `"jitter"`.

  - For more information and other ways to specify the position, see the
    [layer
    position](https://ggplot2.tidyverse.org/reference/layer_positions.html)
    documentation.

- fraction:

  Fraction of the data to include in the bag.

- coef:

  Scale factor of the fence relative to the bag.

- median, fence, outliers:

  Logical indicators whether to include median, fence, and outliers in
  the composite output.

- show.legend:

  logical. Should this layer be included in the legends? `NA`, the
  default, includes if any aesthetics are mapped. `FALSE` never
  includes, and `TRUE` always includes. It can also be a named logical
  vector to finely select the aesthetics to display.

- inherit.aes:

  If `FALSE`, overrides the default aesthetics, rather than combining
  with them. This is most useful for helper functions that define both
  data and aesthetics and shouldn't inherit behaviour from the default
  plot specification, e.g.
  [`borders()`](https://ggplot2.tidyverse.org/reference/annotation_borders.html).

- ...:

  Arguments passed on to [`stat_depth`](stat_depth.md)

  `notion`

  :   Character; the name of the depth function (passed to
      [`ddalpha::depth.()`](https://rdrr.io/pkg/ddalpha/man/depth..html)).

  `notion_params`

  :   List of additional parameters passed via `...` to
      [`ddalpha::depth.()`](https://rdrr.io/pkg/ddalpha/man/depth..html).

## Value

A [ggproto](gggda-ggproto.md)
[layer](https://ggplot2.tidyverse.org/reference/layer.html).

## Details

A bagplot comprises a single, often filled, depth contour (the "bag")
overlaid with the hull of its union with the data points contained in
its scaled expansion from the depth median (the "fence") and a
scatterplot of outliers beyond the fence (the "loop"). Rousseeuw &al
(1999) suggest the term "bag-and-bolster plot" evocative of the
"box-and-whisker plot".

While the depth median can be obtained using
[`stat_center()`](stat_center.md), the data depth values used to compute
it are also used to demarcate the bag, so it is implemented separately
in `StatBagplot$compute_group()` for efficiency.

`stat_bagplot()` is designed to pair with
[`geom_bagplot()`](geom_bagplot.md), analogously to the pairing of
[`ggplot2::stat_boxplot()`](https://ggplot2.tidyverse.org/reference/geom_boxplot.html)
with
[`ggplot2::geom_boxplot()`](https://ggplot2.tidyverse.org/reference/geom_boxplot.html).
In particular, `GeomBagplot` is the only `ggproto` that recognizes the
computed variable `component`, used by `StatBagplot` to separate data
for the four bagplot elements.

## Multidimensional position aesthetics

This statistical transformation is compatible with the convenience
function [`aes_coord()`](aes-coord.md).

Some transformations (e.g. [`stat_center()`](stat_center.md)) commute
with projection to the lower (1 or 2)-dimensional biplot space. If they
detect aesthetics of the form `..coord[0-9]+`, then `..coord1` and
`..coord2` are converted to `x` and `y` while any remaining are ignored.

Other transformations (e.g. [`stat_spantree()`](stat_spantree.md)) yield
different results in a lower-dimensional biplot when they are computed
before versus after projection. If the stat layer detects these
aesthetics, then the transformation is performed before projection, and
the results in the first two dimensions are returned as `x` and `y`.

A small number of transformations ([`stat_rule()`](stat_rule.md)) are
incompatible with these aesthetics but will accept
[`aes_coord()`](aes-coord.md) without warning.

## Computed variables

These are calculated during the statistical transformation and can be
accessed with [delayed
evaluation](https://ggplot2.tidyverse.org/reference/aes_eval.html).

- `component`:

  the component of the composite plot; used internally

## References

Rousseeuw PJ, Ruts I, & Tukey JW (1999) "The Bagplot: A Bivariate
Boxplot". *The American Statistician*, **53**(4): 382–387.
[doi:10.1080/00031305.1999.10474494](https://doi.org/10.1080/00031305.1999.10474494)

## See also

Other stat layers: [`stat_center()`](stat_center.md),
[`stat_chull()`](stat_chull.md), [`stat_cone()`](stat_cone.md),
[`stat_depth()`](stat_depth.md), [`stat_rule()`](stat_rule.md),
[`stat_scale()`](stat_scale.md), [`stat_spantree()`](stat_spantree.md)

## Examples

``` r
# petroleum rock base plot
p <- ggplot(rock, aes(area, shape, size = peri)) + theme_bw()
# scatterplot
p + geom_point()

# NB: Non-standard aesthetics are handled as in version > 3.5.1; see:
# https://github.com/tidyverse/ggplot2/issues/6191
# custom bag fraction, coefficient, and aesthetics
p + stat_bagplot(fraction = .4, coef = 1.5,
                 outlier_gp = list(shape = "asterisk"))
#> Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
#> ℹ Please use `linewidth` instead.
#> Warning: The following aesthetics were dropped during statistical transformation: size.
#> ℹ This can happen when ggplot fails to infer the correct grouping structure in
#>   the data.
#> ℹ Did you forget to specify a `group` aesthetic or to convert a numerical
#>   variable into a factor?

# invisible fence
p + stat_bagplot(fence = FALSE)
#> Warning: The following aesthetics were dropped during statistical transformation: size.
#> ℹ This can happen when ggplot fails to infer the correct grouping structure in
#>   the data.
#> ℹ Did you forget to specify a `group` aesthetic or to convert a numerical
#>   variable into a factor?
```
