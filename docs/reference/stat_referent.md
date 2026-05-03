# Transformations with respect to reference data

Compute statistics with respect to a reference data set with shared
positional variables.

## Usage

``` r
stat_referent(
  mapping = NULL,
  data = NULL,
  geom = "blank",
  position = "identity",
  referent = NULL,
  show.legend = NA,
  inherit.aes = TRUE,
  ...
)

# S3 method for class 'LayerRef'
ggplot_add(object, plot, ...)
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

- object:

  An object to add to the plot

- plot:

  The ggplot object to add `object` to

## Value

A [ggproto](gggda-ggproto.md)
[layer](https://ggplot2.tidyverse.org/reference/layer.html).

## Details

Often in geometric data analysis a statistical transformation applied to
data \\(X\\) will also depend on data \\(Y\\), for example when drawing
the projections of vectors \\(X\\) onto vectors \\(Y\\). The stat layer
`stat_referent()` accepts \\(Y\\) as an argument to the `referent`
parameter and pre-processes them using the existing positional aesthetic
mappings to `x` and `y`.

The ggproto can be used as a parent to more elaborate statistical
transformations, or the stat can be paired with geoms that expect the
`referent` parameter and use it to position their transformations of
\\(X\\). It pairs by default to `[ggplot2::geom_blank()]` so as to
prevent possibly confusing output.

## Examples

``` r
# simplify the Motor Trends data to two predictors legible at aspect ratio 1
mtcars %>%
  transform(hp00 = hp/100) %>%
  subset(select = c(mpg, hp00, wt)) ->
  subcars
# compute the gradient of `mpg` against these two predictors
lm(mpg ~ hp00 + wt, subcars) %>%
  coefficients() %>%
  as.list() %>% as.data.frame() ->
  grad
# use the gradient as a reference (to no effect in this basic ggproto)
ggplot(subcars, aes(x = hp00, y = wt)) +
  coord_equal() +
  geom_point() +
  stat_referent(referent = grad)

ggplot(subcars, aes(x = hp00, y = wt)) +
  coord_equal() +
  stat_referent(geom = "point", referent = grad)
```
