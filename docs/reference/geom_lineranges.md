# Intervals depicting ranges, usually about center points

`geom_lineranges()` renders horizontal and vertical intervals for a
specified subject or variable; `geom_pointranges()` additionally renders
a point at their crosshairs.

## Usage

``` r
geom_lineranges(
  mapping = NULL,
  data = NULL,
  stat = "center",
  position = "identity",
  ...,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
)

geom_pointranges(
  mapping = NULL,
  data = NULL,
  stat = "center",
  position = "identity",
  ...,
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
  can be used to override the default coupling between geoms and stats.
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

- na.rm:

  Passed to
  [`ggplot2::layer()`](https://ggplot2.tidyverse.org/reference/layer.html).

- show.legend:

  logical. Should this layer be included in the legends? `NA`, the
  default, includes if any aesthetics are mapped. `FALSE` never
  includes, and `TRUE` always includes. It can also be a named logical
  vector to finely select the aesthetics to display. To include legend
  keys for all levels, even when no data exists, use `TRUE`. If `NA`,
  all levels are shown in legend, but unobserved levels are omitted.

- inherit.aes:

  If `FALSE`, overrides the default aesthetics, rather than combining
  with them. This is most useful for helper functions that define both
  data and aesthetics and shouldn't inherit behaviour from the default
  plot specification, e.g.
  [`annotation_borders()`](https://ggplot2.tidyverse.org/reference/annotation_borders.html).

## Value

A [ggproto](gggda-ggproto.md)
[layer](https://ggplot2.tidyverse.org/reference/layer.html).

## Details

The `geom_*ranges()` layers are shortcuts for equivalently-specified
pairs of horizontal and vertical
[`ggplot2::geom_*range()`](https://ggplot2.tidyverse.org/reference/geom_linerange.html)
layers. Rather than
[`ggplot2::stat_identity()`](https://ggplot2.tidyverse.org/reference/stat_identity.html),
they default to [`stat_center()`](stat_center.md), so that in practice
the summary values do not need to be manually passed.

## Aesthetics

`geom_lineranges()` and `geom_pointranges()` understand the following
aesthetics (required aesthetics are in bold):

- **`x`**

- **`xmin`**

- **`xmax`**

- **`y`**

- **`ymin`**

- **`ymax`**\`

- `alpha`

- `colour`

- `linewidth`

- `linetype`

- `size`

- `group`

## See also

Other geom layers: [`geom_axis()`](geom_axis.md),
[`geom_bagplot()`](geom_bagplot.md),
[`geom_isoline()`](geom_isoline.md), [`geom_rule()`](geom_rule.md),
[`geom_text_radiate()`](geom_text_radiate.md),
[`geom_vector()`](geom_vector.md)

## Examples

``` r
ggplot(mpg, aes(x = displ, y = hwy, color = drv)) +
  geom_point(alpha = .25) +
  geom_lineranges()
#> No center function supplied; defaulting to `mean_se()`
#> This message is displayed once per session.


if (require(Hmisc)) {
  ggplot(mpg, aes(x = displ, y = hwy, color = drv)) +
    geom_point(alpha = .25) +
    geom_pointranges(fun.data = mean_sdl, shape = "circle open")
}
#> Loading required package: Hmisc
#> 
#> Attaching package: ‘Hmisc’
#> The following objects are masked from ‘package:base’:
#> 
#>     format.pval, units


mpg %>% 
  aggregate(
    x = cbind(displ, hwy) ~ 0,
    FUN = function(z) c(min = min(z), med = median(z), max = max(z))
  ) %>% 
  do.call(what = data.frame) %>% 
  ggplot(aes(displ.med, hwy.med)) +
  geom_pointranges(
    stat = "identity",
    aes(xmin = displ.min, xmax = displ.max, ymin = hwy.min, ymax = hwy.max)
  ) +
  geom_point(data = mpg, aes(displ, hwy), alpha = .5)
```
