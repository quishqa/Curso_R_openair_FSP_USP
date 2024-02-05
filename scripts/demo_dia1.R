# Declaramos variavéis <-
meu_nome <- "Mario"

# O tipo de objeto
class(meu_nome)

# obejtos numéricos
who_o3 <- 140 # ug/m3 (8 horas)

# VETOR (Uma coleção de elementos, )
# Un vetor é definido usando c()
gee <- c("H2O", "Co2", "CH4", "N2O")
## numero de elementos
length(gee)

gee_mm <- c(2 * 1 + 16, 
            12 + 2 * 16,
            12 + 4 * 1, 
            2 * 14 + 16)

# média da mm dos gee
mean(gee_mm)

# Um vetor só pode ter um tipo de obejto
v1 <- c(1, 2, 3, "4")

# sequência de dados
# seq(valor_ini,  valor_final, intervarlo)
num_1al100 <- seq(1, 100)
par_0al100 <- seq(0, 100, 2)

# :
num_10_200 <- 10:200 # integer
num_0_1 <- seq(0, 1, 0.1)
lista_num <- seq(10, 100, length.out = 20)

# rep() repetir
rep(10, 100)

# Problema criar um vetor com as horas de todo um ano.
horas <- seq(0, 23)
horas_ano <- rep(horas, 366)
length(horas_ano)

# Selecionar elementos usamos nome_vetor[indice]

gee <- c("h2o", "co2", "ch4", "n2o")
gee[1] # selecionamos primeiro
gee[1:2] # selecionamos primeiro e segundo
gee[c(1, 4)] # selecionamos primeiro e ultimos

# Vetorização/Vectorization/ Element-wise operation
gee <- toupper(gee)
gee

tempC <- c(30, 31, 32, 35.5, 25)
tempK <- tempC + 273.15

# Exercicio 1
pol_sp <- c("mp10", "mp25", "so2", "no2", "o3")
pol_amostra <- c(24, 24, 24, 1, 8)
pol_pqa <- c(100, 50, 40, 240, 130)

# Forçar transformação numérica
vet <- c(1, 2, 4, "")
vet <- as.numeric(vet)

# Criar numeros aletórios runif
# runif(n, 10, 20)
ale <- runif(20, 10, 100)

# Abreviações
aqs <- c("Pinheiros", "Ibirapuera", 
         "Cidade. Universataria")
abr <- abbreviate(aqs, 4)

# Data Frames
ar <- c("N2", "O2", "Ar", "Co2")
per <- c(78, 20.9, 0.9, 0.04)
pm <- c(14 * 2, 16 * 2, 39.9, 12 + 2 * 16)

ar_df <- data.frame(ar, per, pm)
nrow(ar_df) # numero de linhas
ncol(ar_df) # numero de colunas
str(ar_df) # Examinar data frames

# Selecinar colunas df$nome_coluna -> vetor
ar_df$ar
ar_df$pm

# Selecionar colunas df[Nome coluna ] -> data.frame
ar_df["pm"]
ar_df[c("pm", "ar")]
ar_df[2]

# Operações
sum(ar_df$per)
100 - sum(ar_df$per)

# Adicionar uma coluna
ar_df$nome <- c("nitrogênio",
                "Oxigênio",
                "Argonio",
                "Dioxido de carbono")

mass_ar <- sum(ar_df$per / 100 * ar_df$pm)

head(ar_df, 2)
tail(ar_df, 2)

# Vamor ler um data frame com os dados do aeroporto de Guarulhos.
# Procurar no google METAR data Iowa
# read.table

gru <- read.table(file.choose(),
                  sep = ",", # separação das colunas
                  header = TRUE, # se as colunas nome
                  dec = ".") # Separador decimal
nrow(gru)
ncol(gru)
str(gru)

# Trocar para Celcius
gru$tc <- (gru$tmpf - 32) * 5. / 9
gru$ws <- gru$sknt * 0.51

summary(gru)

# Média da temperatura
mean(gru$tc)
# Mediana temperatura
median(gru$tc)
# Desvio padrão
sd(gru$tc)
# Temperatura minima
min(gru$tc)
# Temperatura máxima
max(gru$tc)

plot(gru$tc)
boxplot(gru$tc)
hist(gru$tc)
hist(gru$ws)

# Atenção
# Dado faltante gera problemas nas operações

tc <- c(30, 40, 38, NA)
mean(tc, na.rm = TRUE)
min(tc, na.rm = TRUE)

# Correlação
cor(gru$tc, gru$relh)
cor(gru$tc, gru$relh, 
    method = "spearman")
plot(gru$tc, gru$relh)

plot(gru$tc,
     t = "l",
     col = "orange", 
     xlab = "Horas",
     ylab = "Temperatura (ºC)",
     main = "Aeroporto de Guarulhos")
abline(h=mean(gru$tc),col = "red", lwd = 5)

# falar para r que vc tem dado tipo data: POSIXct
# Só funciona data esta em ano/mes/dia hora:min
gru$date <- as.POSIXct(gru$valid)


plot(gru$date, gru$tc,
     t = "l",
     col = "orange", 
     xlab = "Horas",
     ylab = "Temperatura (ºC)",
     main = "Aeroporto de Guarulhos")

tc_mensal <- aggregate(
  gru["tc"],
  format(gru["date"], "%m"),
  mean,
  na.rm = TRUE
)

tc_hora <- aggregate(
  gru["tc"],
  format(gru["date"], "%H"),
  mean,
  na.rm = TRUE
)

plot(tc_hora, t = "l")

wrong_format <- "01-01-2024_0000"
right_format <- as.POSIXct(
  strptime(wrong_format, 
           format="%m-%d-%Y_%H%M")
)