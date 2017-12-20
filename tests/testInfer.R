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
  expect_error(specify(blah ~ cyl))
  expect_error(specify(mtcars_f,blah2~cyl))
  
  
})

source("R/hypothesize.R")
test_that("hypothesize arguments",{
  
  mtcars_f <- mutate(mtcars, cyl=factor(cyl))
  mtcars_s <- mtcars_f %>% specify(response=mpg)
  blah <- matrix(data=NA, nrow=3, ncol=3)
  
  expect_error(hypothesize(mtcars_s, null=NA))
  expect_warning(hypothesize(mtcars_s))

})


source("R/generate.R")

test_that("generate arguments", {
  
  expect_silent(generate(mtcars, reps=1, type="bootstrap"))
  
})