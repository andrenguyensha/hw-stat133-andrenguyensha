#title Auxillary Mean
#description Computes the E(X) of the given binomial distribution
#param trials numeric, # of trials in given binom
#param prob numeric, probability of success in given binom
#return Mean, or expected value, of binom
#examples
#aux_mean(100, 0.5)
#aux_mean(90, 0.1)
aux_mean <- function(trials, prob) {
  trials * prob
}


#title Auxillary Variance
#description Computes Var(X) of the given binomial distribution
#param trials numeric, # of trials in given binom
#param prob numeric, probability of success in given binom
#return Variance of binomial distribution
#examples
#aux_variance(100, 0.5)
#aux_variance(90, 0.3)
aux_variance <- function(trials, prob) {
  trials * prob * (1 - prob)
}

#title Auxillary Mode
#description Computes mode of the binomial distribution
#param trials numeric, # of trials in given binom
#param prob numeric, probability of success in given binom
#return Mode of binomial distribution
#examples
#aux_mode(100, 0.5)
#aux_mode(90, 0.3)
aux_mode <- function(trials, prob) {
  mode <- trials * prob + prob
  if (typeof(mode) == "double") {
    return(as.integer(mode))
  }
  mode
}

#title Auxillary Skewness
#description Computes skewness of the binomial distribution
#param trials numeric, # of trials in given binom
#param prob numeric, probability of success in given binom
#return Skewness of binomial distribution
#examples
#aux_skewness(100, 0.5)
#aux_skewness(90, 0.3)
aux_skewness <- function(trials, prob) {
  (1 - 2 * prob) / sqrt(trials * prob * (1 - prob))
}

#title Auxillary Kurtosis
#description Computes kurtosis of the binomial distribution
#param trials numeric, # of trials in given binom
#param prob numeric, probability of success in given binom
#return Kurtosis of binomial distribution
#examples
#aux_kurtosis(100, 0.5)
#aux_kurtosis(90, 0.3)
aux_kurtosis <- function(trials, prob) {
  (1 - 6 * prob * (1 - prob)) / (trials * prob * (1 - prob))
}


library(ggplot2)

#' @title Binomial Coefficient
#' @description This function calculates the binomial coefficient of a given binomial distribution
#' @param n Numeric, # of trials in the binomial distribution
#' @param k Numeric, # of successes in the binomial distribution
#' @return Returns binomial coefficient
#' @export
#' @examples
#' bin_choose(n = 3, k = 1)
#' bin_choose(6, 3)
#' bin_choose(5, c(1,2))
bin_choose <- function(n, k) {
  if (sum(k > n) > 0) {
    stop("successes cannot be greater than trials")
  }
  factorial(n) / (factorial(k) * factorial(n - k))
}

#' @title Binomial Probability
#' @description Calculates probability of the successes in the trials of a given binomial distribution
#' @param n Numeric, # of trials in the binomial distribution
#' @param k Numeric, # of successes in the binomial distribution
#' @param prob Numeric, Probability of success in the binomial distribution
#' @return Returns Binomial Probability
#' @export
#' @examples
#' bin_probability(success = 3, trials = 5, prob = 0.5)
#' bin_probability(success = 0.4, trials = 3, prob = 0.5)
#' bin_probability(success = 2, trials = 100, prob = 0.45)
bin_probability <- function(success, trials, prob) {
  check_trials(trials)
  check_prob(prob)
  check_success(success, trials)
  bin_choose(trials, success) * prob ^ success * (1 - prob) ^ (trials - success)
}

#' @title Binomial Distribution
#' @description Calculates a binomial distribution table
#' @param trials Numeric, # of trials in the given binomial distribution
#' @param prob Numeric, probability of success in the given binomial distribution
#' @return Returns a data.frame of the given binomial distribution
#' @export
#' @examples
#' bin_distribution(trials = 10, prob = 0.5)
bin_distribution <- function(trials, prob) {
  successes <- 0:trials
  probabilities <- bin_probability(successes, trials, prob)
  bin_dist <- data.frame(success = successes,
                         probability = probabilities)
  class(bin_dist) <- c("bindis", "data.frame")
  bin_dist
}

#' @export
plot.bindis <- function(x) {
  ggplot(data = x, aes(x = success, y = probability)) +
    geom_col()
}

#' @title Binomial Cumulative Distribution
#' @description computes and tabulates the cumulative density for given
#' binomial distribution
#' @param trials Numeric, # of trials in the given binomial distribution
#' @param prob Numeric, probability of success in the given binomial distribution
#' @return Returns a data frame of two classes (bincum and data.frame) containing the columns
#' success, probability, cumulative.
#' @export
#' @examples
#' bin_cumulative(trials = 2, prob = .5)
bin_cumulative <- function(trials, prob) {
  successes <- 0:trials
  probabilities <- bin_probability(successes, trials, prob)
  cum_prob <- cumsum(probabilities)
  bin_dist <- data.frame(success = successes,
                         probability = probabilities,
                         cumulative = cum_prob)
  class(bin_dist) <- c("bincum", "data.frame")
  bin_dist
}



#' @export
plot.bincum <- function(x) {
  ggplot(data = x, aes(x = success, y = cumulative)) +
    geom_line() +
    xlab("# of Successes") +
    ylab("Cumulative Probability") + theme_classic()
}

