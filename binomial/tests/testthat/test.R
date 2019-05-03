library(testthat)

source("../../R/functions.R")

context("Testing for auxiliary functions")


#aux_mean
test_that("aux_mean as expected", {

  expect_equal(aux_mean(10, 0.4),4)
  expect_type(aux_mean(10, 0.4),"double")
  expect_length(aux_mean(10, 0.4),1)
})

#aux_variance
test_that("aux_variance as expected", {

  expect_equal(aux_variance(10, 0.4),2.4)
  expect_type(aux_variance(10, 0.4),"double")
  expect_length(aux_variance(10, 0.4),1)
})

#aux_mode
test_that("aux_mode as expected", {

  expect_equal(aux_mode(10, 0.4),4)
  expect_type(aux_mode(10, 0.4),"integer")
  expect_length(aux_mode(10, 0.4),1)
})

#aux_skewness
test_that("aux_skewness as expected", {

  expect_equal(aux_skewness(10, 0.5), 0)
  expect_type(aux_skewness(10, 0.5),"double")
  expect_length(aux_skewness(10, 0.5),1)
})

#aux_kurtosis
test_that("aux_kurtosis as expected", {

  expect_equal(aux_kurtosis(10, 0.5),-0.2)
  expect_type(aux_kurtosis(10, 0.3),"double")
  expect_length(aux_kurtosis(10, 0.3),1)
})

context("Testing for checker functions")

#check_prob
test_that("check_prob as expected", {
  expect_true(check_prob(.5))
  expect_type(check_prob(.5),"logical")
  expect_length(check_prob(.5),1)
})

#check_trials
test_that("check_trials as expected", {
  expect_true(check_trials(4))
  expect_type(check_trials(40),"logical")
  expect_length(check_trials(32),1)
})

#check_success
test_that("check_success as expected", {

  expect_true(check_success(3,5))
  expect_type(check_success(200,1000),"logical")
  expect_length(check_success(32,50),1)
})

context("Testing for binomial functions")

#bin_choose
test_that("bin_choose as expected", {

  expect_equal(bin_choose(n = 5, k = 2),10)
  expect_type(bin_choose(n = 5, k = 2),"double")
  expect_length(bin_choose(n = 5, k = 2),1)
})

#bin_probability
test_that("bin_probability as expected", {

  expect_equal(bin_probability(success = 2, trials = 5, prob = 0.5),0.3125)
  expect_type(bin_probability(success = 2, trials = 5, prob = 0.5),"double")
  expect_length(bin_probability(success = 2, trials = 5, prob = 0.5),1)
})

#bin_distribution
test_that("bin_distribution as expected", {

  expect_is(bin_distribution(trials = 5, prob = 0.5),c("bindis","data.frame"))
  expect_type(bin_distribution(trials = 5, prob = 0.5),"list")
  expect_length(bin_distribution(trials = 5, prob = 0.5),2)
})


#bin_cumulative
test_that("bin_cumulative as expected", {

  expect_is(bin_cumulative(trials = 5, prob = 0.5),c("bincum","data.frame"))
  expect_type(bin_cumulative(trials = 5, prob = 0.5),"list")
  expect_length(bin_cumulative(trials = 5, prob = 0.5),3)
})
