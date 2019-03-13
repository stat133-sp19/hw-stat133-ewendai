
title: "Make shot charts script"
description: Script to make shot charts
input(s): nba-court.jpg, data for each player, shots-data.csv
output(s): Make shot charts for each player along with a facetted shot chart

library(jpeg)
library(grid)
library(ggplot2)

# court image (to be used as background of plot)
court_file <- "images/nba-court.jpg"

# create raste object
court_image <- rasterGrob(
  readJPEG(court_file),
  width = unit(1, "npc"),
  height = unit(1, "npc")
)

# shot charts with court background
andre_shot_chart <- ggplot(data = iguodala) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Andre Iguodala (2016 season)') +
  theme_minimal()

draymond_shot_chart <- ggplot(data = green) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Draymond Green (2016 season)') +
  theme_minimal()

kevin_shot_chart <- ggplot(data = durant) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Kevin Durant (2016 season)') +
  theme_minimal()

klay_shot_chart <- ggplot(data = thompson) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Klay Thompson (2016 season)') +
  theme_minimal()

stephen_shot_chart <- ggplot(data = curry) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Stephen Curry (2016 season)') +
  theme_minimal()

# Save as pdf
pdf(file = "images/andre-iguodala-shot-chart.pdf", width = 6.5, height = 5)
ggplot(data = iguodala) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Andre Iguodala (2016 season)') +
  theme_minimal()
dev.off()

pdf(file = "images/draymond-green-shot-chart.pdf", width = 6.5, height = 5)
ggplot(data = green) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Draymond Green (2016 season)') +
  theme_minimal()
dev.off()

pdf(file = "images/kevin-durant-shot-chart.pdf", width = 6.5, height = 5)
ggplot(data = durant) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Kevin Durant (2016 season)') +
  theme_minimal()
dev.off()

pdf(file = "images/klay-thompson-shot-chart.pdf", width = 6.5, height = 5)
klay_shot_chart <- ggplot(data = thompson) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Klay Thompson (2016 season)') +
  theme_minimal()
dev.off()

pdf(file = "images/stephen-curry-shot-chart.pdf", width = 6.5, height = 5)
ggplot(data = curry) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Stephen Curry (2016 season)') +
  theme_minimal()
dev.off()

# Facetted Shot Chart
pdf(file = "images/gsw-shot-charts.pdf", width = 8, height = 7)
ggplot(data = shots, aes(x = x, y = y)) + 
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(color = shot_made_flag)) + theme_minimal() + 
  ylim(-50, 420) +
  facet_wrap(~ name)
dev.off()

png(filename = "images/gsw-shot-charts.png", width = 8, height = 7, units = "in", res = 200)
ggplot(data = shots, aes(x = x, y = y)) + 
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(color = shot_made_flag)) + theme_minimal() + 
  ylim(-50, 420) +
  facet_wrap(~ name)
dev.off()