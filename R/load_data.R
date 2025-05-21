load_data <- function(file){
  data_raw <- read_csv(file, col_types = cols(.default = "c"), skip = 1)
  
  data_small <- data_raw %>%
    rename(CH4d_ppb = CH4,
           CO2d_ppm = CO2,
           N2Od_ppb = N20_7820,
           MIU_VALVE = Fluxing_Chamber) %>%
    filter(!CH4d_ppb == "Smp") %>%
    mutate(CH4d_ppm = as.numeric(CH4d_ppb)/1000) %>%
    select(TIMESTAMP, CH4d_ppm, CO2d_ppm, N2Od_ppb, MIU_VALVE, Manifold_Timer, Flux_Status)
  
  return(data_small)
}
