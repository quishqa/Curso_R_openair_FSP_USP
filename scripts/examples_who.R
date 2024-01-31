# Examples using WHO dataset 2022
library(readxl)

# Read file
who <- read_excel('data/who_aap_2021_v9_11august2022.xlsx',
                  sheet = 2)

# Subset for Brazil
who_br <- subset(who,
                 subset = `WHO Country Name` == "Brazil" ,
                 select = c("City or Locality",
                            "Measurement Year", 
                            "PM2.5 (μg/m3)",
                            "PM10 (μg/m3)",
                            "NO2 (μg/m3)" ))

# Subset for Sao Paulo

who_sp <-  subset(who,
                  subset = `City or Locality` == "Sao Paulo" ,
                  select = c("Measurement Year", 
                             "PM2.5 (μg/m3)",
                             "PM10 (μg/m3)",
                             "NO2 (μg/m3)" ))

# Cities over NO2 aqs
who_19<- subset(who, subset = `Measurement Year` == 2019)
who_no2_19 <- subset(who_19,
                     subset = `NO2 (μg/m3)` >= 40)