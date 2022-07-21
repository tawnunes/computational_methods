# Scientific Computing course ICTP/Serrapilheira
# Class 09 - Population models

# Packages -----

library(deSolve)
library(ggplot2) # because we will plot things
library(tidyr) # because we will manipulate some data
source("./functions/logGrowth.R")
source("./functions/lotka_volterra.R")


# Logistic Growth model ----

## Setting parameters ------

# named vector with parameters r and a
p <- c(r = 1, a = 0.001)

# initial condition
y0 <- c(N = 10)

# time steps
t <- 1:20
# Other ways to create sequences:
# t <- seq(1, 200, by = .05)

## Solving the differential equation -----

# give the function and the parameters to the ode function
out_log <- ode(y = y0, times = t, func = logGrowth, parms = p)

head(out_log)

## Ploting the curve -----

df_log <- as.data.frame(out_log) # transform in data frame to work
# Plot
ggplot(df_log) +
  geom_line(aes(x = time, y = N)) +
  theme_classic()


# Lotka-Volterra competition model -----

## Setting parameters ----

# LV parameters
a <- matrix(c(0.02, 0.01, 0.01, 0.03), nrow = 2)
r <- c(1, 1) # Growth rates
p2 <- list(r, a)
N0 <- c(10, 10) # initial condition
t2 <- c(1:100) # time series

## Solving the differential equation -----

out_lv <- ode(y = N0, times = t2, func = LVComp, parms = p2)
head(out_lv)

## Ploting the curves ----

df_lv <- pivot_longer(as.data.frame(out_lv), cols = 2:3)

ggplot(df_lv) +
  geom_line(aes(x = time, y = value, color = name)) +
  labs(x = "Time", y = "N", color = "Species") +
  theme_classic()

