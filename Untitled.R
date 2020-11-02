# Library load
library(stringr)
library(tidyverse)
library(ggridges)
library(ggplot2)
library("scales")

# Get the Data

passwords <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-01-14/passwords.csv')

# Install via devtools::install_github("thebioengineer/tidytuesdayR")
devtools::install_github("thebioengineer/tidytuesdayR")
tuesdata <- tidytuesdayR::tt_load('2020-01-14') 
tuesdata <- tidytuesdayR::tt_load(2020, week = 3)

passwords_base <- tuesdata$passwords

# Create 'legth' column from 'password' length
passwords <- passwords %>% 
  mutate(length = str_length(passwords$password)) %>% 
  mutate(strength_ten = round(rescale(strength, to = c(1,10)), digits = 0))

passwords %>% 
  ggplot(aes(x = strength_ten, y = category)
  ) +
  geom_density_ridges() +
  theme_ridges() + 
  theme(legend.position = "none") +
  geom_density_ridges_gradient() +
  scale_fill_continuous()
