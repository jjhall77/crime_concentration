# =============================================================================
# 05-build_crosswalk.R
# Build Block → Census Tract → NTA → Precinct Crosswalk
#
# Maps every physical block to its census tract, NTA, and precinct via
# spatial joins on block centroids. Census tract → NTA mapping uses the
# official NYC 2020 relationship file.
#
# Output: data/block_crosswalk.rds
# =============================================================================

library(tidyverse)
library(sf)
library(here)
library(readxl)

cat("\n")
cat(strrep("=", 70), "\n")
cat("BUILD BLOCK CROSSWALK\n")
cat(strrep("=", 70), "\n\n")

# =============================================================================
# SECTION 1: LOAD SPATIAL LAYERS
# =============================================================================

cat("LOADING SPATIAL DATA...\n")
cat(strrep("-", 40), "\n")

physical_blocks <- st_read(
  here("data", "physical_blocks.gpkg"), quiet = TRUE
) %>% st_transform(2263)
cat("  physical_blocks:", scales::comma(nrow(physical_blocks)), "blocks\n")

tracts <- st_read(
  here("data", "nyct2020_25d", "nyct2020.shp"), quiet = TRUE
) %>% st_transform(2263)
cat("  census tracts:", nrow(tracts), "\n")

precincts <- st_read(
  here("data", "nypp_25d", "nypp.shp"), quiet = TRUE
) %>% st_transform(2263)
cat("  precincts:", nrow(precincts), "\n")

# Official tract → NTA → CDTA relationship file
tract_nta <- read_excel(
  here("data", "nyc2020census_tract_nta_cdta_relationships (1).xlsx")
)
cat("  tract-NTA crosswalk:", nrow(tract_nta), "rows\n")

# =============================================================================
# SECTION 2: COMPUTE BLOCK CENTROIDS
# =============================================================================

cat("\nCOMPUTING BLOCK CENTROIDS...\n")
cat(strrep("-", 40), "\n")

block_centroids <- physical_blocks %>%
  select(physical_id, boro) %>%
  st_centroid()

cat("  Centroids computed for", scales::comma(nrow(block_centroids)), "blocks\n")

# =============================================================================
# SECTION 3: SPATIAL JOIN — BLOCKS TO CENSUS TRACTS
# =============================================================================

cat("\nSPATIAL JOIN: BLOCKS → CENSUS TRACTS...\n")
cat(strrep("-", 40), "\n")

# Prepare tract polygons — keep only the join key
tracts_join <- tracts %>%
  select(BoroCT2020) %>%
  st_make_valid()

# Primary: point-in-polygon
joined_tracts <- st_join(block_centroids, tracts_join, join = st_within, left = TRUE)

# Check for duplicates (centroids in overlapping polygons)
n_dups <- sum(duplicated(joined_tracts$physical_id))
if (n_dups > 0) {
  cat("  WARNING:", n_dups, "duplicate assignments (taking first match)\n")
  joined_tracts <- joined_tracts %>%
    group_by(physical_id) %>%
    slice(1) %>%
    ungroup()
}

n_unmatched_tract <- sum(is.na(joined_tracts$BoroCT2020))
cat("  Matched:", scales::comma(nrow(joined_tracts) - n_unmatched_tract), "\n")
cat("  Unmatched:", n_unmatched_tract, "\n")

# Fallback: nearest feature for unmatched
if (n_unmatched_tract > 0) {
  cat("  Applying st_nearest_feature fallback...\n")
  unmatched_idx <- which(is.na(joined_tracts$BoroCT2020))
  unmatched_pts <- block_centroids[block_centroids$physical_id %in%
                                     joined_tracts$physical_id[unmatched_idx], ]
  nearest_idx <- st_nearest_feature(unmatched_pts, tracts_join)
  joined_tracts$BoroCT2020[unmatched_idx] <- tracts_join$BoroCT2020[nearest_idx]
  cat("  All blocks now assigned to tracts\n")
}

# =============================================================================
# SECTION 4: JOIN TRACT → NTA VIA EXCEL CROSSWALK
# =============================================================================

cat("\nJOINING TRACT → NTA VIA RELATIONSHIP FILE...\n")
cat(strrep("-", 40), "\n")

tract_nta_lookup <- tract_nta %>%
  select(BoroCT2020, NTA2020 = NTACode, NTAName, NTAType)

crosswalk <- joined_tracts %>%
  st_drop_geometry() %>%
  left_join(tract_nta_lookup, by = "BoroCT2020")

n_missing_nta <- sum(is.na(crosswalk$NTA2020))
cat("  Blocks with NTA assignment:", scales::comma(nrow(crosswalk) - n_missing_nta), "\n")
cat("  Blocks missing NTA:", n_missing_nta, "\n")

