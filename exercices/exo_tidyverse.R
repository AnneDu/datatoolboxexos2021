################################
# 30/11/2021, dubearna@tcd.ie
#
# exo_tydiverse.R
#
# script pour l'exo tydiverse
#
################################
# load species data

species <- data_sp_list()


# load eco data

ecoreg <- data_eco_list()


# load sp-eco data

sp_eco <- data_sp_eco()

#Select Ursidés rows
ursidae<-species %>%
  dplyr::filter(stringr::str_detect(family, 'Ursidae'))

#Delete Ursus malayanus
ursidae<-ursidae %>% dplyr::filter(!stringr::str_detect(species, "malayanus"))

#Join species table & sp_eco table
#sp_eco_ur<-dplyr::inner_join(ursidae,sp_eco)
sp_eco_ur <- ursidae %>%
  left_join(sp_eco)

#Join sp_eco_ur & ecoreg
#ecoreg_ur<-dplyr::inner_join(sp_eco_ur,ecoreg)
ecoreg_ur <- sp_eco_ur %>%
  left_join(ecoreg, by = "ecoregion_id")

#Group by species and count number of biomes
#ecoreg_ur %>%
#  dplyr::group_by(species) %>%
#  dplyr::across(species, dplyr::count(ecoregion))

#count realms
realm_ursus <- ecoreg_ur %>%
  group_by(sci_name) %>%
  summarise(n_realms     = n_distinct(realm))

