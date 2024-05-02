# Turnover_BBS_public

Public repository of code and processed data to support the MS 'Slower but deeper community change: intrinsic dynamics regulate anthropogenic impacts on species temporal turnover'.

Code is mostly written for R 4.2.0. but some was run under 4.3.0. Most of the R markdown .html files include sessionInfo() readout for the versions of other packages where necessary. 

# Contents:
## RMarkdowns/

Final R Markdown files (and knit .html outputs). In principle should document the entire analysis from start to finish. Later stages depend on previous stages. However, outputs from earlier stages are included in the repository so there shouldn't be a need to go all the way back to the start. 

Stage 1: Data Assimilation and Cleaning

 - `BirdDataCleaning.Rmd`
 - `GIS GPP.Rmd`
 - `GIS Human.Rmd`
 - `GIS ebird.Rmd`
 
Stage 2: Collating Data and generating summaries

- `Preparing Predictor Data and Maps.Rmd`

Stage 3: Fitting Models

- `Similarity Decay Analysis.Rmd`
- `Similarity Decay Analysis_NestedTurnover.Rmd` (repeats the similarity decay analyses for the alternative metric)
- `Richness Trends Analysis.Rmd`
- `Species Accumulation Analysis.Rmd`

Stage 4: Inferring Curve Parameters

- `Inferring Curve Parameters from Hierarchical Model.Rmd`

Stage 5 - Pulling together results into publication form

- `SimilarityDecayExamples.Rmd`
- `Final Analysis Simplified.Rmd` (Makes most of the figures in the paper)
- 

## Data/

Storage for both computed data summaries and some of the raw data.

- `2020Release_Nor/`: lightly processed observation data from the North American Breeding bird survey, 2020 release. https://www.pwrc.usgs.gov/BBS/RawData/ **NOTE large files have been zipped - unzip before use!**
  - `North American Breeding Bird Survey Dataset (1966-2019).xml` Metadata from the original source
  - `Species_formatted.csv`  Look up table for species names and codes
  - `routes.csv` Basic data about each route
  - `weather.csv` Detailed data about the quality and weather of each survey
- `Lower48_routes/`: Shape Files and metadata for the transect routes (https://purl.stanford.edu/vy474dv5024)
- `gpp/` Folder containing outputs from Google earth engine of the CV and Mean of Gross Primary productivity. Also includes metadata for raw data. 

### Other files:

- `All_Average_Curves.csv` : Average similarity decay data for curve fitting. y= mean Sorensen similarity, x = year Difference. 
- `All_Average_Curves_3.csv` : Average similarity decay data for curve fitting. y= mean Simpson similarity, x = year Difference.
- `BCR_Lookup.csv` : Table of full names of the bird Conservation regions
- `BCRsToFit.csv` : Table of the number of transects in each BCR (used in HPC fitting)
- `Consol_SpeciesNames.csv` : Table to consolidated changes to species names through time
- `InRange_all_df_collapsed.csv` Matrix of Route number by bird species (eBird 6-code), with presence or absence by intersection with transect route.  
- `ProductivityTransects.csv`
- `RTENO_lookup.csv` Table to convert between Transect ID,, RTENO and RTENAME. Also included Human Modification Index
- `STATS.csv` Full Table of Statistics related to each Transect. 
  - `TransectID`      joining column (pasting together the country code, state code then route number,  is unique for each transect)
  - `N_Surveys`     number of years with data
  - `N_Species`      total number of different species seen across the time series at the transect
  - `Year_span`                difference between first and last year
  - `Average_Richness`   mean number of species seen across years
  - `N_Permanent`    number of species seen in every year with data
  - `StartYear`        first year with data
  - `RTENO`      transect ID code used by some other data sources
  - `RTENAME`      description of transect (NB variable across data sources, and not the same as RouteName!)
  - `Av_HMindex`   Map derived human modification index across transect
  - `CountryNum` 
  - `StateNum`
  - `Route`
  - `RouteName`
  - `Active`
  - `Latitude`
  - `Longitude`
  - `Stratum`
  - `BCR`      bird conservation region (essentially a broad habitat type)
  - `RouteTypeID`   
  - `RouteTypeDetailID`
  - `CV_gpp`         year-year coefficient of variation in satellite derived primary productivity along route (2000-2020)
  - `MEAN_gpp`   Mean satellite derived primary productivity along route (2000-2020)
  - `RouteNumber`  
  - `Gamma_Div_Ebird`   total number of focal species whose ranges overlap the transect
 
- `STATS_select.csv`  Smaller version of main stats table
- `STATS_select_SCALED.csv` Smaller version of main stats table, but with key predictors rescaled to be closer to 0-1.
- `TransectStats.csv`  Output of analyses to calculate basic summaries of each transect bird data
- `Transect_Average_gHM.csv`  Output of analyses to calculate average Human Modification Index
- `eBird_Taxonomy_v2021.csv`   eBird Taxonomy table, used to align BBS and eBird naming conventions.


## MS_figs/
Images for eventual inclusion in MS

## ModelFits/

Mostly used to store STAN model fits in folders names after the run. Each BCR is a separate fit and model object.

## ModelSummaries/ 

Storage of data frames that save the models fits. Probably easiest to search for how they are made, as the naming is a bit erratic

## Scripts/
R Scripts run on the HPC. Naming is rather arbitrary. Also includes an example of the STAN scripts generated by brms used for the curve model fitting. 








