# Package index

## ‘gggda’ package

Visualization methods from and for geometric data analysis

- [`gggda`](gggda.md) [`gggda-package`](gggda.md) :

  **gggda** package

## GDA tools

Helper functions to perform geometric data analysis.

- [`peel_hulls()`](peel_hulls.md) : Bivariate data peelings
- [`depth_median()`](depth_median.md) : Depth median

## ‘ggproto’ classes

New `'ggproto'` classes.

- [`gggda-ggproto`](gggda-ggproto.md) [`CoordRect`](gggda-ggproto.md)
  [`GeomAxis`](gggda-ggproto.md) [`GeomBagplot`](gggda-ggproto.md)
  [`GeomPointranges`](gggda-ggproto.md)
  [`GeomLineranges`](gggda-ggproto.md) [`GeomIsoline`](gggda-ggproto.md)
  [`GeomRule`](gggda-ggproto.md) [`GeomTextRadiate`](gggda-ggproto.md)
  [`GeomVector`](gggda-ggproto.md) [`GeomVoronoi`](gggda-ggproto.md)
  [`GeomThiessen`](gggda-ggproto.md) [`StatChull`](gggda-ggproto.md)
  [`StatPeel`](gggda-ggproto.md) [`StatDepth`](gggda-ggproto.md)
  [`StatDepthFilled`](gggda-ggproto.md)
  [`StatBagplot`](gggda-ggproto.md) [`StatCenter`](gggda-ggproto.md)
  [`StatStar`](gggda-ggproto.md) [`StatCone`](gggda-ggproto.md)
  [`StatDelaunay`](gggda-ggproto.md) [`StatReferent`](gggda-ggproto.md)
  [`StatRule`](gggda-ggproto.md) [`StatScale`](gggda-ggproto.md)
  [`StatSpantree`](gggda-ggproto.md) [`StatVoronoi`](gggda-ggproto.md) :
  ggproto classes created and adapted for gggda

## Coordinate systems

New `Coord*` ggprotos and `coord_*()` layers.

- [`coord_rect()`](coord_rect.md) : Cartesian coordinates and plotting
  window with fixed aspect ratios

## Statistical transformations

New `Stat*` ggprotos and `stat_*()` layers.

- [`stat_referent()`](stat_referent.md)
  [`ggplot_add(`*`<LayerRef>`*`)`](stat_referent.md) : Transformations
  with respect to reference data
- [`stat_bagplot()`](stat_bagplot.md) : Bagplots
- [`stat_center()`](stat_center.md) [`stat_star()`](stat_center.md) :
  Centers and spreads for bivariate data
- [`stat_chull()`](stat_chull.md) [`stat_peel()`](stat_chull.md) :
  Convex hulls and hull peelings
- [`stat_cone()`](stat_cone.md) : Conical hull
- [`stat_delaunay()`](stat_delaunay.md) : Delaunay triangulation
- [`stat_depth()`](stat_depth.md) [`stat_depth_filled()`](stat_depth.md)
  : Depth estimates and contours
- [`stat_rule()`](stat_rule.md) [`minpp()`](stat_rule.md)
  [`maxpp()`](stat_rule.md) [`minabspp()`](stat_rule.md) : Construct
  limited rules offset from the origin
- [`stat_scale()`](stat_scale.md) : Multiply artificial coordinates by a
  scale factor
- [`stat_spantree()`](stat_spantree.md) : Calculate a minimum spanning
  tree among cases or variables
- [`stat_voronoi()`](stat_voronoi.md) : Voronoi tessellation

## Geometric constructions

New `Geom*` ggprotos and `geom_*()` layers.

- [`geom_axis()`](geom_axis.md) : Axes through or offset from the origin
- [`geom_bagplot()`](geom_bagplot.md) : Bagplots
- [`geom_isoline()`](geom_isoline.md) : Isolines (contour lines)
- [`geom_lineranges()`](geom_lineranges.md)
  [`geom_pointranges()`](geom_lineranges.md) : Intervals depicting
  ranges, usually about center points
- [`geom_rule()`](geom_rule.md) : Rulers through or offset from the
  origin
- [`geom_text_radiate()`](geom_text_radiate.md) : Text radiating outward
  from the origin
- [`geom_vector()`](geom_vector.md) : Vectors from the origin
- [`geom_voronoi()`](geom_voronoi.md)
  [`geom_thiessen()`](geom_voronoi.md) : Voronoi tessellation

## Aesthetic mapping

Functions for handling aesthetic mappings.

- [`aes_coord()`](aes-coord.md) [`get_aes_coord()`](aes-coord.md)
  [`aes_c()`](aes-coord.md) : Multidimensional coordinate mappings

## Themes

New themes and theme elements.

- [`draw_key_line()`](draw-key.md)
  [`draw_key_crosslines()`](draw-key.md)
  [`draw_key_crosspoint()`](draw-key.md) : Key drawing functions for
  bivariate intervals.
