
title: "Make shots data script"
author: "Ewen Dai"
date: "March 11, 2019"
output: github_document

# Read in the data sets
iguodala = read.csv(file = "data/andre-iguodala.csv", stringsAsFactors = F)
green = read.csv(file = "data/draymond-green.csv", stringsAsFactors = F)
durant = read.csv(file = "data/kevin-durant.csv", stringsAsFactors = F)
thompson = read.csv(file = "data/klay-thompson.csv", stringsAsFactors = F)
curry = read.csv(file = "data/stephen-curry.csv", stringsAsFactors = F)

# Add name to each df
iguodala['name'] = 'Andre Iguodala'
green['name'] = 'Graymond Green'
durant['name'] = 'Kevin Durant'
thompson['name'] = 'Klay Thompson'
curry['name'] = 'Stephen Curry'

# Change values of shot_made_flag to be more descriptive
