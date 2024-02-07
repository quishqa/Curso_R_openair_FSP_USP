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