# Axes through or offset from the origin

`geom_axis()` renders lines through or orthogonally translated from the
origin and the position of each case or variable.

## Usage

``` r
geom_axis(
  mapping = NULL,
  data = NULL,
  stat = "identity",
  position = "identity",
  axis_labels = TRUE,
  axis_ticks = TRUE,
  axis_text = TRUE,
  by = NULL,
  num = NULL,
  tick_length = 0.025,
  text_dodge = 0.03,
  label_dodge = 0.03,
  label_placement = c("positive", "negative", "peripheral"),
  ...,
  axis.linewidth = sync(),
  axis.linetype = sync(),
  axis.colour = sync(),
  axis.color = NULL,
  axis.alpha = sync(),
  label.size = sync(),
  label.angle = 0,
  label.hjust = sync(),
  label.vjust = sync(),
  label.family = sync(),
  label.fontface = sync(),
  label.colour = sync(),
  label.color = NULL,
  label.alpha = sync(),
  tick.linewidth = 0.25,
  tick.linetype = "solid",
  tick.colour = sync(),
  tick.color = NULL,
  tick.alpha = sync(),
  text.size = 2.6,
  text.angle = 0,
  text.hjust = sync(),
  text.vjust = sync(),
  text.family = sync(),
  text.fontface = sync(),
  text.colour = sync(),
  text.color = NULL,
  text.alpha = sync(),
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

- axis_labels, axis_ticks, axis_text:

  Logical; whether to include labels, tick marks, and text value marks
  along the axes.

- by, num:

  Intervals between elements or number of elements; specify only one.

- tick_length:

  Numeric; the length of the tick marks, as a proportion of the minimum
  of the plot width and height.

- text_dodge:

  Numeric; the orthogonal distance of tick mark text from the axis, as a
  proportion of the minimum of the plot width and height.

- label_dodge:

  Numeric; the orthogonal distance of the axis label from the axis, as a
  proportion of the minimum of the plot width and height.

- label_placement:

  Character; how to place the labels along the axes. Matched to
  `"positive"` (the default; at the increasing end of the axis),
  `"negative"` (at the decreasing end), `"peripheral"` (at the end
  farther from the origin).

- ...:

  Additional arguments passed to
  [`ggplot2::layer()`](https://ggplot2.tidyverse.org/reference/layer.html).

- axis.linewidth, axis.linetype, axis.colour, axis.color, axis.alpha:

  Default aesthetics for axes. Set to NULL to inherit from the data's
  aesthetics.

- label.size, label.angle, label.hjust, label.vjust, label.family,
  label.fontface, label.colour, label.color, label.alpha:

  Default aesthetics for labels. Set to NULL to inherit from the data's
  aesthetics.

- tick.linewidth, tick.linetype, tick.colour, tick.color, tick.alpha:

  Default aesthetics for tick marks. Set to NULL to inherit from the
  data's aesthetics.

- text.size, text.angle, text.hjust, text.vjust, text.family,
  text.fontface, text.colour, text.color, text.alpha:

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

Axes are lines that track the values of linear variables across a plot.
Multivariate scatterplots may include more axes than plotting
dimensions, in which case the plot may display only a fraction of the
total variation in the data.

Gower & Hand (1996) recommend using axes to represent numerical
variables in biplots. Consequently, Gardner & le Roux (2002) refer to
these as Gower biplots.

Axes positioned orthogonally at the origin are a ubiquitous feature of
scatterplots and used both to recover variable values from case markers
(prediction) and to position new case markers from variables
(interpolation). When they are not orthogonal, these two uses conflict,
so interpolative versus predictive axes must be used appropriately.

## Aesthetics

`geom_axis()` understands the following aesthetics (required aesthetics
are in bold):

- **`x`**

- **`y`**

- `lower`

- `upper`

- `yintercept` *or* `xintercept` *or* `xend` and `yend`

- `linetype`

- `linewidth`

- `size`

- `hjust`

- `vjust`

- `colour`

- `alpha`

- `label`

- `family`

- `fontface`

- `center`, `scale`

- `group`

## References

Gower JC & Hand DJ (1996) *Biplots*. Chapman & Hall, ISBN:
0-412-71630-5.

Gardner S, le Roux N (2002) "Biplot Methodology for Discriminant
Analysis Based upon Robust Methods and Principal Curves".
*Classification, Clustering, and Data Analysis: Recent Advances and
Applications*: 169–176.
<https://link.springer.com/chapter/10.1007/978-3-642-56181-8_18>

## See also

Other geom layers: [`geom_bagplot()`](geom_bagplot.md),
[`geom_isoline()`](geom_isoline.md),
[`geom_lineranges()`](geom_lineranges.md),
[`geom_rule()`](geom_rule.md),
[`geom_text_radiate()`](geom_text_radiate.md),
[`geom_vector()`](geom_vector.md), [`geom_voronoi()`](geom_voronoi.md)

## Examples

``` r
# stack loss gradient
stackloss %>% 
  lm(formula = stack.loss ~ Air.Flow + Water.Temp + Acid.Conc.) %>% 
  coef() %>% 
  as.list() %>% as.data.frame() %>% 
  subset(select = c(Air.Flow, Water.Temp, Acid.Conc.)) %>%
  transform(regressand = "stack.loss") ->
  coef_data
# gradient axis with respect to two predictors
scale(stackloss, scale = FALSE) %>% 
  ggplot(aes(x = Acid.Conc., y = Air.Flow)) +
  coord_square() +
  geom_point(aes(size = abs(stack.loss), alpha = sign(stack.loss))) + 
  scale_size_area() + scale_alpha_binned(breaks = c(-1, 0, 1)) +
  geom_axis(data = coef_data, aes(label = regressand))

# unlimited axes with window forcing
stackloss_centered <- scale(stackloss, scale = FALSE)
stackloss_centered %>% 
  ggplot(aes(x = Acid.Conc., y = Air.Flow)) +
  coord_square() +
  geom_point(aes(size = abs(stack.loss), alpha = sign(stack.loss))) + 
  scale_size_area() + scale_alpha_binned(breaks = c(-1, 0, 1)) +
  stat_rule(
    geom = "axis", data = coef_data, aes(label = regressand),
    referent = stackloss_centered,
    label_placement = "negative",
    fun.lower = function(x) minpp(x, p = 1),
    fun.upper = function(x) maxpp(x, p = 1),
    fun.offset = function(x) minabspp(x, p = 1)
  )

# NB: `geom_axis(stat = "rule")` would fail to pass positional aesthetics.

# eigen-decomposition of covariance matrix
ability.cov$cov %>% 
  cov2cor() %>% 
  eigen() %>% getElement("vectors") %>% 
  as.data.frame() %>% 
  transform(test = rownames(ability.cov$cov)) ->
  ability_cor_eigen
# test axes in best-approximation space
ability_cor_eigen %>% 
  transform(E3 = ifelse(V3 > 0, "rise", "fall")) %>% 
  ggplot(aes(V1, V2, color = E3)) +
  coord_square() +
  geom_axis(
    aes(label = test),
    text.color = "black", text.alpha = .5, text.angle = -15
  ) +
  expand_limits(x = c(-1, 1), y = c(-1, 1))
```
