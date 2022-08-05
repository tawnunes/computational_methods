# ICTP-SFAIR/Serrapilheira
# Traingin Program inQuantitative Biology and Ecology
# Computational Methods
# From taxonomic to functional and phylogenetic diversity

# Packages ----
library(vegan)
library(dplyr)
library(cluster)
library(FD)
library(SYNCSA)
library(taxize)

# Loading data -----
comm <- read.csv("data/raw/cestes/comm.csv")

traits <- read.csv("data/raw/cestes/traits.csv")

species <- read.csv("data/raw/cestes/splist.csv")

# Manipulating the data ----

# Renaming comm's rows with the sites name so we don't need a column for site
rownames(comm) <- paste0("Site", comm[,1])
comm <- comm[,-1] # excluding sites column
head(comm)[,1:5]

# Renaming traits' rows with the species code so we don't need a species columun
rownames(traits) <- paste0(traits$Sp)
traits <- traits[,-1]
head(traits)[,1:5]

# Getting the hole taxonomical information from ncbi
classification_data <- taxize::classification(species$TaxonName, db= "ncbi")
str(classification_data)
length(classification_data)

classification_data$`Arisarum vulgare`
classification_data[[1]]

# Get a vector with all the species family

tible_ex <- classification_data[[1]] %>%
  filter(rank == "family") %>%
  select(name) # returns a tible (data frame)

vector_ex <- classification_data[[1]] %>%
  filter(rank == "family") %>%
  pull(name)

# creating a vector with family nemes

extrac_family <- function(x){
 if(!is.null(dim(x))){
  y <- x %>%
    filter(rank == "family") %>%
    pull(name)
  return(y)
  }
}

extrac_family(classification_data[[1]])

families <- vector()
for (i in 1:length(classification_data)){
  f <- extrac_family(classification_data[[i]])
  if (length(f)>0) families[i] <- f
}
families


# Species richness ----

richness <- specnumber(comm)

# Taxonomic diversity ----

shannon <- diversity(comm)
simpson <- diversity(comm, index = "simpson")

# Functional diversity ----

# When analyzing functional traits the distance between individuals is no
# longer determined by their belonging to a species, but to their position
# in the trait space.
# Gower distance is a common distance metric used in trait-based ecology.

gower_clust <- cluster::daisy(traits, metric = "gower")

gower_fd <- FD::gowdis(traits)

# implemantations in R vary and the literature reports extensions and modifications
identical(gower_clust, gower_fd)
# Not equal

# they have different classes
class(gower_clust)
class(gower_fd)

# however the values are equal
plot(gower_clust, gower_fd)

# Rao's quadratic entropy calculations in R ----

tax <- rao.diversity(comm)
func <- rao.diversity(comm, traits = traits)


# Calculation Functional Diversity ----

# we can use the distance matrix to calculate functional diversity indices
func_div <- dbFD(x = gower_clust, a = comm, messages = F)

#the returned object has Villéger's indices and Rao calculation
names(func_div)

#We can also do the calculation using the traits matrix directly
func_div_trait <- dbFD(x = traits, a = comm, messages = F)

# Summarazing visually ----

