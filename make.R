################################
# 29/11/2021, dubearna@tcd.ie
#
# make.R
#
# script pour l'exécution du projet entier
#
################################


# deps install
devtools::install_deps()

# load functions
#devtools::load_all() #Ne fonctionne pas avec {target}
source(here::here("R", "data_wildfinder.R"))

#run exo_dyplr
source(here::here("exercices","exo_dplyr.R"))
