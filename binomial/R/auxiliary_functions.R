
# name: Mean
# description: computes the mean
# param: trials - number of trials
# param: prob - a probability
# return: the mean
aux_mean = function(trials, prob) {
  return (trials * prob)
}

# name: Variance
# description: computes the variance
# param: trials - number of trials
# param: prob - a probability
# return: the variance
aux_variance = function(trials, prob) {
  return (trials * prob * (1 - prob))
}

# name: Mode
# description: computes the mode
# param: trials - number of trials
# param: prob - a probability
# return: the mode
aux_mode = function(trials, prob) {
  value = trials * prob + prob
  if (value %% 1 == 0) {
    return (c(value, value + 1))
  } else {
    return (floor(trials * prob + prob))
  }
}

# name: Skewness
# description: computes the skewness
# param: trials - number of trials
# param: prob - a probability
# return: the skewness
aux_skewness = function(trials, prob) {
  return ((1 - 2*prob) / (trials * prob * (1-prob))^0.5)
}

# name: Kurtosis
# description: computes the kurtosis
# param: trials - number of trials
# param: prob - a probability
# return: the kurtosis
aux_kurtosis = function(trials, prob) {
  return ((1 - 6 * prob * (1 - prob)) / (trials * prob * (1 - prob)))
}
