# Este projeto é para calcular
# O melhor horário para fazer esporte
# no Ibirapuera.
library(qualR)
library(openair)

# Baixar os dados
ibi_jan24 <- cetesb_retrieve_pol(
  username = "examplequalr@gmail.com",
  password = "06660666",
  aqs_code = "Ibirapuera",
  start_date = "01/01/2024",
  end_date = "30/01/2024",
  to_csv = TRUE
)

# Plotando variação horária
temp_var_ibi <- timeVariation(ibi_jan24,
              pollutant = c("o3","no2", "co", "pm25"), normalise = TRUE )

# Variação horária
png("pol_var_ibi.png")
plot(temp_var_ibi, subset = "hour")
dev.off()

# Conclusão: Vou acordar cedo e fazer esporte às 5-6 am.

# Só tenho tempo no final de semana
ibi_jan24_weekend <- selectByDate(
  ibi_jan24, 
  day = "weekend"
)


weekend_ibi <- timeVariation(ibi_jan24_weekend,
              pollutant = c("o3","no2", "co", "pm25"), normalise = TRUE)

png("pol_weekend_ibi.png")
plot(weekend_ibi, subset = "hour")
dev.off()

# Conclusão: No final de semana posso dormir mais uma hora.