
-   [Hypothesis tests](#hypothesis-tests)
-   [Confidence intervals](#confidence-intervals)

Infer: an R package for tidyverse-friendly statistical inference.

------------------------------------------------------------------------

[![Travis-CI Build Status](https://travis-ci.org/andrewpbray/infer.svg?branch=master)](https://travis-ci.org/andrewpbray/infer)

The objective of this package is to perform inference using an expressive statistical grammar that coheres with the `tidyverse` design framework.

### Hypothesis tests

![h-test diagram](figs/ht-diagram.png)

#### Examples

These examples assume that `mtcars` has been overwritten so that the variables `cyl`, `vs`, `am`, `gear`, and `carb` are `factor`s.

    mtcars <- as.data.frame(mtcars) %>%
      mutate(cyl = factor(cyl),
             vs = factor(vs),
             am = factor(am),
             gear = factor(gear),
             carb = factor(carb))

------------------------------------------------------------------------

One numerical variable (mean)

    mtcars %>%
      specify(response = mpg) %>% # alt: mpg ~ NULL (or mpg ~ 1)
      hypothesize(null = "point", mu = 25) %>% 
      generate(reps = 100, type = "bootstrap") %>% 
      calculate(stat = "mean")

One numerical variable (median)

    mtcars %>%
      specify(response = mpg) %>% # alt: mpg ~ NULL (or mpg ~ 1)
      hypothesize(null = "point", med = 26) %>% 
      generate(reps = 100, type = "bootstrap") %>% 
      calculate(stat = "median")

One numerical variable (standard deviation)

    mtcars %>%
      specify(response = mpg) %>% # alt: mpg ~ NULL (or mpg ~ 1)
      hypothesize(null = "point", sigma = 5) %>% 
      generate(reps = 100, type = "bootstrap") %>% 
      calculate(stat = "sd")

One categorical (2 level) variable

    mtcars %>%
      specify(response = am) %>% # alt: am ~ NULL (or am ~ 1)
      hypothesize(null = "point", p = c("1" = .25)) %>% 
      generate(reps = 100, type = "simulate") %>% 
      calculate(stat = "prop")

Two categorical (2 level) variables

    mtcars %>%
      specify(am ~ vs) %>% # alt: response = am, explanatory = vs
      hypothesize(null = "independence") %>%
      generate(reps = 100, type = "permute") %>%
      calculate(stat = "diff in props")

One categorical (&gt;2 level) - GoF

    mtcars %>%
      specify(cyl ~ NULL) %>% # alt: response = cyl
      hypothesize(null = "point", p = c("4" = .5, "6" = .25, "8" = .25)) %>%
      generate(reps = 100, type = "simulate") %>%
      calculate(stat = "Chisq")

Two categorical (&gt;2 level) variables

    mtcars %>%
      specify(cyl ~ am) %>% # alt: response = cyl, explanatory = am
      hypothesize(null = "independence") %>%
      generate(reps = 100, type = "permute") %>%
      calculate(stat = "Chisq")

One numerical variable one categorical (2 levels) (diff in means)

    mtcars %>%
      specify(mpg ~ am) %>% # alt: response = mpg, explanatory = am
      hypothesize(null = "independence") %>%
      generate(reps = 100, type = "permute") %>%
      calculate(stat = "diff in means")

One numerical variable one categorical (2 levels) (diff in medians)

    mtcars %>%
      specify(mpg ~ am) %>% # alt: response = mpg, explanatory = am
      hypothesize(null = "independence") %>%
      generate(reps = 100, type = "permute") %>%
      calculate(stat = "diff in medians")

One numerical one categorical (&gt;2 levels) - ANOVA

    mtcars %>%
      specify(mpg ~ cyl) %>% # alt: response = mpg, explanatory = cyl
      hypothesize(null = "independence") %>%
      generate(reps = 100, type = "permute") %>%
      calculate(stat = "F")

Two numerical vars - SLR

    mtcars %>%
      specify(mpg ~ hp) %>% # alt: response = mpg, explanatory = cyl
      hypothesize(null = "independence") %>%
      generate(reps = 100, type = "permute") %>%
      calculate(stat = "slope")

### Confidence intervals

One numerical (one mean)

    mtcars %>%
      specify(response = mpg) %>%
      generate(reps = 100, type = "bootstrap") %>%
      calculate(stat = "mean")

One numerical (one median)

    mtcars %>%
      specify(response = mpg) %>%
      generate(reps = 100, type = "bootstrap") %>%
      calculate(stat = "median")

One numerical (standard deviation)

    mtcars %>%
      specify(response = mpg) %>%
      generate(reps = 100, type = "bootstrap") %>%
      calculate(stat = "sd")

One categorical (one proportion)

    mtcars %>%
      specify(response = am) %>%
      generate(reps = 100, type = "bootstrap") %>%
      calculate(stat = "prop", success = "1")

One numerical variable one categorical (2 levels) (diff in means)

    mtcars %>%
      specify(mpg ~ am) %>%
      generate(reps = 100, type = "bootstrap") %>%
      calculate(stat = "diff in means")

Two categorical variables (diff in proportions)

    mtcars %>%
      specify(am ~ vs) %>%
      generate(reps = 100, type = "bootstrap") %>%
      calculate(stat = "diff in props")

Two numerical vars - SLR

    mtcars %>%
      specify(mpg ~ hp) %>% 
      generate(reps = 100, type = "bootstrap") %>%
      calculate(stat = "slope")
