
context('test checker functions')

test_that("check_prob correct", {
  expect_true(check_prob(0))
  expect_true(check_prob(0.5))
  expect_true(check_prob(1))
  expect_length(check_prob(0.75), 1)
  expect_error(check_prob(-0.1), 'invalid prob value')
  expect_error(check_prob(1.1), 'invalid prob value')
})

test_that("check_trials correct", {
  expect_true(check_trials(0))
  expect_true(check_trials(5))
  expect_error(check_trials(-1), 'invalid trials value')
  expect_error(check_trials(0.5), 'invalid trials value')
})

test_that("check_success correct", {
  expect_true(check_success(1, 5))
  expect_true(check_success(0:2, 7))
  expect_error(check_success(8, 7), "success cannot be greater than trials")
  expect_error(check_success(-5, 7), 'invalid success value')
})
