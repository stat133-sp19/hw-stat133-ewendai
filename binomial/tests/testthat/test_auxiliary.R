
context('test auxiliary functions')

test_that("aux_mean works", {
  expect_equal(aux_mean(5, 0.5), 2.5)
  expect_equal(aux_mean(0, 0.1), 0)
  expect_equal(aux_mean(8, 0.5), 4)
})

test_that("aux_variance works", {
  expect_equal(aux_variance(5, 0.5), 1.25)
  expect_equal(aux_variance(0, 0.1), 0)
  expect_equal(aux_variance(8, 0.5), 2)
})

test_that("aux_mode works", {
  expect_equal(aux_mode(10, 0.3), 3)
  expect_length(aux_mode(10, 0.3), 1)
  expect_type(aux_mode(10, 0.3), 'double')
})

test_that("aux_skewness works", {
  expect_equal(round(aux_skewness(10, 0.3), 7), 0.2760262)
  expect_length(aux_skewness(10, 0.3), 1)
  expect_type(aux_skewness(10, 0.3), 'double')
})

test_that("aux_kurtosis works", {
  expect_equal(round(aux_kurtosis(10, 0.3), 7), -0.1238095)
  expect_length(aux_kurtosis(10, 0.3), 1)
  expect_type(aux_kurtosis(10, 0.3), 'double')
})
