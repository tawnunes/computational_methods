# ICTP-SFAIR/Serrapilheira
# Traingin Program inQuantitative Biology and Ecology
# Computational Methods
# Diversity metrics I

# Packages -----

library(dplyr)

# Species abundace, frequency, richness ----

# Which are the 5 most abundant species overall in the dataset?

comm <- read.csv("data/raw/cestes/comm.csv")

abundant <- colSums(comm[,-1])
sort(abundant, decreasing =T)

# How many species are there in each site? (richness)

richness <-comm %>% select(!Sites) %>%
  mutate_all(.fun = function(x) if_else(x>0,1,0)) %>%
  mutate(richness = rowSums(comm)) %>%
  mutate(sites = comm$Sites) %>%
  arrange(desc(richness))

head(richness[,57:58])


# Which the species that is most abundant in each site?

rownames(comm) <- paste0("Site", comm[,1])
most_abundant <- comm %>% select(!Sites) %>%
  apply(1, which.max)


