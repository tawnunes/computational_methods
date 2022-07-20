library(bbmle)

cuckoo <- read.csv("./data/raw/cuckoo/valletta_cuckoo.csv")


#models and hypotesis

h1 <- glm(Beg ~ Mass, data = cuckoo,
          family = poisson(link = log)) # The species does not matter

h2 <- glm(Beg ~ Mass + Species, data = cuckoo,
          family = poisson(link = log)) # Species are different but the slope is equal

h3 <- glm(Beg ~ Mass * Species, data = cuckoo,
          family = poisson(link = log)) # the slope is different for the two species

h0 <- glm(Beg ~ 0, data = cuckoo,
          family = poisson(link = log))# Beg does not depends anything, null model


# comparing the models by AIC

AICtab(h0, h1, h2, h3, base=T, weights=T)
# h3 is the better fitting model df 4 means that it has 4 parameters

# Predicted values ----------------------------------------------------------------------

# Calculating the predicted values
newdata <- expand.grid(Mass = seq(min(cuckoo$Mass), max(cuckoo$Mass), length.out = 200),
                       Species = unique(cuckoo$Species))
newdata$Beg <- predict(h3, newdata, type = 'response')

## explore ?predict.glm

p <- ggplot(mapping = aes(x = Mass, y = Beg, colour = Species)) +
  geom_point(data = cuckoo) +  geom_line(data = newdata) +
  theme_classic()
