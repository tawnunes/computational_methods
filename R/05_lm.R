# --------------------------------------------------#
# Scientific computing
# ICTP/Serrapilheira 2022
# Script to fit linear model in R
# First version 2022-07-18
# --------------------------------------------------#

# loading packages
library(ggplot2)

# reading data
cat <- read.csv("data/raw/caterp/crawley_regression.csv")

# Do leaf chemical compounds affect the growth of caterpillars? ----------------

# the response variable
boxplot(cat$growth, col = "darkgreen")

# the predictor variable
unique(cat$tannin)

# creating the lm
mod_cat <- lm(growth ~ tannin, data = cat)

summary(mod_cat)

# intercep (a) = 11.7 - y (response) when x (predictor) is zero
# tannin (beta/slope) = -1.2
# R-squared = 0.79



## ----lm-plot------------------------------------------------------------------
plot(growth ~ tannin, data = cat, bty = 'l', pch = 19)
abline(mod_cat, col = "red", lwd = 2)


## ----lm-ggplot----------------------------------------------------------------
ggplot(data = cat, mapping = aes(x = tannin, y = growth)) +
  geom_point() +
  geom_smooth(method = lm) +
  theme_classic()


## AOV table
summary.aov(mod_cat)
# sum of squares
# tannin (SSbetween) = 88.8
# Residuals (SSerror) = 20.7



## fitted values
predict(mod_cat) # stract predicted values from the model
cat$fitted <- predict(mod_cat)

# Comparing fitted vs. observed values
ggplot(data = cat) +
  geom_point(aes(x = growth, y = fitted)) +
  geom_abline(aes(slope = 1,  intercept = 0)) +
  # well fitted the points should be near to the line
  theme_classic()


## Model diagnostics from the residuals -----------------------------------------------------------
par(mfrow = c(2, 2))
plot(mod_cat)
par(mfrow = c(1, 1))

# Plot 1 - Residuals vs fitted
# - represent the homogeinity of the residuals
# - expect the red line should horizontal
# - shouldn't see any pattern in the points
#
# Plot 2 - Normal Q-Q
# - show if the residuals have normal distribution
# - expect all points close to the line
#
# Plot 3 - Scale-Location
# - Expect horizontal line
# - variance distribution
#
# Plot 4
# - measurement
# - expect

# Comparing statistical distributions ------------------------------------------
library(fitdistrplus)

data("groundbeef")
?groundbeef
str(groundbeef)


plotdist(groundbeef$serving, histo = TRUE, demp = TRUE)

descdist(groundbeef$serving, boot = 1000)

fw <- fitdist(groundbeef$serving, "weibull")
summary(fw)

fg <- fitdist(groundbeef$serving, "gamma")
fln <- fitdist(groundbeef$serving, "lnorm")

par(mfrow = c(2, 2))
plot_legend <- c("Weibull", "lognormal", "gamma")
denscomp(list(fw, fln, fg), legendtext = plot_legend)
qqcomp(list(fw, fln, fg), legendtext = plot_legend)
cdfcomp(list(fw, fln, fg), legendtext = plot_legend)
ppcomp(list(fw, fln, fg), legendtext = plot_legend)
par(mfrow = c(1, 1))


# compare the fitteness of the distributions by different methods
gofstat(list(fw, fln, fg))

