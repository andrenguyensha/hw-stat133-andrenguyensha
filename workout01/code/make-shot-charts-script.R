#Andre Sha's make shot charts
#In this R script, I made shot charts of the five GSW players as well as congregated them into one png and pdf file.
#Inputs: shots-data.csv and nba-court.jpeg
#Outputs: andre_iguodala_shot_chart.pdf, draymond_green_shot_chart.pdf, kevin_durant_shot_chart.pdf, klay_thompson_shot_chart.pdf, stephen_curry_shot_chart.pdf, facet_shot_chart.pdf, facet_shot_chart.png 

library(dplyr)
library(ggplot2)
library(jpeg)
library(grid)

data_types = c("team_name"="character", "game_date"="character", "season" = "integer", "period"="integer",
               "minutes_remaining"="integer", "seconds_remaining"="integer", "shot_made_flag"="character",
               "action_type"="factor", "shot_type"="factor", "shot_distance"="integer", "opponent"="character",
               "x"="integer", "y"="integer")

allplayers <- read.csv('../data/shots-data.csv', stringsAsFactors = FALSE, colClasses = data_types)


#import court image (to be used as background of plot)
url <- "https://raw.githubusercontent.com/ucb-stat133/stat133-hws/master/images/nba-court.jpg"
destination <- "../images/nba-court.jpeg"
download.file(url, destination)

court_file <- "../images/nba-court.jpeg"
court_image <- rasterGrob(readJPEG(court_file), width = unit(1, "npc"), height = unit(1, "npc"))

andre <- allplayers[allplayers$name=="Andre Iguodala",]
draymond <- allplayers[allplayers$name == "Draymond Green",]
kevin <- allplayers[allplayers$name == "Kevin Durant",]
klay <- allplayers[allplayers$name == "Klay Thompson",]
stephen <- allplayers[allplayers$name == "Stephen Curry",]

andre_shot_chart <- ggplot(data = andre) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Andre Iguodala (2016 season)') +
  theme_minimal()

draymond_shot_chart <- ggplot(data = draymond) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Draymond Green (2016 season)') +
  theme_minimal()

kevin_shot_chart <- ggplot(data = kevin) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Kevin Durant (2016 season)') +
  theme_minimal()

klay_shot_chart <- ggplot(data = klay) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Klay Thompson (2016 season)') +
  theme_minimal()

stephen_shot_chart <- ggplot(data = stephen) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Stephen Curry (2016 season)') +
  theme_minimal()

pdf('../images/andre-iguodala-shot-chart.pdf', width=6.5,height=5)
andre_shot_chart
dev.off()


pdf('../images/draymond-green-shot-chart.pdf', width=6.5,height=5)
draymond_shot_chart
dev.off()


pdf('../images/kevin-durant-shot-chart.pdf', width=6.5,height=5)
kevin_shot_chart
dev.off()

pdf('../images/klay-thompson-shot-chart.pdf', width=6.5,height=5)
klay_shot_chart
dev.off()

pdf('../images/stephen-curry-shot-chart.pdf', width=6.5,height=5)
stephen_shot_chart
dev.off()

facet_shot_chart <- ggplot(data = allplayers) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Charts: GSW (2016 season)') +
  theme_minimal()+
  facet_wrap(~ name)

facet_shot_chart

pdf('../images/gsw-shot-charts.pdf', width= 8, height= 7)
facet_shot_chart
dev.off()

png('../images/gsw-shot-charts.png', width=8,height=7, units="in", res = 72)
facet_shot_chart
dev.off()

