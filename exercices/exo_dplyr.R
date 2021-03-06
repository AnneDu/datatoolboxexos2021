################################
# 29/11/2021, dubearna@tcd.ie
#
# exo_dplyr.R
#
# script pour l'exo dplyr
#
################################


# load sp-eco data

dat <- data_sp_eco()

mam_per_eco <- table(dat$ecoregion_id)

png(filename = here::here("outputs","exo_dplyr_hist_mams.png"))
hist(mam_per_eco, breaks=50, ylab="ecoregions nb", xlab="species nb", col="salmon")
dev.off()

