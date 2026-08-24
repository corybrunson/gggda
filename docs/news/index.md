# Changelog

## gggda 0.2.0

CRAN release: 2026-07-18

### patch bug due to mlpack upgrade

The trigger for this minor version is an upgrade to {mlpack} that makes
an API change ([\#19](https://github.com/corybrunson/gggda/issues/19)).
Thanks to [@rcurtin](https://github.com/rcurtin) for the patch.

### component aesthetics in isolines, axes, and rules (breaking change)

Component aesthetics like `text.size` are bundled into lists like
`text_gp` for convenient handling by these three `Geom*` ggprotos, as
was previously done for the bagplot geom. `text.angle` and `label.angle`
are handled circuitously so that the value passed is used as the offset
from the angle of the primary geometric element.

### label placement for axis geom (breaking change)

A new `label_placement` parameter controls where axis labels are placed.
Previously they were placed along the axis at the end (intersection with
the plot window border) farther from the origin. This is now the
`"peripheral"` option, while the default is `"positive"`, which places
them at the end at which the axis takes a greater value.

### outlier control for bagplots

New `outlier_points` and `outlier_labels` parameters toggle these
elements of bagplots. Additional text aesthetics are introduced for the
latter.

### pre-processing of referent data

As with the `data` argument, the `referent` argument of
[`stat_referent()`](../reference/stat_referent.md) can now be passed a
function, which will be evaluated at `data` to obtain the reference data
for the plot layer. The evaluation is done during addition of a layer of
class `LayerRef`.

## gggda 0.1.1

CRAN release: 2025-07-19

This patch fixes a bug in the peel stat and adds unit tests for it and
the scale stat.

To resolve outstanding CRAN checks, a cross-reference to {ordr} has been
replaced with a URL and {dplyr} and {tidyr} functions previously called
using the double-colon operator have been imported instead.

## gggda 0.1.0

CRAN release: 2025-07-09

The inaugural version of {gggda} was spun off the post-v0.1.1
development version of {ordr}. Upgrades to {ordr} components since that
release that are included in {gggda} are listed here.

### infrastructure and standards

#### unit tests

Unit tests have been written for all ggproto shortcuts.

### new coordinate systems

#### GDA-geared coordinate systems

Two new coordinate systems provide control over the aspect ratio of the
plotting window without compromising that of the (artificial) coordinate
axes: `GeomRect` (alias `GeomSquare`) extends `GeomFixed` with an
`window_ratio` parameter for the plotting window, while `GeomBiplot`
removes the `ratio` parameter and forces the coordinate axes to have
aspect ratio 1.

### up( or down)grades to existing plot layers

#### combined vector and radiating text geom (breaking change)

The ‘vector’ and ‘text_radiate’ geoms have been combined. The shortcut
[`geom_text_radiate()`](../reference/geom_text_radiate.md) is
deprecated, and [`geom_vector()`](../reference/geom_vector.md) generates
radiating labels by default.

#### debugged axis geom

The ‘axis’ and ‘isoline’ geoms hit trouble when one or more points lay
at the origin (`x^2 + y^2 == 0`). These cases have now been removed in
`setup_data()`.

#### reconciliation of summary functions

The ‘center’ and ‘star’ stats now follow the ‘summary’ stat convention
of using `fun`, so `fun.center` is deprecated. Additionally, `fun.ord`
accepts a function that summarizes the columns of a matrix, which
accommodates summaries like the depth median that do not decompose along
orthogonal axes.

#### revamped handling of secondary aesthetics (breaking change)

Previously, underscore-separated parameters like `label_colour` were
used to specify secondary aesthetics, i.e. aesthetics for graphical
objects other than those considered “primary” for the layer. Their
behavior has been debugged by mimicking the use of period-separated
parameters like `label.colour` in {ggplot2} v3.5.1, except for the new
bagplot geom, for which their behavior is based on that of
[`geom_boxplot()`](https://ggplot2.tidyverse.org/reference/geom_boxplot.html)
in the current development version of {ggplot2}. This induces some
breaking changes due to the renaming of most, and the removal of some,
such parameters.

#### deprecation of scale stat

The simple and experimental `StatScale` has been deprecated.

### new plot layers

#### referential stats

A new statistical transformation serves to parent specific “referential
stats”, meaning those that depend on non-inherited (in this setting,
positional) data to transform the inherited data. The reference data are
passed to the new `referent` parameter. The new stat is coupled with an
additional `LayerRef` class that enables
[`ggplot_add()`](https://ggplot2.tidyverse.org/reference/update_ggplot.html)
to pass the inherited positional aesthetics to `$setup_params()`.
Biplot-specific `stat_*_*()` shortcuts accept additional argument types
to `referent` that result in the opposite matrix factor being used as
reference data.

#### rule stat

A new ‘rule’ statistical transformation computes additional position
aesthetics that the ‘axis’ geom uses to limit and offset axes. The stat
is referential and expects a set of functions that compute limits
`lower` and `upper` along the axes and `yintercept` and `xintercept`
associated with offset axes. The ‘axis’ geom preprocesses these
aesthetics to rule endpoints `xmin,ymin,xmax,ymax` and offset vectors
`xend,yend` to force the plotting window to contain the limited axis
segments or, if the axes remain lines, the offsets where they are
centered.

#### peel stat

A new ‘peel’ statistical transformation computes nested convex hulls
containing specified fractions of data.

#### depth stat

A new ‘depth’ statistical transformation estimates depth across a grid
and is paired with `GeomContour` to produce depth contours, which can be
used to plot alpha bags.

#### adapted density stat & geom

Aided by element standardization, the classic `density_2d` statistical
transformation and geometric construction are adapted to biplots.
Currently, source code generation does not respect fixed parameters
passed to
[`layer()`](https://ggplot2.tidyverse.org/reference/layer.html) by the
`stat_*()` and `geom_*()` shortcuts; as a consequence, `contour = TRUE`
must be manually passed to `geom_*_density_2d()`.
