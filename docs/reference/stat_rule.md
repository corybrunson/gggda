# Construct limited rules offset from the origin

Determine axis limits and offset vectors from reference data.

## Usage

``` r
stat_rule(
  mapping = NULL,
  data = NULL,
  geom = "rule",
  position = "identity",
  fun.lower = "minpp",
  fun.upper = "maxpp",
  fun.offset = "minabspp",
  fun.args = list(),
  referent = NULL,
  show.legend = NA,
  inherit.aes = TRUE,
  ...
)

minpp(x, p = 0.1)

maxpp(x, p = 0.1)

minabspp(x, p = 0.1)
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

- fun.lower, fun.upper, fun.offset:

  Functions used to determine the limits of the rules and the
  translations of the axes from the projections of `referent` onto the
  axes and onto their normal vectors.

- fun.args:

  Optional additional arguments passed on to the functions.

- referent:

  The reference data set; see Details.

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

  Additional arguments passed to
  [`ggplot2::layer()`](https://ggplot2.tidyverse.org/reference/layer.html).

- x:

  A numeric vector.

- p:

  A numeric value; the proportion of a range used as a buffer.

## Value

A [ggproto](gggda-ggproto.md)
[layer](https://ggplot2.tidyverse.org/reference/layer.html).

## Details

Biplots with several axes can become cluttered and illegible. When this
happens, Gower, Gardner–Lubbe, & le Roux (2011) recommend to translate
the axes to a new point of intersection away from the origin, adjusting
the axis markers accordingly. Then the axes converge in a region of the
plot offset from most position markers or other elements. An alternative
solution, implemented in the **bipl5** package
(<https://github.com/RuanBuys/bipl5>), is to translate each axis
orthogonally away from the origin, which preserves the axis markers.
This is the technique implemented here.

Separately, axes that fill the plotting window are uninformative when
they exceed the range of the plotted position markers projected onto
them. They may even be misinformative, suggesting that linear
relationships extrapolate outside the data range. In these cases, Gower
and Harding (1988) recommend using finite ranges determined by the data
projection onto each axis.

Three functions control these operations: `fun.offset` computes the
orthogonal distance of each axis from the origin, and `fun.lower` and
`fun.upper` compute the distance along each axis of the endpoints to the
(offset) origin. Both functions depend on what position data is to be
offset from or limited to, which must be passed manually to the
`referent` parameter.

## Referential stats

This statistical transformation is done with respect to reference data
passed to `referent` (ignored if `NULL`, the default, possibly resulting
in empty output). See [`stat_referent()`](stat_referent.md) for more
details. This relies on a sleight of hand through a new undocumented
`LayerRef` class and associated
[`ggplot2::ggplot_add()`](https://ggplot2.tidyverse.org/reference/update_ggplot.html)
method. As a result, only layers constructed using this `stat_*()`
shortcut will pass the necessary positional aesthetics to the
`$setup_params()` step, making them available to pre-process `referent`
data.

The biplot shortcuts automatically substitute the complementary matrix
factor for `referent = NULL` and will use an integer vector to select a
subset from this factor. These uses do not require the mapping passage.

## Computed variables

These are calculated during the statistical transformation and can be
accessed with [delayed
evaluation](https://ggplot2.tidyverse.org/reference/aes_eval.html).

- `axis`:

  unique axis identifier (integer)

- `lower,upper`:

  distances to endpoints from origin (before offset)

- `yintercept,xintercept`:

  intercepts (possibly `Inf`) of offset axis

## References

Gower JC, Gardner–Lubbe S, & le Roux NJ (2011) *Understanding Biplots*.
Wiley, ISBN: 978-0-470-01255-0. <https://www.wiley.com/go/biplots>

Gower JC & Harding SA (1988) "Nonlinear biplots". *Biometrika*
**75**(3): 445–455.
[doi:10.1093/biomet/75.3.445](https://doi.org/10.1093/biomet/75.3.445)

## See also

Other stat layers: [`stat_bagplot()`](stat_bagplot.md),
[`stat_center()`](stat_center.md), [`stat_chull()`](stat_chull.md),
[`stat_cone()`](stat_cone.md), [`stat_depth()`](stat_depth.md),
[`stat_scale()`](stat_scale.md), [`stat_spantree()`](stat_spantree.md)

## Examples

``` r
# stack loss gradient
stackloss %>% 
  lm(formula = stack.loss ~ Air.Flow + Water.Temp + Acid.Conc.) %>% 
  coef() %>% 
  as.list() %>% as.data.frame() %>% 
  subset(select = c(Air.Flow, Water.Temp, Acid.Conc.)) ->
  coef_data
# gradient rule with respect to two predictors
stackloss_centered <- scale(stackloss, scale = FALSE)
stackloss_centered %>% 
  ggplot(aes(x = Acid.Conc., y = Air.Flow)) +
  coord_square() +
  geom_point(aes(size = stack.loss, alpha = sign(stack.loss))) + 
  scale_size_area() + scale_alpha_binned(breaks = c(-1, 0, 1)) +
  stat_rule(
    geom = "axis",
    data = coef_data,
    referent = stackloss_centered,
    fun.offset = function(x) minabspp(x, p = .5)
  )
```
