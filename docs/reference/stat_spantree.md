# Calculate a minimum spanning tree among cases or variables

This stat layer identifies the \\n-1\\ pairs among \\n\\ points that
form a minimum spanning tree, then calculates the segments between these
poirs in the two dimensions `x` and `y`.

## Usage

``` r
stat_spantree(
  mapping = NULL,
  data = NULL,
  geom = "segment",
  position = "identity",
  engine = "mlpack",
  method = "euclidean",
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

- engine:

  A single character string specifying the package implementation to
  use; `"mlpack"`, `"vegan"`, or `"ade4"`.

- method:

  Passed to [`stats::dist()`](https://rdrr.io/r/stats/dist.html) if
  `engine` is `"vegan"` or `"ade4"`, ignored if `"mlpack"`.

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

- ...:

  Additional arguments passed to
  [`ggplot2::layer()`](https://ggplot2.tidyverse.org/reference/layer.html).

## Value

A [ggproto](gggda-ggproto.md)
[layer](https://ggplot2.tidyverse.org/reference/layer.html).

## Details

A minimum spanning tree (MST) on the point cloud \\X\\ is a minimal
connected graph on \\X\\ with the smallest possible sum of distances (or
dissimilarities) between linked points. These layers call
[`stats::dist()`](https://rdrr.io/r/stats/dist.html) to calculate a
distance/dissimilarity object and an engine from **mlpack**, **vegan**,
or **ade4** to calculate the MST. The result is formatted with position
aesthetics readable by
[`ggplot2::geom_segment()`](https://ggplot2.tidyverse.org/reference/geom_segment.html).

An MST calculated on `x` and `y` reflects the distances among the points
in \\X\\ in the reduced-dimension plane of the biplot. In contrast, one
calculated on the full set of coordinates reflects distances in
higher-dimensional space. Plotting this high-dimensional MST on the
2-dimensional biplot provides a visual cue as to how faithfully two
dimensions can encapsulate the "true" distances between points
(Jolliffe, 2002).

## Multidimensional position aesthetics

This statistical transformation is compatible with the convenience
function [`aes_coord()`](aes-coord.md).

Some transformations (e.g. [`stat_center()`](stat_center.md)) commute
with projection to the lower (1 or 2)-dimensional biplot space. If they
detect aesthetics of the form `..coord[0-9]+`, then `..coord1` and
`..coord2` are converted to `x` and `y` while any remaining are ignored.

Other transformations (e.g. `stat_spantree()`) yield different results
in a lower-dimensional biplot when they are computed before versus after
projection. If the stat layer detects these aesthetics, then the
transformation is performed before projection, and the results in the
first two dimensions are returned as `x` and `y`.

A small number of transformations ([`stat_rule()`](stat_rule.md)) are
incompatible with these aesthetics but will accept
[`aes_coord()`](aes-coord.md) without warning.

## Computed variables

These are calculated during the statistical transformation and can be
accessed with [delayed
evaluation](https://ggplot2.tidyverse.org/reference/aes_eval.html).

- `xend,yend,x,y`:

  endpoints of tree branches (segments)

## References

Jolliffe IT (2002) *Principal Component Analysis*, Second Edition.
Springer Series in Statistics, ISSN 0172-7397.
[doi:10.1007/b98835](https://doi.org/10.1007/b98835)
<https://link.springer.com/book/10.1007/b98835>

## See also

Other stat layers: [`stat_bagplot()`](stat_bagplot.md),
[`stat_center()`](stat_center.md), [`stat_chull()`](stat_chull.md),
[`stat_cone()`](stat_cone.md), [`stat_delaunay()`](stat_delaunay.md),
[`stat_depth()`](stat_depth.md), [`stat_rule()`](stat_rule.md),
[`stat_scale()`](stat_scale.md), [`stat_voronoi()`](stat_voronoi.md)

## Examples

``` r
eurodist %>% 
  cmdscale(k = 6) %>% 
  as.data.frame() %>% 
  tibble::rownames_to_column(var = "city") ->
  euro_mds
ggplot(euro_mds, aes(V1, V2, label = city)) +
  stat_spantree() +
  geom_label(alpha = .25)
#> Warning: Package {mlpack} not installed; using {vegan} instead.
#> This warning is displayed once every 8 hours.

ggplot(euro_mds, aes_c(aes_coord(euro_mds, "V"), aes(label = city))) +
  stat_spantree() +
  geom_label(aes(x = V1, y = V2), alpha = .25)
```
