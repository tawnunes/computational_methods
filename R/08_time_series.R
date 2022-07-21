# Scientific Computing course ICTP/Serrapilheira
# Class 09 - Time series
# Using Covid-19 data from Recife in Pernambuco, Brazil.
# Data was downloaded from the portal https://brasil.io/home/

# Packages ----

library(dplyr)
library(ggplot2)
library(lubridate)
library(zoo)

# Loading the data ----

covid <- read.csv("./data/raw/covid/covid19.csv")

# First checking the class
class(covid$date)

## Changing the date format using lubridate package ----

# Changing to date format
covid$date <- as_date(covid$date)
# Checking the class
class(covid$date)

# Now we can make numeric operations
range(covid$date)

## Ploting the time-series ----

# Fixing nevative numbers

covid$new_confirmed[covid$new_confirmed < 0] <- 0

# Plot
ggplot(covid) +
  geom_line(aes(x = date, y = new_confirmed)) +
  theme_classic() +
  scale_x_date(date_breaks = "4 months", date_labels = "%Y/%m")+
  labs(x = "Date", y = "New cases")

## Rolling mean ----

covid$roll_mean <- zoo::rollmean(covid$new_confirmed, 14, fill=NA)

# Plot
ggplot(covid) +
  geom_line(aes(x = date, y = new_confirmed)) +
  theme_classic() +
  scale_x_date(date_breaks = "4 months", date_labels = "%Y/%m")+
labs(x = "Date", y = "New cases")+
  geom_line(aes(date,roll_mean, colour = "red"))
