# Vectors from the origin

`geom_vector()` renders arrows from the origin to points, optionally
with text radiating outward.

## Usage

``` r
geom_vector(
  mapping = NULL,
  data = NULL,
  stat = "identity",
  position = "identity",
  arrow = default_arrow,
  lineend = "round",
  linejoin = "mitre",
  vector_labels = TRUE,
  ...,
  label.colour = NULL,
  label.color = NULL,
  label.alpha = NULL,
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

- arrow:

  Specification for arrows, as created by
  [`grid::arrow()`](https://rdrr.io/r/grid/arrow.html), or else `NULL`
  for no arrows.

- lineend:

  Line end style (round, butt, square).

- linejoin:

  Line join style (round, mitre, bevel).

- vector_labels:

  Logical; whether to include labels radiating outward from the vectors.

- ...:

  Additional arguments passed to
  [`ggplot2::layer()`](https://ggplot2.tidyverse.org/reference/layer.html).

- label.colour, label.color, label.alpha:

  Default aesthetics for labels. Set to NULL to inherit from the data's
  aesthetics.

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

Vectors are positions relative to some common reference point, in this
case the origin; they comprise direction and magnitude. Vectors are
usually represented with arrows rather than markers (points).

Vectors are commonly used to represent numerical variables in biplots,
as by Gabriel (1971) and Greenacre (2010). Gardner & le Roux (2002)
refer to these as Gabriel biplots. This layer, with optional radiating
text labels, is adapted from `ggbiplot()` in the off-CRAN extensions of
the same name (Vu, 2014; Telford, 2017; Gegzna, 2018).

## Aesthetics

`geom_vector()` understands the following aesthetics (required
aesthetics are in bold):

- **`x`**

- **`y`**

- `alpha`

- `colour`

- `linetype`

- `label`

- `size`

- `angle`

- `hjust`

- `vjust`

- `family`

- `fontface`

- `lineheight`

- `group`

## References

Gabriel KR (1971) "The biplot graphic display of matrices with
application to principal component analysis". *Biometrika* 58(3),
453–467.
[doi:10.1093/biomet/58.3.453](https://doi.org/10.1093/biomet/58.3.453)

Greenacre MJ (2010) *Biplots in Practice*. Fundacion BBVA, ISBN:
978-84-923846.
<https://www.fbbva.es/microsite/multivariate-statistics/biplots.html>

Gardner S, le Roux N (2002) "Biplot Methodology for Discriminant
Analysis Based upon Robust Methods and Principal Curves".
*Classification, Clustering, and Data Analysis: Recent Advances and
Applications*: 169–176.
<https://link.springer.com/chapter/10.1007/978-3-642-56181-8_18>

Vincent Q. Vu (2014). ggbiplot: A 'ggplot2' based biplot. R package
version 0.55. <https://github.com/vqv/ggbiplot>, `experimental` branch

Richard J Telford (2017). ggbiplot: A 'ggplot2' based biplot. R package
version 0.6. <https://github.com/richardjtelford/ggbiplot> (fork),
`experimental` branch

Vilmantas Gegzna (2018). ggbiplot: A 'ggplot2' based biplot. R package
version 0.55. <https://github.com/forked-packages/ggbiplot> (fork),
`experimental` branch

## See also

Other geom layers: [`geom_axis()`](geom_axis.md),
[`geom_bagplot()`](geom_bagplot.md),
[`geom_isoline()`](geom_isoline.md),
[`geom_lineranges()`](geom_lineranges.md),
[`geom_rule()`](geom_rule.md),
[`geom_text_radiate()`](geom_text_radiate.md)

## Examples

``` r
# multidimensional scaling of covariances
ability.cov$cov %>% 
  cov2cor() %>%
  eigen() %>% getElement("vectors") %>% 
  as.data.frame() %>% 
  transform(test = rownames(ability.cov$cov)) ->
  ability_cor_eigen
ability_cor_eigen %>% 
  ggplot(aes(-V1, V2, label = test)) +
  coord_square() + theme_void() +
  geom_vector(check_overlap = TRUE) +
  scale_y_continuous(expand = expansion(mult = .2)) +
  ggtitle("Ability and intelligence test covariances")

# multidimensional scaling of correlations
ability.cov$cov %>% 
  eigen() %>% getElement("vectors") %>% 
  as.data.frame() %>% 
  transform(test = rownames(ability.cov$cov)) ->
  ability_cor_eigen
ability_cor_eigen %>% 
  ggplot(aes(-V1, -V2, label = test)) +
  coord_square() + theme_void() +
  geom_vector(check_overlap = TRUE) +
  expand_limits(x = c(-1, 1), y = c(-1, 1)) +
  ggtitle("Ability and intelligence test covariances")
```
