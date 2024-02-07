# Este é um exemplo para baixar dados de várias estações usando qualR
# Vamos baixar dados de O3 e PM2.5 de um mes de Janeiro de 2024
# para Pinheiros, Ibirapuera, USP, Pico do Jaraguá
library(qualR)

start_date <- "01/01/2024"
end_date <- "31/01/2024"
aqs <- c(99, 83, 95, 284)
params <- c("O3", "MP2.5")


dados <- lapply(
  aqs,
  cetesb_retrieve_param,
  username = Sys.getenv("QUALAR_USER"),
  password = Sys.getenv("QUALAR_PASS"),
  parameters = params,
  start_date = start_date,
  end_date = end_date
)


# dados é uma lista, vamos juntar tudo num único data frame para 
# trabalhar no openair
dados_df <- do.call(rbind, dados)

# vamos salvar no formato rds.
saveRDS(dados_df, file = "data/o3_pm25_pin_ibi_usp_pico.rds")

# ou como csv
write.table(dados_df, file = "data/o3_pm25_pin_ibi_usp_pico.csv", row.names = F,
            sep = ",")

## Construindo o shapefile de RMSP
install.packages("geobr")
library(geobr)
library(sf)
am <- read_metro_area(year = 2018)
rmsp <- subset(am, subset = name_metro == "RM São Paulo")


## Trocando a projeção
rmsp_ll <- st_transform(rmsp, crs =  "+init=epsg:4326")
plot(rmsp_ll$geom)
box()
axis(1)
axis(2)

## salvando o shapefile para prática
write_sf(rmsp_ll, "data/rmsp_shp/rmsp_ll.shp")

# Calcular média das aqs
library(openair)
timeAverage(dados_df, avg.time = "month")

# Calculando as médias
aqs_o3_mean <- aggregate(dados_df[c("o3", "pm25")], 
                         dados_df["aqs"],
                         mean,
                         na.rm = TRUE)

# Colocando latitude e longitude no noso dataframe
lats_lons <- cetesb_aqs[cetesb_aqs$code %in% aqs, ]
aqs_o3_mean$lon <- lats_lons$lon
aqs_o3_mean$lat <- lats_lons$lat


library(rgdal) # To read shapefile
library(broom) # To transform shapefile to data frame
library(ggplot2) # To make the map

# Reading the shapefile
rmsp <- readOGR("data/rmsp_shp/rmsp_ll.shp")

# From shp to df
rmsp_df <- tidy(rmsp, data = "name_mn") # Very important!!! Check with names(rmsp)

# Making the plot

ggplot() +
  geom_path(data =rmsp_df, aes(x = long, y = lat, group = group)) +
  geom_point(data = aqs_o3_mean, aes(x = lon, y = lat, color = o3), size = 4) +
  scale_color_viridis_c(option = "inferno", direction = -1,
                        name=expression("(" * mu * "g m" ^-3 * ")")) +  # direction = -1 to get darker color with higher concentration
  theme(axis.text = element_blank(), axis.ticks = element_blank(),
        panel.background = element_blank(),plot.background = element_blank()) + # Remove grid and remove that grey background
  coord_quickmap() +  #  Scale X and Y based on lon and lat
  labs(title = "Ozone concentrationm Map",
       subtitle = "Sao Paulo Metropolitan Area",
       x = "", y = "")
