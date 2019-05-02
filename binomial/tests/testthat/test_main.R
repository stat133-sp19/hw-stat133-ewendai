
context('test main functions')

test_that("bin_choose works", {
  expect_equal(bin_choose(n = 5, k = 2), choose(5, 2))
  expect_equal(bin_choose(5, 0), choose(5, 0))
  expect_equal(bin_choose(5, 1:3), choose(5, 1:3))
})

test_that("bin_probability works", {
  expect_equal(bin_probability(success = 2, trials = 5, prob = 0.5), 0.3125)
  expect_equal(length(bin_probability(success = 0:2, trials = 5, prob = 0.5)), 3)
  expect_equal(bin_probability(success = 55, trials = 100, prob = 0.45), 0.01075277)
})

test_that("bin_distribution works", {
  expect_length(bin_distribution(trials = 5, prob = 0.5), 2)
  expect_equal(class(bin_distribution(10, 0.5)), c("bindis", "data.frame"))
  expect_equal(bin_distribution(trials = 5, prob = 0.5)[[2]][6], 0.03125)
})

test_that("bin_cumulative works", {
  expect_length(bin_cumulative(trials = 5, prob = 0.5), 3)
  expect_equal(class(bin_cumulative(trials = 5, prob = 0.5)), c("bincum", "data.frame"))
  expect_equal(bin_cumulative(trials = 5, prob = 0.5)[[3]][1], 0.03125)
})
