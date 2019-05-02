
# name: Check Prob
# description: Check if an input prob is a valid probability value
# param: prob - given probability
# return: True if prob is valid. Else error.
check_prob = function(prob) {
  valid = FALSE
  if(prob <= 1 & prob >= 0){
    valid = TRUE
  } else {
    stop('invalid prob value')
  }
  return(valid)
}

# name: Check Trials
# description: test if an input trials is a valid value for number of trials
# param: trials - number of trials
# return: True if trials is valid. Else error.
check_trials = function(trials) {
  valid = FALSE
  if(trials >= 0 & trials%%1 == 0){
    valid = TRUE
  } else {
    stop('invalid trials value')
  }
  return(valid)
}


# name: Check Success
# description:  test if an input success is a valid value for number of successes
# param: success - number of successes
# param: trials - number of trials
# return: True if success is valid. Else error.
check_success = function(success, trials) {
  valid = check_trials(trials)
  if((success <= trials) & (success >= 0)){
    valid = TRUE
  } else {
    if(success < 0) {
      stop('invalid success value')
    } else {
      stop('success cannot be greater than trials')
    }
  }
  return(valid)
}
