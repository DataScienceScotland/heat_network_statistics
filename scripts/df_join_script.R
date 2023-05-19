# Create a dataframe that contains: 

# - All of the matched dataset 
# - Along with the unmatched entries

# So in total the n() of entries should be as long as HNMBR_2022. 

# first a quick package load

libraries <- c("tidyverse", "janitor")
lapply(libraries, require, character.only = T)

# and then a data load 

hnmbr_full <- read_csv("Z:/Heatmap/1. Heat Statistics and Energy Mapping/Data/Heat Network Metering and Billing data/HNMBR_2022/Cleaned_HNMBR_Combined.csv")

hnmbr_matched <- read_csv("Z:/Heatmap/1. Heat Statistics and Energy Mapping/Data/Heat Network Metering and Billing data/HNMBR_2022/FINAL_HN_matched_df_446_sharing.csv")

# So we want to append all of the unmatched networks to the matched ones, to do so, we first must make a subset of all  the unmatched networks that do not exist in the matched dataset. 

hnmbr_unmatched <- hnmbr_full %>% 
  anti_join(hnmbr_matched, by = c("propert_name_heat_network" = "propert_name_heat_network.x"))


# SENSE CHECK = df n() should be = to n(full) - n(matched) 
# Not the case here due to some networks matching onto repeats. 

hnmbr_complete <- plyr::rbind.fill(hnmbr_matched, hnmbr_unmatched) 

hnmbr_complete %>% 
  write_csv("Z:/Heatmap/1. Heat Statistics and Energy Mapping/Data/Heat Network Metering and Billing data/HNMBR_2022/data/HNMBR_2018-2022_COMPLETE")
