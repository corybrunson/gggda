# Key drawing functions for bivariate intervals.

These key drawing functions supplement those built into
**[ggplot2](https://ggplot2.tidyverse.org/reference/ggplot2-package.html)**
for legend glyphs suitable to bivariate [line-ranges and
point-ranges](geom_lineranges.md).

## Usage

``` r
draw_key_line(data, params, size)

draw_key_crosslines(data, params, size)

draw_key_crosspoint(data, params, size)
```

## Arguments

- data:

  A single row data frame containing the scaled aesthetics to display in
  this key

- params:

  A list of additional parameters supplied to the geom.

- size:

  Width and height of key in mm.

## Value

A grid grob.

## Details

`draw_key_line()` is a horizontal counterpart to
[`ggplot2::draw_key_vline()`](https://ggplot2.tidyverse.org/reference/draw_key.html).
`draw_key_crosslines()` superimposes these two keys, and
`draw_key_crosspoint()` additionally superimposes an oversized
[`ggplot2::draw_key_point()`](https://ggplot2.tidyverse.org/reference/draw_key.html).

## See also

[ggplot2::draw_key](https://ggplot2.tidyverse.org/reference/draw_key.html)
for key glyphs installed with **ggplot2**.
