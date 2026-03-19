# Crime Concentration in NYC

## Project Purpose

Test the "law of crime concentration" (Weisburd 2015) and related assumptions from the crime concentration literature using NYC data. This project informs thesis writing and may become a paper.

## Design Principles

- **Publication-quality plots.** Simple, elegant, conversational but polished. Premium on simplicity.
- **Test literature assumptions empirically.** Don't just replicate — probe where the law holds, where it breaks, and what NYC-specific dynamics emerge.
- **R project.** Uses tidyverse, sf, janitor. EPSG:2263 for spatial data.

## Data

All in `data/`. Key datasets:
- NYPD Complaint Data (historic + YTD) — main crime incidents
- NYPD Calls for Service (historic + YTD) — disorder/narcotics subsets
- NYPD Shootings
- 311 Service Requests
- Shots fired
- Spatial layers (EPSG:2263): census blocks, tracts, NTAs, precincts, intersection nodes, physical blocks

## Scripts

- `scripts/00-load_data.R` — Loads all data, initial exploration, exports offense code lookup

## Literature

47 papers reviewed. Key files:
- `literature/crime_concentration_notes.md` — Master notes (all 47 papers)
- `literature/crime_concentration_synthesis.md` — Thematic synthesis and debates
- `literature/crime_concentration_lit_review_OUTLINE.md` — Lit review chapter outline
- `literature/BIBLIOGRAPHY_AND_GAP_ANALYSIS.md` — Bibliography and gap tracking

## Key Research Questions

1. Does the 4-6% bandwidth hold for NYC street segments/blocks?
2. How does concentration vary by crime type and spatial unit?
3. Temporal stability vs. mobility of hot spots
4. Micro-place vs. neighborhood interaction effects
5. Sparse data / measurement artifact assessment (Chalfin et al. 2021)
6. 311/CFS data validity concerns (Taylor et al. 2024)
