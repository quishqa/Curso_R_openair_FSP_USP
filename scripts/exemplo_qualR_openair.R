# Neste exemplo queremos saber qual o melhor horário para 
# fazer exercícios no parque Ibirapuera com base às concentrações
# de poluentes.

library(openair)
library(qualR)

# Baixando os dados
ibi_jan24 <- cetesb_retrieve_param(
  username = Sys.getenv("QUALAR_USER"), # Colocar seu usuário
  password = Sys.getenv("QUALAR_PASS"), # Colocar sua senha
  parameters = c("O3", "MP2.5", "NO", "NO2", "CO"),
  aqs_code = "Pinheiros",
  start_date = "01/01/2024",
  end_date = "30/01/2024"
)

# Calculando a média horária
ibi_hour <- aggregate(
  ibi_jan24[c("o3", "pm25", "co", "no", "no2")],
  format(ibi_jan24["date"], "%H"),
  mean,
  na.rm = T
)

# Trocando a coluna data com dados POSIXct
ibi_hour$date <- seq(as.POSIXct("2024-01-01 00:00"),
                     length.out = 24,
                     by = "hour")

# Vamos fazer a figura
pol_ibi <- timeVariation(ibi_hour, pol = c("o3", "pm25", "co", "no", "no2"),
                         normalise = TRUE)
plot(pol_ibi, subset = "hour")

# Conclusão é melhor fazer esporte às 6 am. :)