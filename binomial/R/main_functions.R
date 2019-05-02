
#' @title Choose
#' @description computes C(n, k)
#' @param n number of trials
#' @param k number of successes
#' @return C(n, k)
#' @export
#' @examples bin_choose(n = 5, k = 2)
#' @examples bin_choose(5, 0)
#' @examples bin_choose(5, 1:3)
bin_choose = function(n, k) {
  if (k > n) {
    stop('k cannot be greater than n')
  }
  return (factorial(n) / (factorial(k) * factorial(n-k)))
}

#' @title Probability
#' @description computes the probability of k successes in n trials
#' @param success number of successes
#' @param trials number of trials
#' @param prob probability of success
#' @return probability of k successes in n trials
#' @export
#' @examples bin_probability(success = 2, trials = 5, prob = 0.5)
#' @examples bin_probability(success = 0:2, trials = 5, prob = 0.5)
#' @examples bin_probability(success = 55, trials = 100, prob = 0.45)
bin_probability = function(success, trials, prob) {
  valid = check_trials(trials)
  if (!(valid == T)) {
    stop('invalid trials value')
  }

  valid = check_prob(prob)
  if (!(valid == T)) {
    stop('invalid probability value')
  }

  s = c()
  for (i in success) {
    valid = check_success(i, trials)
    if (!(valid == T)) {
      stop('invalid success value')
    }
    s = c(s,(bin_choose(trials, i)*((prob)^i)*((1-prob)^(trials - i))))
  }

  return (s)
}

#' @title Distribution
#' @description computes the probability distribution of binomial(trials, prob)
#' @param trials number of trials
#' @param prob probability of success
#' @return probability distribution of binomial(trials, prob) in a dataframe
#' @export
#' @examples bin_distribution(trials = 5, prob = 0.5)
bin_distribution = function(trials, prob) {
  successes = 0:trials
  probs = c()
  for(i in successes) {
    p = bin_probability(i, trials, prob)
    probs = c(probs, p)
  }
  distribution = data.frame('success' = successes, 'probability' = probs)
  class(distribution) = c('bindis', 'data.frame')
  return(distribution)
}

#' @export
plot.bindis = function(bin_distribution) {
  return (barplot(bin_distribution$probability, xlab = 'successes', ylab = 'probability'))
}

#' @title Cumulative Distribution
#' @description computes the cumulative distribution of binomial(trials, prob)
#' @param trials number of trials
#' @param prob probability of success
#' @return cumulative distribution of binomial(trials, prob) in a dataframe
#' @export
#' @examples bin_cumulative(trials = 5, prob = 0.5)
bin_cumulative = function(trials, prob) {
  successes = 0:trials
  probs = c()
  cumulatives = c()

  for (i in successes) {
    p <- bin_probability(i, trials, prob)
    cumulatives = c(cumulatives, sum(probs, p))
    probs = c(probs, p)
  }

  cumu = data.frame(success = successes, probability = probs, cumulative = cumulatives)
  class(cumu) = c('bincum', 'data.frame')
  return(cumu)
}

#' @export
plot.bincum = function(bin_cumulative){
  return (plot(bin_cumulative$cumulative, xlab = 'successes', ylab = 'probability', type = 'b'))
}

#' @title Variable
#' @description make a binomial random variable
#' @param trials number of trials
#' @param prob probability of success
#' @return binomial random variable
#' @export
#' @examples bin_variable(trials = 10, prob = 0.3)
bin_variable = function(trials, prob) {
  valid = check_trials(trials)
  if (!(valid == T)) {
    stop('invalid trials value')
  }

  valid = check_prob(prob)
  if (!(valid == T)) {
    stop('invalid probability value')
  }

  var = c(trials, prob)
  class(var) = 'binvar'
  return (var)
}

#' @export
print.binvar = function(bin_variable) {
  cat('Binomial Variable"\n\n')
  cat('Parameters"\n\n')
  cat(sprintf('number of trials: %s', bin_variable[1]), "\n")
  cat(sprintf('prob of success: %s', bin_variable[2]), "\n")
}

#' @export
summary.binvar = function(bin_variable) {
  trials = bin_variable[1]
  prob = bin_variable[2]
  mean = aux_mean(trials, prob)
  variance = aux_variance(trials, prob)
  mode = aux_mean(trials, prob)
  skewness = aux_skewness(trials, prob)
  kurtosis = aux_kurtosis(trials, prob)
  summary = c(trials, prob, mean, variance, mode, skewness, kurtosis)
  names(summary) = c('trials', 'prob', 'mean', 'variance', 'mode', 'skewness', 'kurtosis')
  class(summary) = 'summary.binvar'
  return(summary)
}

#' @export
print.summary.binvar = function(bin_variable) {
  s = summary.binvar(bin_variable)
  cat('Summary Binomial"\n\n')
  cat('Parameters"\n\n')
  cat(sprintf('number of trials: %s', bin_variable[1]), "\n")
  cat(sprintf('prob of success: %s', bin_variable[2]), "\n")
  cat('\n')
  cat('Measures"\n\n')
  cat(sprintf('mean: %s', s['mean']), "\n")
  cat(sprintf('variance: %s', s['variance']), "\n")
  cat(sprintf('mode: %s', s['mode']), "\n")
  cat(sprintf('skewness: %s', s['skewness']), "\n")
  cat(sprintf('kurtosis: %s', s['kurtosis']), "\n")
}

#' @title Mean
#' @description calculates the mean of binomial(trials, prob)
#' @param trials number of trials
#' @param prob probability of success
#' @return mean of binomial(trials, prob)
#' @export
#' @examples: bin_mean(trials = 10, prob = 0.3)
bin_mean = function(trials, prob) {
  valid = check_trials(trials)
  valid = check_prob(prob)
  return (aux_mean(trials, prob))
}

#' @title Variance
#' @description calculates the variance of binomial(trials, prob)
#' @param trials number of trials
#' @param prob probability of success
#' @return variance of binomial(trials, prob)
#' @export
#' @examples: bin_variance(trials = 10, prob = 0.3)
bin_variance = function(trials, prob) {
  valid = check_trials(trials)
  valid = check_prob(prob)
  return (aux_variance(trials, prob))
}

#' @title Mode
#' @description calculates the mode of binomial(trials, prob)
#' @param trials number of trials
#' @param prob probability of success
#' @return mode of binomial(trials, prob)
#' @export
#' @examples: bin_mode(trials = 10, prob = 0.3)
bin_mode = function(trials, prob) {
  valid = check_trials(trials)
  valid = check_prob(prob)
  return (aux_mode(trials, prob))
}

#' @title Skewness
#' @description calculates the skewness of binomial(trials, prob)
#' @param trials number of trials
#' @param prob probability of success
#' @return skewness of binomial(trials, prob)
#' @export
#' @examples bin_skewness(trials = 10, prob = 0.3)
bin_skewness = function(trials, prob) {
  valid = check_trials(trials)
  valid = check_prob(prob)
  return (aux_skewness(trials, prob))
}

#' @title Kurtosis
#' @description calculates the kurtosis of binomial(trials, prob)
#' @param trials number of trials
#' @param prob probability of success
#' @return the kurtosis of binomial(trials, prob)
#' @export
#' @examples bin_kurtosis(trials = 10, prob = 0.3)
bin_kurtosis = function(trials, prob) {
  valid = check_trials(trials)
  valid = check_prob(prob)
  return (aux_kurtosis(trials, prob))
}
