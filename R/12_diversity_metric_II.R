# ICTP-SFAIR/Serrapilheira
# Traingin Program inQuantitative Biology and Ecology
# Computational Methods
# Diversity metrics II

# Check vegan::divertisty help
library(vegan)

community_A <- c(10, 6, 4, 1)
community_B <- c(17, rep(1, 7))

diversity(community_A, "shannon")
diversity(community_B, "shannon")
# Both 1.17

diversity(community_A, "invsimpson")
diversity(community_B, "invsimpson")
# A 2.8 and B 1.9 - that's more robust than shannon

ren_comm_A <- renyi(community_A)
ren_comm_B <- renyi(community_B)
# 0 = richness, 1 = shannon, 2 = simpson


ren_AB <- rbind(ren_comm_A,ren_comm_B)

matplot(t(ren_AB),
        type ="l",
        axes =F)
box()
axis(side = 2)
axis(side = 1,
     labels = c(0, 0.25, 0.50, 1, 2, 4, 8, 16, 32, 64, "Inf"),
     at = 1:11)
legend("topright",
       legend = c("Community A", "Community B"),
       lty = c(1, 2),
       col = c(1, 2))
