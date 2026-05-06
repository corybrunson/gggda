# Bagplots

Render bagplots from tagged data comprising medians, hulls, contours,
and outlier specifications.

## Usage

``` r
geom_bagplot(
  mapping = NULL,
  data = NULL,
  stat = "bagplot",
  position = "identity",
  ...,
  bag.linewidth = sync(),
  bag.linetype = sync(),
  bag.colour = "black",
  bag.color = NULL,
  bag.fill = sync(),
  bag.alpha = NA,
  median.shape = 21L,
  median.stroke = sync(),
  median.size = 5,
  median.colour = sync(),
  median.color = NULL,
  median.fill = "white",
  median.alpha = NA,
  fence.linewidth = 0.25,
  fence.linetype = 0L,
  fence.colour = sync(),
  fence.color = NULL,
  fence.fill = sync(),
  fence.alpha = 0.25,
  outlier.shape = sync(),
  outlier.stroke = sync(),
  outlier.size = sync(),
  outlier.colour = sync(),
  outlier.color = NULL,
  outlier.fill = NA,
  outlier.alpha = NA,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
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

- stat:

  The statistical transformation to use on the data for this layer. When
  using a `geom_*()` function to construct a layer, the `stat` argument
  can be used the override the default coupling between geoms and stats.
  The `stat` argument accepts the following:

  - A `Stat` ggproto subclass, for example `StatCount`.

  - A string naming the stat. To give the stat as a string, strip the
    function name of the `stat_` prefix. For example, to use
    `stat_count()`, give the stat as `"count"`.

  - For more information and other ways to specify the stat, see the
    [layer
    stat](https://ggplot2.tidyverse.org/reference/layer_stats.html)
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

- ...:

  Additional arguments passed to
  [`ggplot2::layer()`](https://ggplot2.tidyverse.org/reference/layer.html).

- bag.linetype, bag.linewidth, bag.colour, bag.color, bag.fill,
  bag.alpha:

  Default aesthetics for bags. Set to [`sync()`](sync.md) to inherit
  from the data's aesthetics or to `NULL` to use the data's aesthetics.

- median.shape, median.stroke, median.size, median.colour, median.color,
  median.fill, median.alpha:

  Default aesthetics for medians. Set to [`sync()`](sync.md) to inherit
  from the data's aesthetics or to `NULL` to use the data's aesthetics.

- fence.linetype, fence.linewidth, fence.colour, fence.color,
  fence.fill, fence.alpha:

  Default aesthetics for fences. Set to [`sync()`](sync.md) to inherit
  from the data's aesthetics or to `NULL` to use the data's aesthetics.

- outlier.shape, outlier.stroke, outlier.size, outlier.colour,
  outlier.color, outlier.fill, outlier.alpha:

  Default aesthetics for outliers. Set to [`sync()`](sync.md) to inherit
  from the data's aesthetics or to `NULL` to use the data's aesthetics.

- na.rm:

  Passed to
  [`ggplot2::layer()`](https://ggplot2.tidyverse.org/reference/layer.html).

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

## Value

A [ggproto](gggda-ggproto.md)
[layer](https://ggplot2.tidyverse.org/reference/layer.html).

## Details

`geom_bagplot()` is designed to pair with
[`stat_bagplot()`](stat_bagplot.md), analogously to the pairing of
[`ggplot2::geom_boxplot()`](https://ggplot2.tidyverse.org/reference/geom_boxplot.html)
with
[`ggplot2::stat_boxplot()`](https://ggplot2.tidyverse.org/reference/geom_boxplot.html).

Because the optional components are more expensive to compute in this
setting, they are controlled by parameters passed to the stat. Auxiliary
aesthetics like `median.colour` are available that override auxiliary
defaults, and these in turn override the standard defaults. Auxiliary
defaults also take effect when auxiliary aesthetics are passed `NULL`,
so that [`stat_bagplot()`](stat_bagplot.md) and `geom_bagplot()` have
the same default behavior. Pass [`sync()`](sync.md) (instead of `NULL`,
as in
[`ggplot2::geom_boxplot()`](https://ggplot2.tidyverse.org/reference/geom_boxplot.html))
to synchronize an auxiliary aesthetic with its standard counterpart.

**WARNING:** The trade-off between precision and runtime is greater for
depth estimation than for density estimation. At the resolution of the
default \\(100 \times 100\\) grid, basic examples may vary noticeably
when starting from different random seeds.

## Aesthetics

`geom_bagplot()` understands the following aesthetics (required
aesthetics are in bold):

- **`x`**

- **`y`**

- **`component`**

- `linewidth`

- `linetype`

- `colour`

- `fill`

- `alpha`

- `shape`

- `stroke`

- `size`

- `group`

## See also

Other geom layers: [`geom_axis()`](geom_axis.md),
[`geom_isoline()`](geom_isoline.md),
[`geom_lineranges()`](geom_lineranges.md),
[`geom_rule()`](geom_rule.md),
[`geom_text_radiate()`](geom_text_radiate.md),
[`geom_vector()`](geom_vector.md)

## Examples

``` r
# Motor Trends base plot with factorized cylinder counts
p <- mtcars %>% 
  transform(cyl = factor(cyl)) %>% 
  ggplot(aes(x = wt, y = disp)) +
  theme_bw()
# basic bagplot
p + geom_bagplot()

# group by cylinder count
p + geom_bagplot(
  fraction = 0.4, coef = 1.2,
  aes(fill = cyl, linetype = cyl, color = cyl)
)

# using normally unmapped aesthetics
p + geom_bagplot(
  fraction = 0.4, coef = 1.2,
  aes(fill = cyl, linetype = cyl, color = cyl),
  median.color = "black",
  fence.linetype = sync(), fence.colour = "black",
  outlier.shape = "asterisk", outlier.colour = "black"
)
```
