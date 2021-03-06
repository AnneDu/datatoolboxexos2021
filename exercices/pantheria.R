################################
# 30/11/2021, dubearna@tcd.ie
#
# pantheria.R
#
# script pour l'exo ggplot2
#
################################
#Load tidyverse
library(tidyverse)

#Load pantheria data
pantheria <- readr::read_delim("data/pantheria-traits/pantheria.txt", delim = "\t")

#Transform MSW05_Order and MSW05_Family columns in factors
#pantheria <- dplyr::mutate(pantheria, MSW05_Order = as.factor(MSW05_Order))
#levels(pantheria$MSW05_Order)

#pantheria <- dplyr::mutate(pantheria, MSW05_Family = as.factor(MSW05_Family))
#levels(pantheria$MSW05_Family)
pantheria <- pantheria %>%
  mutate(
    order   = as_factor(MSW05_Order),
    family  = as_factor(MSW05_Family)
  )



#Rename columns 5-1_AdultBodyMass_g, 7-1_DispersalAge_d, 9-1_GestationLen_d, 22-2_HomeRange_Indiv_km2, 16-1_LittersPerYear, 17-1_MaxLongevity_m
pantheria <- dplyr::rename(pantheria,
                                adult_bodymass = "5-1_AdultBodyMass_g",
                                dispersal_age = "7-1_DispersalAge_d",
                                gestation = "9-1_GestationLen_d",
                                homerange = "22-2_HomeRange_Indiv_km2",
                                litter_size = "16-1_LittersPerYear",
                                longevity = "17-1_MaxLongevity_m")
pantheria

#Sélection de colonnes et convertir les na
pantheria <- pantheria %>%
  select(
    order,
    family,
    adult_bodymass,
    dispersal_age,
    gestation,
    homerange,
    litter_size,
    longevity
  ) %>%
  na_if(-999)

#Nb observations per family and order
pantheria %>% dplyr::count(family)
pantheria %>% dplyr::count(order)

#Homerange mean, sd, sample size
pantheria %>%
  dplyr::filter(!is.na(homerange)) %>%
  group_by(family) %>%
  dplyr::summarise(mean=mean(homerange), sd=sd(homerange), n=n())

#plot 1
pantheria %>%
  group_by(family) %>% # group by family
  mutate(n = n()) %>% # calculate number of entries per family
  filter(n > 100) %>% # select only the families with more than 100 entries
  ggplot() +
  aes(x = fct_reorder(family, n), y = n) + # order bars
  geom_col() +
  coord_flip() + # flip the bar chart
  xlab("Family") + # add label for X axis
  ylab("Counts") + # add label for Y axis
  ggtitle("Number of entries per family") # add title

#plot 2
theme_set(theme_bw()) # play around with theme
pantheria %>%
  filter(!is.na(litter_size), !is.na(longevity)) %>%
  group_by(family) %>% # group by family
  mutate(n = n()) %>% # count the number of entries per family
  mutate(longevity = longevity / 12) %>% # Change month to year
  filter(n > 10) %>% # select only those families with more than 50 entries
  ggplot() +
  aes(x = longevity, y = litter_size, col = family) + # scatter plot
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) + # se = TRUE to add confidence intervals
  xlab("Longevity") + # add label for X axis
  ylab("Litter size") + # add label for Y axis
  ggtitle("Scatterplot") + # add title
  facet_wrap(~ family, nrow = 3) # split in several panels,
# one for each family
# remove scale = 'free' for
# same scale for all plots
