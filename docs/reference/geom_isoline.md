# Isolines (contour lines)

`geom_isoline()` renders isolines along row or column axes.

## Usage

``` r
geom_isoline(
  mapping = NULL,
  data = NULL,
  stat = "identity",
  position = "identity",
  isoline_text = TRUE,
  by = NULL,
  num = NULL,
  text_dodge = 0.03,
  ...,
  text.size = 3,
  text.angle = 0,
  text.colour = NULL,
  text.color = NULL,
  text.alpha = NULL,
  parse = FALSE,
  check_overlap = FALSE,
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

- isoline_text:

  Logical; whether to include text value marks along the isolines.

- by, num:

  Intervals between elements or number of elements; specify only one.

- text_dodge:

  Numeric; the orthogonal distance of the text from the axis or isoline,
  as a proportion of the minimum of the plot width and height.

- ...:

  Additional arguments passed to
  [`ggplot2::layer()`](https://ggplot2.tidyverse.org/reference/layer.html).

- text.size, text.angle, text.colour, text.color, text.alpha:

  Default aesthetics for tick mark labels. Set to NULL to inherit from
  the data's aesthetics.

- parse:

  If `TRUE`, the labels will be parsed into expressions and displayed as
  described in [`?plotmath`](https://rdrr.io/r/grDevices/plotmath.html).

- check_overlap:

  If `TRUE`, text that overlaps previous text in the same layer will not
  be plotted. `check_overlap` happens at draw time and in the order of
  the data. Therefore data should be arranged by the label column before
  calling `geom_text()`. Note that this argument is not supported by
  `geom_label()`.

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

Isolines are topographical features that separate a plot into regions in
which a gradient of interest falls within a specified range. Greenacre
(2010) uses them effectively to assist with the projection of markers
onto axes.

## Aesthetics

`geom_isoline()` understands the following aesthetics (required
aesthetics are in bold):

- **`x`**

- **`y`**

- `colour`

- `alpha`

- `linewidth`

- `linetype`

- `center`, `scale`

- `hjust`

- `vjust`

- `family`

- `fontface`

- `group`

## References

Greenacre MJ (2010) *Biplots in Practice*. Fundacion BBVA, ISBN:
978-84-923846.
<https://www.fbbva.es/microsite/multivariate-statistics/biplots.html>

## See also

Other geom layers: [`geom_axis()`](geom_axis.md),
[`geom_bagplot()`](geom_bagplot.md),
[`geom_lineranges()`](geom_lineranges.md),
[`geom_rule()`](geom_rule.md),
[`geom_text_radiate()`](geom_text_radiate.md),
[`geom_vector()`](geom_vector.md)

## Examples

``` r
# stack loss gradient
stackloss %>% 
  lm(formula = stack.loss ~ Air.Flow + Water.Temp + Acid.Conc.) %>% 
  coef() %>% 
  as.list() %>% as.data.frame() %>% 
  subset(select = c(Air.Flow, Water.Temp, Acid.Conc.)) ->
  coef_data
# isolines along strongest predictors
scale(stackloss, scale = FALSE) %>% 
  ggplot(aes(x = Water.Temp, y = Air.Flow)) +
  coord_square() +
  geom_point(aes(size = stack.loss)) + scale_size_area() +
  geom_isoline(data = coef_data)
```
