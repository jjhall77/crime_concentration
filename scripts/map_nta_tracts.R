library(sf)
library(leaflet)
library(htmlwidgets)
library(here)

# --- Load and transform to WGS84 for leaflet ---
tracts <- st_read(here("data/nyct2020_25d/nyct2020.shp"), quiet = TRUE) |>
  st_transform(4326)

ntas <- st_read(here("data/nynta2020_25d/nynta2020.shp"), quiet = TRUE) |>
  st_transform(4326)

# --- Count tracts per NTA ---
tract_counts <- as.data.frame(tracts) |>
  dplyr::count(NTA2020, name = "n_tracts")

ntas <- merge(ntas, tract_counts, by = "NTA2020", all.x = TRUE)
ntas$n_tracts[is.na(ntas$n_tracts)] <- 0

# --- Build map ---
map <- leaflet() |>
  addProviderTiles("CartoDB.Positron") |>

  # Census tracts — thin gray borders
  addPolygons(
    data = tracts,
    group = "Census Tracts",
    weight = 1,
    color = "#888888",
    fillColor = "#cccccc",
    fillOpacity = 0.1,
    popup = ~paste0(
      "<b>Tract ", CTLabel, "</b><br>",
      "Borough: ", BoroName, "<br>",
      "NTA: ", NTAName, " (", NTA2020, ")<br>",
      "GEOID: ", GEOID
    )
  ) |>

  # NTAs — thicker colored borders, no fill
  addPolygons(
    data = ntas,
    group = "NTAs",
    weight = 3,
    color = "#e63946",
    fillColor = "#e63946",
    fillOpacity = 0.05,
    popup = ~paste0(
      "<b>", NTAName, "</b><br>",
      "Code: ", NTA2020, "<br>",
      "Borough: ", BoroName, "<br>",
      "Tracts: ", n_tracts, "<br>",
      "Type: ", NTAType
    )
  ) |>

  # Layer control
 addLayersControl(
    overlayGroups = c("Census Tracts", "NTAs"),
    options = layersControlOptions(collapsed = FALSE)
  )

# --- Save ---
saveWidget(map, here("output/map_nta_tracts.html"), selfcontained = TRUE)
cat("Saved to output/map_nta_tracts.html\n")
