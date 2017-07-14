#A pathetically simple example test
source('tests/testthat.R')
source('example-test.R')

context("simple example function")

test_that("it adds two to an argument" ,{
  expect_equal(add_two(5),7)
})