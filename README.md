Tidy Pairwise Operations (User! 2022, regular talk)
================

<!-- README.md is generated from README.Rmd. Please edit that file -->

Repo contains .pdf of slides for UseR! 2022 regular talk on “Tidy
Pairwise Operations.” The .pptx of the slides (including a rough script
in the notes) can be found
[here](https://docs.google.com/presentation/d/12Oo6rA_eFqyqRWFBDaJvc78T8K4ireBP/edit?usp=sharing&ouid=104437923524095184714&rtpof=true&sd=true).

The talk was largely a means of pointing out some cool functions in
[corrr](https://github.com/tidymodels/corrr) and
[recipes](https://github.com/tidymodels/recipes) that facilitate
pairwise operations and to advocate for using
[dplyover](https://github.com/TimTeaFan/dplyover) for a more general
solution that uses `dplyr::across()` style syntax (and provides
functionality outside of simply pairwise operations).

I also have an old blog post on [Tidy Pairwise
Operations](https://www.bryanshalloway.com/2020/06/03/tidy-2-way-column-combinations/)
and co-wrote a (not maintained) package
[pwiser](https://github.com/brshallo/pwiser/) for doing pairwise
operations. These approaches contain notes and documentation linking to
various other resources and examples on the topic.

# Abstract

(Note actual talk was amended to only include examples of approaches
from `{corrr}`, `{recipes}` and `{dplyover}`.)

The dplyr `\*_at;\*_if;\*_all` variants of mutate() & summarise() and
(in the last couple years) dplyr::across(), have made iterating across
operations on many columns easier to do in the tidyverse. These
functions though still don’t facilitate operations across complex
combinations of columns, e.g. operations across all pairs of a specified
set of columns.

In this talk I’ll walk through examples of five different
tidyverse-friendly packages / approaches that can be used for doing
pairwise operations. Some of these can be used for pairwise “mutating”
operations, others for “summarising”, some for either:

-   A mutating pairwise operation generally returns the same number of
    rows as was input. For example calculate ratios of all possible
    pairs of inputted columns.
-   A summarising operation generally returns a single row (for each
    group). For example compare the distributions between columns by
    calculating the K-S statistic between all pairs of columns.

I will then walk through examples using each of {widyr}, {corrr},
{recipes}, {pwiser}, and {dplyover} for doing pairwise mutating /
summarising operations and the functionality enabled by each package
across dimensions of “community support”, “handles mutating?”, “handles
summarising?”, “handles arbitrary operations?”. I will spend the most
time on pwiser and especially dplyover which offer the most flexibility
here and feature a dplyr::across() style syntax.
