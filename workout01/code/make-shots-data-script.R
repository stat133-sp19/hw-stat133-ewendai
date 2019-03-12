
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
iguodala[iguodala['shot_made_flag'] == 'y', 'shot_made_flag'] = 'shot_yes'
iguodala[iguodala['shot_made_flag'] == 'n', 'shot_made_flag'] = 'shot_no'
green[green['shot_made_flag'] == 'y', 'shot_made_flag'] = 'shot_yes'
green[green['shot_made_flag'] == 'n', 'shot_made_flag'] = 'shot_no'
durant[durant['shot_made_flag'] == 'y', 'shot_made_flag'] = 'shot_yes'
durant[durant['shot_made_flag'] == 'n', 'shot_made_flag'] = 'shot_no'
thompson[thompson['shot_made_flag'] == 'y', 'shot_made_flag'] = 'shot_yes'
thompson[thompson['shot_made_flag'] == 'n', 'shot_made_flag'] = 'shot_no'
curry[curry['shot_made_flag'] == 'y', 'shot_made_flag'] = 'shot_yes'
curry[curry['shot_made_flag'] == 'n', 'shot_made_flag'] = 'shot_no'

# Add column minute
iguodala['minute'] = iguodala['period']*4 - iguodala['minutes_remaining']
green['minute'] = green['period']*4 - green['minutes_remaining']
durant['minute'] = durant['period']*4 - durant['minutes_remaining']
thompson['minute'] = thompson['period']*4 - thompson['minutes_remaining']
curry['minute'] = curry['period']*4 - curry['minutes_remaining']

# Sinking
sink(file = "output/andre-iguodala-summary.txt")
summary(iguodala)
sink()

sink(file = "output/draymond-green-summary.txt")
summary(green)
sink()

sink(file = "output/kevin-durant-summary.txt")
summary(durant)
sink()

sink(file = "output/klay-thompson-summary.txt")
summary(thompson)
sink()

sink(file = "output/stephen-curry-summary.txt")
summary(curry)
sink()

