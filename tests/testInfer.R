library(testthat)
library(tidyverse)
library(rlang)

data(mtcars)
source("R/specify.R")

test_that("specify arguments", {
  
  expect_error(specify(mtcars, response=blah))
  expect_equal(ncol(specify(mtcars, formula = mpg ~ wt)), 2)
  expect_error(specify(mtcars, formula = mpg ~ blah))
  expect_equal(class(specify(mtcars, formula = mpg ~ wt))[1], "infer")
  
  
})

source("R/generate.R")

test_that("generate arguments", {
  
  
})