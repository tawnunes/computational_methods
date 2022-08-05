# ICTP-SFAIR/Serrapilheira
# Traingin Program inQuantitative Biology and Ecology
# Computational Methods
# Multivariate Analysis in Ecology

# Packages ----
library(vegan)
library(cluster)

# Data ----

data(dune)
data(dune.env)
table(dune.env$Management)

# Cluster analysis of dune vegetation ----

## Dissimilarity ----
# Calculate two dissimilarity indices between sites: Bray-Curtis and Chord distance
bray_distance <- vegdist(dune)

# Chord distance, euclidean distance normalized to 1
chord_distance <- dist(decostand(dune, "norm"))

## Clustering ----

bray_cluster <- hclust(bray_distance, method = "average")

chord_cluster <- hclust(chord_distance, method = "average")

# Plotting the results

par(mfrow = c(1,2))
plot(bray_cluster)
plot(chord_cluster)
par(mfrow = c(1,1))

# More prettyish plot
par(mfrow = c(1, 2))
plot(bray_cluster, hang = -1, main = "", axes = F)
axis(2, at = seq(0, 1, 0.1), labels = seq(0, 1, 0.1), las = 2)
plot(chord_cluster, hang = -1, main = "", axes = F)
axis(2, at = seq(0, 1, 0.1), labels = seq(0, 1, 0.1), las = 2)
par(mfrow = c(1,1))


# PCA analysis ----
# Pca only accepts normalized data

norm <- decostand(dune, "norm")
pca <- rda(norm)
summary(pca)

plot(pca)
plot(pca, choices = c(2,3))


# PCA for the environmental data

pca_env <- rda(dune.env)
