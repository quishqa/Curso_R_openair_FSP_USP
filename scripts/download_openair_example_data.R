# Downloading sample data for openair presentation

library(qualR)
library(openair)

start <- "01/01/2019"
end <- "31/12/2021"
params <- c("VV", "DV", "MP2.5", "O3", "NO2", "NO")

pin <- cetesb_retrieve_param(username = Sys.getenv("QUALAR_USER"),
                             password = Sys.getenv("QUALAR_PASS"),
                             parameters = params,
                             aqs_code = "Pinheiros",
                             start_date = start,
                             end_date = end)

pin <- selectByDate(pin, year = 2019:2021)
saveRDS(pin, file="data/pin_openair_ex.rds")