if (n_missing_nta > 0) {
  missing_tracts <- crosswalk %>%
    filter(is.na(NTA2020)) %>%
    distinct(BoroCT2020)
  cat("  Tracts not in relationship file:\n")
  print(missing_tracts)
}

# =============================================================================
# SECTION 5: SPATIAL JOIN — BLOCKS TO PRECINCTS
# =============================================================================

cat("\nSPATIAL JOIN: BLOCKS → PRECINCTS...\n")
cat(strrep("-", 40), "\n")

precincts_join <- precincts %>%
  select(Precinct) %>%
  st_make_valid()

joined_precincts <- st_join(block_centroids, precincts_join, join = st_within, left = TRUE)

# Handle duplicates
n_dups_pct <- sum(duplicated(joined_precincts$physical_id))
if (n_dups_pct > 0) {
  cat("  WARNING:", n_dups_pct, "duplicate precinct assignments (taking first match)\n")
  joined_precincts <- joined_precincts %>%
    group_by(physical_id) %>%
    slice(1) %>%
    ungroup()
}

n_unmatched_pct <- sum(is.na(joined_precincts$Precinct))
cat("  Matched:", scales::comma(nrow(joined_precincts) - n_unmatched_pct), "\n")
cat("  Unmatched:", n_unmatched_pct, "\n")

# Fallback
if (n_unmatched_pct > 0) {
  cat("  Applying st_nearest_feature fallback...\n")
  unmatched_idx_p <- which(is.na(joined_precincts$Precinct))
  unmatched_pts_p <- block_centroids[block_centroids$physical_id %in%
                                       joined_precincts$physical_id[unmatched_idx_p], ]
  nearest_idx_p <- st_nearest_feature(unmatched_pts_p, precincts_join)
  joined_precincts$Precinct[unmatched_idx_p] <- precincts_join$Precinct[nearest_idx_p]
  cat("  All blocks now assigned to precincts\n")
}

# =============================================================================
# SECTION 6: COMBINE AND VALIDATE
# =============================================================================

cat("\nBUILDING FINAL CROSSWALK...\n")
cat(strrep("-", 40), "\n")

precinct_tbl <- joined_precincts %>%
  st_drop_geometry() %>%
  select(physical_id, Precinct)

crosswalk <- crosswalk %>%
  left_join(precinct_tbl, by = "physical_id")

# --- Validation ---
cat("\n=== CROSSWALK VALIDATION ===\n\n")
cat("Total blocks:", scales::comma(nrow(crosswalk)), "\n")
cat("Unique tracts:", length(unique(crosswalk$BoroCT2020)), "\n")
cat("Unique NTAs:", length(unique(crosswalk$NTA2020)), "\n")
cat("Unique precincts:", length(unique(crosswalk$Precinct)), "\n")
cat("\nNAs:\n")
cat("  BoroCT2020:", sum(is.na(crosswalk$BoroCT2020)), "\n")
cat("  NTA2020:", sum(is.na(crosswalk$NTA2020)), "\n")
cat("  Precinct:", sum(is.na(crosswalk$Precinct)), "\n")

cat("\nBlocks per borough:\n")
crosswalk %>% count(boro) %>% print()

cat("\nNTA types:\n")
crosswalk %>% count(NTAType) %>% print()

cat("\nBlocks per NTA (summary):\n")
crosswalk %>%
  count(NTA2020) %>%
  summarise(
    min = min(n), q25 = quantile(n, 0.25), median = median(n),
    mean = round(mean(n), 1), q75 = quantile(n, 0.75), max = max(n)
  ) %>%
  print()

cat("\nBlocks per tract (summary):\n")
crosswalk %>%
  count(BoroCT2020) %>%
  summarise(
    min = min(n), q25 = quantile(n, 0.25), median = median(n),
    mean = round(mean(n), 1), q75 = quantile(n, 0.75), max = max(n)
  ) %>%
  print()

cat("\nBlocks per precinct (summary):\n")
crosswalk %>%
  count(Precinct) %>%
  summarise(
    min = min(n), q25 = quantile(n, 0.25), median = median(n),
    mean = round(mean(n), 1), q75 = quantile(n, 0.75), max = max(n)
  ) %>%
  print()

# =============================================================================
# SECTION 7: SAVE
# =============================================================================

saveRDS(crosswalk, here("data", "block_crosswalk.rds"))
write_csv(crosswalk, here("data", "block_crosswalk.csv"))

cat("\n")
cat(strrep("=", 70), "\n")
cat("CROSSWALK SAVED\n")
cat("  data/block_crosswalk.rds\n")
cat("  data/block_crosswalk.csv\n")
cat(strrep("=", 70), "\n")
