
title: ""
description: bleh
input(s): dskj
output(s): klsd

# court image (to be used as background of plot)
court_file <- "images/nba-court.jpg"
# create raste object
court_image <- rasterGrob(
  readJPEG(court_file),
  width = unit(1, "npc"),
  height = unit(1, "npc")
)