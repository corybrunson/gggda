# Bivariate data peelings

Use convex hulls (and eventually other peelings) to order bivariate
data.

## Usage

``` r
peel_hulls(
  x,
  y = NULL,
  num = NULL,
  by = 1L,
  breaks = c(0.5),
  cut = c("above", "below")
)
```

## Arguments

- x, y:

  coordinate vectors of points. This can be specified as two vectors `x`
  and `y`, a 2-column matrix `x`, a list `x` with two components, etc,
  see [`xy.coords`](https://rdrr.io/r/grDevices/xy.coords.html).

- num:

  A positive integer; the number of hulls to peel. Pass `Inf` for all
  hulls.

- by:

  A positive integer; with what frequency to include consecutive hulls,
  pairs with `num`.

- breaks:

  A numeric vector of fractions (between `0` and `1`) of the data to
  contain in each hull; overridden by `num`.

- cut:

  Character; one of `"above"` and `"below"`, indicating whether each
  hull should contain at least or at most `breaks` of the data,
  respectively.

## Value

A matrix with some or all of the following columns:

- `x`,`y`:

  original coordinates

- `i`:

  position in input matrix or vectors

- `hull`:

  index of hull, starting from outermost

- `frac`:

  value of `breaks` used to determine hull

- `prop`:

  proportion of data within hull

## Details

Methods for peeling bivariate data into concentric tiers generalize the
univariate concept of rank to separate core versus peripheral cases
(Green, 1981).

The code for peeling convex hulls was adapted from `plothulls()` in the
**[aplpack](https://cran.r-project.org/package=aplpack)** package. Other
peeling options should be implemented soon.

## References

Green PJ (1981) "Peeling Bivariate Data". *Interpreting Multivariate
Data* Chapter 1, 3–19. John Wiley & Sons, Ltd, ISBN 978-0-471-28039-2.

## Examples

``` r
x <- mtcars$disp; y <- mtcars$mpg

# all hulls
peel_hulls(x, y, num = Inf)
#>           x    y  i hull    prop
#>  [1,] 400.0 19.2 25    1 0.71875
#>  [2,] 440.0 14.7 17    1 0.71875
#>  [3,] 472.0 10.4 15    1 0.71875
#>  [4,] 460.0 10.4 16    1 0.71875
#>  [5,] 167.6 17.8 11    1 0.71875
#>  [6,] 121.0 21.4 32    1 0.71875
#>  [7,] 108.0 22.8  3    1 0.71875
#>  [8,]  79.0 27.3 26    1 0.71875
#>  [9,]  71.1 33.9 20    1 0.71875
#> [10,] 360.0 18.7  5    2 0.46875
#> [11,] 360.0 14.3  7    2 0.46875
#> [12,] 350.0 13.3 24    2 0.46875
#> [13,] 275.8 15.2 14    2 0.46875
#> [14,] 145.0 19.7 30    2 0.46875
#> [15,] 120.1 21.5 21    2 0.46875
#> [16,]  75.7 30.4 19    2 0.46875
#> [17,]  78.7 32.4 18    2 0.46875
#> [18,] 258.0 21.4  4    3 0.25000
#> [19,] 351.0 15.8 29    3 0.25000
#> [20,] 301.0 15.0 31    3 0.25000
#> [21,] 167.6 19.2 10    3 0.25000
#> [22,] 140.8 22.8  9    3 0.25000
#> [23,] 120.3 26.0 27    3 0.25000
#> [24,]  95.1 30.4 28    3 0.25000
#> [25,] 318.0 15.5 22    4 0.09375
#> [26,] 304.0 15.2 23    4 0.09375
#> [27,] 225.0 18.1  6    4 0.09375
#> [28,] 160.0 21.0  2    4 0.09375
#> [29,] 146.7 24.4  8    4 0.09375
#> [30,] 275.8 17.3 13    5 0.00000
#> [31,] 275.8 16.4 12    5 0.00000
#> [32,] 160.0 21.0  1    5 0.00000

# every third hull
peel_hulls(x, y, num = Inf, by = 3)
#>           x    y  i hull    prop
#>  [1,] 400.0 19.2 25    1 0.71875
#>  [2,] 440.0 14.7 17    1 0.71875
#>  [3,] 472.0 10.4 15    1 0.71875
#>  [4,] 460.0 10.4 16    1 0.71875
#>  [5,] 167.6 17.8 11    1 0.71875
#>  [6,] 121.0 21.4 32    1 0.71875
#>  [7,] 108.0 22.8  3    1 0.71875
#>  [8,]  79.0 27.3 26    1 0.71875
#>  [9,]  71.1 33.9 20    1 0.71875
#> [10,] 318.0 15.5 22    4 0.09375
#> [11,] 304.0 15.2 23    4 0.09375
#> [12,] 225.0 18.1  6    4 0.09375
#> [13,] 160.0 21.0  2    4 0.09375
#> [14,] 146.7 24.4  8    4 0.09375

# tertile hulls, cut below
peel_hulls(x, y, breaks = seq(0, 1, length.out = 4))
#>           x    y  i hull      frac    prop
#>  [1,] 400.0 19.2 25    1 1.0000000 1.00000
#>  [2,] 440.0 14.7 17    1 1.0000000 1.00000
#>  [3,] 472.0 10.4 15    1 1.0000000 1.00000
#>  [4,] 460.0 10.4 16    1 1.0000000 1.00000
#>  [5,] 167.6 17.8 11    1 1.0000000 1.00000
#>  [6,] 121.0 21.4 32    1 1.0000000 1.00000
#>  [7,] 108.0 22.8  3    1 1.0000000 1.00000
#>  [8,]  79.0 27.3 26    1 1.0000000 1.00000
#>  [9,]  71.1 33.9 20    1 1.0000000 1.00000
#> [10,] 360.0 18.7  5    2 0.6666667 0.71875
#> [11,] 360.0 14.3  7    2 0.6666667 0.71875
#> [12,] 350.0 13.3 24    2 0.6666667 0.71875
#> [13,] 275.8 15.2 14    2 0.6666667 0.71875
#> [14,] 145.0 19.7 30    2 0.6666667 0.71875
#> [15,] 120.1 21.5 21    2 0.6666667 0.71875
#> [16,]  75.7 30.4 19    2 0.6666667 0.71875
#> [17,]  78.7 32.4 18    2 0.6666667 0.71875
#> [18,] 258.0 21.4  4    3 0.3333333 0.46875
#> [19,] 351.0 15.8 29    3 0.3333333 0.46875
#> [20,] 301.0 15.0 31    3 0.3333333 0.46875
#> [21,] 167.6 19.2 10    3 0.3333333 0.46875
#> [22,] 140.8 22.8  9    3 0.3333333 0.46875
#> [23,] 120.3 26.0 27    3 0.3333333 0.46875
#> [24,]  95.1 30.4 28    3 0.3333333 0.46875
#> [25,] 275.8 17.3 13    5 0.0000000 0.09375
#> [26,] 275.8 16.4 12    5 0.0000000 0.09375
#> [27,] 160.0 21.0  1    5 0.0000000 0.09375

# tertile hulls, cut above
peel_hulls(x, y, breaks = seq(0, 1, length.out = 4), cut = "below")
#>           x    y  i hull      frac    prop
#>  [1,] 400.0 19.2 25    1 1.0000000 1.00000
#>  [2,] 440.0 14.7 17    1 1.0000000 1.00000
#>  [3,] 472.0 10.4 15    1 1.0000000 1.00000
#>  [4,] 460.0 10.4 16    1 1.0000000 1.00000
#>  [5,] 167.6 17.8 11    1 1.0000000 1.00000
#>  [6,] 121.0 21.4 32    1 1.0000000 1.00000
#>  [7,] 108.0 22.8  3    1 1.0000000 1.00000
#>  [8,]  79.0 27.3 26    1 1.0000000 1.00000
#>  [9,]  71.1 33.9 20    1 1.0000000 1.00000
#> [10,] 258.0 21.4  4    3 0.6666667 0.46875
#> [11,] 351.0 15.8 29    3 0.6666667 0.46875
#> [12,] 301.0 15.0 31    3 0.6666667 0.46875
#> [13,] 167.6 19.2 10    3 0.6666667 0.46875
#> [14,] 140.8 22.8  9    3 0.6666667 0.46875
#> [15,] 120.3 26.0 27    3 0.6666667 0.46875
#> [16,]  95.1 30.4 28    3 0.6666667 0.46875
#> [17,] 318.0 15.5 10    4 0.3333333 0.25000
#> [18,] 304.0 15.2 12    4 0.3333333 0.25000
#> [19,] 225.0 18.1  4    4 0.3333333 0.25000
#> [20,] 160.0 21.0  2    4 0.3333333 0.25000
#> [21,] 146.7 24.4  6    4 0.3333333 0.25000
```
