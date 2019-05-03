
---
output:
  github_document:
    html_preview: true
---

```{r, echo=FALSE}
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.path = "README-"
)
```

##The Binomial Package

The binomial distribution is one of the most well known distributions in statistics. This package includes functions that are intended to make the calculations for the binomial distribution easier and the outputs clearer.

- `bin_distribution()` will result in a data frame of class `bindis`, with success in one column and probability of said success in the other.
- `bin_cumulative()` will result in a data frame of class `bincum`, with success in one column, probability of success in the second, and cumulative probability in the third.
- `bin_variable()` will return an object of class `binvar`. 
- There are separate `plot()` methods for objects of classes `bindis` and `bincum`. 
- There are specific `print()` methods for objects of classes `binvar` and `summary.binvar`.
- There is a specific `summary()` method for objects of class `binvar`.
Additional documentation and examples can be found in the "vignettes" folder.

##Motivation

The point of this package is to explore the possibilities available when creating a package in R. It exposes the individual to all the behind-the-scenes aspects such as testing, auxiliary functions, and private functions.

## Installation

To install the package, one must use the  `"devtools"` package:

```{r, eval=FALSE}
# development version from GitHub:
install.packages("devtools") 
# install "binomial" (without vignettes)
devtools::install_github("stat133-sp19/hw-stat133-vincenttcle/tree/master/workout03/binomial")
# install "cointoss" (with vignettes)
devtools::install_github("stat133-sp19/hw-stat133-vincenttcle/tree/master/workout03/binomial", build_vignettes = TRUE)
```

##Examples of the binomial package in use

```{r}
library(binomial)
#Finding the probability of 6 heads in 10 flips of a fair coin
bin_probability(success = 6, trials = 10, prob = 0.5)
#Finding the probability of 6 heads in 10 flips of a coin that falls on heads 20% of the time
bin_probability(success = 6, trials = 10, prob = 0.2)
#Looking at the entire binomial distribution of 10 flips of a fair coin
bin_distribution(trials = 10, prob = 0.2)
#Plotting the distribution
bindis_plot <- bin_distribution(trials =  10, prob = 0.5)
plot(bindis_plot)
#Looking at the cumulative probability distribution
bin_cumulative(trials = 10, prob = 0.5)
#Binomial random variable
bin_variable(trials = 10, prob = 0.5)
#summary of the binomial random variable
bin_summary <- bin_variable(trials = 10, prob = 0.5)
summary(bin_summary)
```
