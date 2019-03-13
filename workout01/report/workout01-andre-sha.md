workout01-andre-sha
================
Andre Sha
3/11/2019

``` r
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(ggplot2)
library(grid)
library(jpeg)
library(tidyr)
```

``` r
data_types = c("team_name"="character", "game_date"="character", "season" = "integer", "period"="integer",
               "minutes_remaining"="integer", "seconds_remaining"="integer", "shot_made_flag"="character",
               "action_type"="factor", "shot_type"="factor", "shot_distance"="integer", "opponent"="character",
               "x"="integer", "y"="integer")
allplayers <- read.csv('../data/shots-data.csv', stringsAsFactors = FALSE, colClasses = data_types)
```

``` r
andre <- allplayers[allplayers$name=="Andre Iguodala",]
draymond <- allplayers[allplayers$name == "Draymond Green",]
kevin <- allplayers[allplayers$name == "Kevin Durant",]
klay <- allplayers[allplayers$name == "Klay Thompson",]
stephen <- allplayers[allplayers$name == "Stephen Curry",]
```

``` r
twopointers <- allplayers[allplayers$shot_type=="2PT Field Goal", ]
threepointers <- allplayers[allplayers$shot_type=="3PT Field Goal", ]

twopointnames <- group_by(twopointers, name)

total <- length(allplayers$shot_made_flag)

summarise(twopointnames, total)
```

    ## # A tibble: 5 x 2
    ##   name           total
    ##   <chr>          <int>
    ## 1 Andre Iguodala  4334
    ## 2 Draymond Green  4334
    ## 3 Kevin Durant    4334
    ## 4 Klay Thompson   4334
    ## 5 Stephen Curry   4334
