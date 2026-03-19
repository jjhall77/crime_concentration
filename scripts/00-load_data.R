library(tidyverse)
library(janitor)
library(here)
library(sf)

data_dir <- here("data")
files <- list.files(data_dir, full.names = TRUE)

library(readr)
library(dplyr)
library(janitor)
library(here)

data_dir <- here("data")

cfs_hist_1 <- read_csv(
  file.path(data_dir, "NYPD_Calls_for_Service_(Historic)_20260224.csv"),
  col_types = cols(.default = col_character()),
  show_col_types = FALSE
) %>% clean_names()

cfs_hist_2 <- read_csv(
  file.path(data_dir, "NYPD_Calls_for_Service_(Historic)_20260224 (1).csv"),
  col_types = cols(.default = col_character()),
  show_col_types = FALSE
) %>% clean_names()

cfs_ytd_1 <- read_csv(
  file.path(data_dir, "NYPD_Calls_for_Service_(Year_to_Date)_20260224.csv"),
  col_types = cols(.default = col_character()),
  show_col_types = FALSE
) %>% clean_names()

cfs_ytd_2 <- read_csv(
  file.path(data_dir, "NYPD_Calls_for_Service_(Year_to_Date)_20260224 (1).csv"),
  col_types = cols(.default = col_character()),
  show_col_types = FALSE
) %>% clean_names()

cfs <- bind_rows(cfs_hist_1, cfs_hist_2, cfs_ytd_1, cfs_ytd_2)

nrow(cfs)
table(cfs$typ_desc)


cfs_disorder <- cfs %>%
  filter(str_detect(typ_desc, "^DISORDERLY"))

cfs_narco <- cfs %>%
  filter(str_detect(typ_desc, "NARCO"))


# -----------------------
# Complaints
# -----------------------
compl_hist <- files[str_detect(files, "Complaint_Data_Historic")] %>%
  read_csv(show_col_types = FALSE) %>%
  clean_names()

compl_ytd <- files[str_detect(files, "Complaint_Data_Current")] %>%
  .[!str_detect(., "\\(2\\)")] %>%
  read_csv(show_col_types = FALSE) %>%
  clean_names()

complaints <- bind_rows(
  compl_hist %>% mutate(source_period = "historic"),
  compl_ytd  %>% mutate(source_period = "ytd")
)

# -----------------------
# Other CSVs
# -----------------------
shootings <- files[str_detect(files, "Shootings_")] %>%
  read_csv(show_col_types = FALSE) %>%
  clean_names()

sr311 <- files[str_detect(files, "311_Service")] %>%
  read_csv(show_col_types = FALSE) %>%
  clean_names()

# -----------------------
# Spatial (EPSG:2263)
# -----------------------
nycb2020  <- st_read(file.path(data_dir, "nycb2020_25d"), quiet = TRUE)
nyct2020  <- st_read(file.path(data_dir, "nyct2020_25d"), quiet = TRUE)
nynta2020 <- st_read(file.path(data_dir, "nynta2020_25d"), quiet = TRUE)
nypp      <- st_read(file.path(data_dir, "nypp_25d"), quiet = TRUE)

intersection_nodes <- st_read(file.path(data_dir, "intersection_nodes.gpkg"), quiet = TRUE)
physical_blocks    <- st_read(file.path(data_dir, "physical_blocks.gpkg"), quiet = TRUE)




# -----------------------
# Glimpses
# -----------------------

glimpse(cfs)
glimpse(cfs_disorder)
glimpse(cfs_narco)

glimpse(complaints)

glimpse(shootings)
glimpse(sr311)

glimpse(nycb2020)
glimpse(nyct2020)
glimpse(nynta2020)
glimpse(nypp)

glimpse(intersection_nodes)
glimpse(physical_blocks)




x <- complaints %>%
  count(ky_cd, ofns_desc, pd_cd, pd_desc)
write_csv(x, here("output","key_codes.csv"))

