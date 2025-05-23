source(here::here("R","qaqc.R"))
source(here::here("R","download_new_data.R"))
source(here::here("R","calculate_flux.R"))

#' generate_L1_fluxes
#'
#' @description
#' This is the master file to load data from dropbox, calculate fluxes, and QAQC the data
#'
#' @param reprocess whether to reprocess files we have already processed
#'
#' @return target data based on all dropbox CH4 flux data
#' @export
#'
#' @examples
generate_target <- function(reprocess = F){
  #First - check for new data and download locally
  lgr <- download_new_data(lgr_folder = here::here("Raw_data","dropbox_downloads"))
  
  #Second- calculate fluxes for new data, generating the L0 file
  if(reprocess){
    L0 <- calculate_flux(start_date = "2024-01-01", 
                         end_date = Sys.Date()+1,
                         reprocess = reprocess)
  } else {
    L0 <- calculate_flux()
  }
  
  #Third- QAQC, generating the L1 file
  data <- qaqc(here::here("processed_data","L0.csv"))
  
  return(data)
}

target <- generate_target(reprocess = F)
