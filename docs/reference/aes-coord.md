# Multidimensional coordinate mappings

Allow stat layers to receive a sequence of positional variables rather
than only `x` and `y`.

## Usage

``` r
aes_coord(.data, prefix)

get_aes_coord(data)

aes_c(...)
```

## Arguments

- .data, data:

  A data frame. `.data` stands in for the data passed to
  [`ggplot2::ggplot()`](https://ggplot2.tidyverse.org/reference/ggplot.html),
  while `data` is expected to have been pre-processed before being
  passed to a `Stat*$compute_*()` function.

- prefix:

  A regular expression used to identify the coordinate columns of
  `.data`.

- ...:

  objects to be concatenated. All
  [`NULL`](https://rdrr.io/r/base/NULL.html) entries are dropped before
  method dispatch unless at the very beginning of the argument list.

## Value

A list with class `uneval`. Components of the list are either quosures
or constants.

## Details

These functions coordinate (pun intended) the use of more than two
positional variables in plot layers. Pass multidimensional coordinates
to a stat via `mapping = aes_coord(...)` and reconcile the recovered
coordinates with `x` and `y` (which are overridden if present) in
`Stat*$compute_*()`; see the [StatChull](gggda-ggproto.md) source code
for an example. Use `aes_c()` to concatenate aesthetic mappings.

## See also

[`ggplot2::aes()`](https://ggplot2.tidyverse.org/reference/aes.html) for
standard **ggplot2** aesthetic mappings.
