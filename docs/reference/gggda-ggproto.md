# ggproto classes created and adapted for gggda

**gggda** introduces several
[ggproto](https://ggplot2.tidyverse.org/reference/ggproto.html) classes
for coordinate systems, statistical transformations, and geometric
constructions specific to multivariate analysis or following geometric
data analysis principles.

## Details

The new ggprotos are inspired by two entangled but distinct threads in
multivariate data visualization: First, several geometric constructions
have been proposed to generalize both numeric and graphical summaries of
univariate data to the bivariate setting. Among these are various
"peeling" procedures like that by successive convex hulls, which
generalize the concept of rank (Green, 1981); and the depth-based
bag-and-bolster plot, designed as a bivariate analog of the
box-and-whisker plot (Rousseeuw &al, 1999). Second, the use of biplots
to visualize singular value–decomposed data benefits from being able to
encode variables with different graphical elements than the markers used
to encode cases—for example, vectors (arrows emanating from the origin;
Gabriel, 1971), calibrated axes (Gower & Hand, 1996), and prediction
regions (Gardner & le Roux, 2002).

## References

Green PJ (1981) "Peeling Bivariate Data". *Interpreting Multivariate
Data* Chapter 1, 3–19. John Wiley & Sons, Ltd, ISBN 978-0-471-28039-2.

Rousseeuw PJ, Ruts I, & Tukey JW (1999) "The Bagplot: A Bivariate
Boxplot". *The American Statistician*, **53**(4): 382–387.
[doi:10.1080/00031305.1999.10474494](https://doi.org/10.1080/00031305.1999.10474494)

Gabriel KR (1971) "The biplot graphic display of matrices with
application to principal component analysis". *Biometrika* 58(3),
453–467.
[doi:10.1093/biomet/58.3.453](https://doi.org/10.1093/biomet/58.3.453)

Gower JC & Hand DJ (1996) *Biplots*. Chapman & Hall, ISBN:
0-412-71630-5.

Gardner S, le Roux N (2002) "Biplot Methodology for Discriminant
Analysis Based upon Robust Methods and Principal Curves".
*Classification, Clustering, and Data Analysis: Recent Advances and
Applications*: 169–176.
<https://link.springer.com/chapter/10.1007/978-3-642-56181-8_18>

## See also

[`ggplot2::ggplot2-ggproto`](https://ggplot2.tidyverse.org/reference/ggplot2-ggproto.html)
and
[ggplot2::ggproto](https://ggplot2.tidyverse.org/reference/ggproto.html)
for explanations of base ggproto classes in **ggplot2** and how to
create new ones.