#' @title Binomial Variable
#' @description Function that returns a list of named elements trials and prob
#' trials and probability.
#' @param trials Numeric, # of trials
#' @param prob Numeric, probability from 0 to 1 inclusive
#' @return a list containing the two parameters of the binomial RV
#' @export
#' @examples
#' bin_variable(10, .5)
#' bin_variable(100, .25)
bin_variable <- function(trials = 10, prob = .4){
  check_trials(trials)
  check_prob(prob)
  x <- c(trials = trials, probability = prob)
  class(x) <- c("binvar")
  return(x)
}

#'@export
print.binvar <- function(x){
  cat('"Binomial Variable"\n\n')
  cat('Parameters\n\n')
  cat(sprintf('number of trials: %s', x[1]), "\n")
  cat(sprintf('prob of success: %s', x[2]), "\n")
}

#'@export
summary.binvar <- function(x) {
  trials <- x[1]
  prob <- x[2]
  summary_binvar <- list(trials = trials,
                         prob = prob,
                         mean = aux_mean(trials, prob),
                         variance = aux_variance(trials, prob),
                         mode = aux_mode(trials, prob),
                         skewness = aux_skewness(trials, prob),
                         kurtosis = aux_kurtosis(trials, prob))
  class(summary_binvar) <- "summary.binvar"
  summary_binvar
}

#'@export
print.summary.binvar <- function(x){
  cat("'Summary Binomial'\n\n")
  cat("Parameters:\n")
  cat("- number of trials      :", x$trials, "\n")
  cat("- probability of success:", x$prob, "\n\n")
  cat("Measures:\n")
  cat("- mean    :", x$mean, "\n")
  cat("- variance:", x$variance, "\n")
  cat("- mode(s) :", x$mode, "\n")
  cat("- skewness:", x$skewness, "\n")
  cat("- kurtosis:", x$kurtosis, "\n")
}


#' @title Binomial Mean
#' @description Computes E(X) of given binomial distribution
#' @param trials Numeric, # of trials in the given binomial distribution
#' @param prob Numeric, probability of success in the given binomial distribution
#' @return Expected value of binomial distribution
#' @export
#' @examples
#' bin_mean(trials = 10, prob = 0.5)
bin_mean <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  aux_mean(trials, prob)
}

#' @title Binomial Variance
#' @description Computes the variance of the binomial distribution
#' @param trials Numeric, # of trials in the given binomial distribution
#' @param prob Numeric, probability of success in the given binomial distribution
#' @return Variance of binomial distribution
#' @export
#' @examples
#' bin_variance(trials = 10, prob = 0.5)
bin_variance <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  aux_variance(trials, prob)
}

#' @title Binomial Mode
#' @description Computes the mode of the binomial distribution
#' @param trials Numeric, # of trials in the given binomial distribution
#' @param prob Numeric, probability of success in the given binomial distribution
#' @return Mode of binomial distribution
#' @export
#' @examples
#' bin_mode(trials = 10, prob = 0.5)
bin_mode <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  aux_mode(trials, prob)
}

#' @title Binomial Skewness
#' @description Computes the skewness of the binomial distribution
#' @param trials Numeric, # of trials in the given binomial distribution
#' @param prob Numeric, probability of success in the given binomial distribution
#' @return Skewness of binomial distribution
#' @export
#' @examples
#' bin_skewness(trials = 10, prob = 0.5)
bin_skewness <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  aux_skewness(trials, prob)
}

#' @title Binomial Kurtosis
#' @description Computes the kurtosis of the binomial distribution
#' @param trials Numeric, # of trials in the given binomial distribution
#' @param prob Numeric, probability of success in the given binomial distribution
#' @return Kurtosis of binomial distribution
#' @export
#' @examples
#' bin_kurtosis(trials = 10, prob = 0.5)
bin_kurtosis <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  aux_kurtosis(trials, prob)
}

#title Probability Checker
#description This function checks whether or not the input prob is valid
#param prob numeric probability
#return Returns TRUE if probability is valid, stop executed else.
#examples
#check_prob(0)
#check_prob(0.5)
#check_prob(1)
check_prob <- function(prob) {
  if (prob < 0 || prob > 1) {
    stop('prob has to be a number between 0 and 1')
  }
  return(TRUE)
}


#title Trial Checker
#description Checks whether or not input trials is valid
#param trials Number that we check whether is valid (numeric)
#return Returns a logical vector of whether trials is valid
#examples
#check_trials(0)
#check_trials(1.5)
#check_trials(50)
check_trials <- function(trials = 1){
  if (length(trials) != 1){
    stop("trials must have length 1")
  }else if(trials != as.integer(trials)){
    stop("trials must be an integer")
  }else if(trials <= 0){
    stop("trials must be a positive number")
  }
  return(TRUE)
}


#title Success Checker
#description Checks whether or not input success is valid
#param success Numeric, successes in trials
#param trials Numeric, # of trials
#return Returns a logical of whether or not success is valid
#examples
#check_success(0, 0)
#check_success(0, 10)
#check_success(2, 1)
#check_success(2.3, 5)
#check_success(2, 5.3)
check_success <- function(success, trials) {
  successes <- (success < 0 || success > trials)
  if (sum(successes) > 0) {
    stop("Invalid success value")
  }else if(trials != as.integer(trials)){
    stop("trials must be an integer")
  }else if(success != as.integer(success)){
    stop("success must be an integer")
  }
  return(TRUE)
}




