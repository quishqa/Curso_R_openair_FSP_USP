# Revisão da aula 1
rm(list = ls()) # Apagar tudo 

## R é uma calculadora
5^2 # Ctrl + Enter
(2024 - 1988)

## Definir variaveis <- (Alt + -)
este_ano <- 2024 # numeric
ano_chino <- 'dragão' # character " '

# funções
class(este_ano)
class(ano_chino)
length(ano_chino)

# vetores c()
directions <- c("N", "S", "W", "E")
direction_graus <- c(0, 180, 270, 90)

# Operações para todos os elementos do
# vetor
tolower(directions)
direction_graus * pi / 180
length(directions)

# seq
seq(1988, 2024)
seq(0, 1000, 3)

# Criar numeros aleatórios
# runif(quantos numero, min, max)
runif(36, 10, 50)

# data frames 
anos <- seq(2000, 2024)
o3 <- runif(length(anos), 0, 160)

o3_sp <- data.frame(anos, o3)
o3_sp$anos
o3_sp$o3

# POdemos usar o $ para definir uma nova coluna
o3_sp$o3_ppb <- o3_sp$o3 * 2.0
o3_sp$sqa <- "Pinheiros"

# Funções importantes
ncol(o3_sp)
nrow(o3_sp)
str(o3_sp)
head(o3_sp, 3)
tail(o3_sp, 5)

# Operações com NA
ur <- c(100, 98, 96, 80, NA, NA)
mean(ur)
mean(ur, na.rm = TRUE)

# Operações NA
mean(o3_sp$o3, na.rm = TRUE)
min(o3_sp$o3, na.rm = TRUE)
max(o3_sp$o3, na.rm = TRUE)
median(o3_sp$o3, na.rm = TRUE)
sd(o3_sp$o3, na.rm = TRUE)

summary(o3_sp)

# Trazer uma tabela da internet
# read.table()
rio <- read.table(file.choose(),
                  sep = "\t", # separado
                  dec = ".", # decimal
                  header = TRUE) # se tem nome as colunas
str(rio)
mean(rio$tmpf, na.rm = TRUE)

# Calcular dados faltantes do dataframe.
365 * 24 - nrow(rio)

# Instalar pacotes
install.packages("readxl")
install.packages("openair")

#Quando não funciona install.package(nome_função) Instalar desde a fonte
# Baixar o pacote
install.packages(
  file.choose(),
  repos = NULL,
  type = "source")

# Ler arquivos do Excel no R
# intalamos o pacote readxl
# install.package("readxl") # Só uma vez
library(readxl) # chamar o pacote
# file.choose() ou
# Copiar o CAMINHO do arquivo
# OBS: No windows \ tem que troca /
who <- read_excel(
  file.choose(),
  sheet = 2
)

who <- read_excel("C:/Users/prof/Downloads/who_aap_2021_v9_11august2022.xlsx", sheet = 2)

who_br <- subset(
  who,
  subset = `WHO Country Name` == "Brazil" # Subset selecionar linhas
)

# Quantas cidades consideradas 
unique(who_br$`City or Locality`)
length(
  unique(who_br$`City or Locality`)
  )

# Selecionar Colunas e filas
oms_sp <- subset(
  who,
  subset = `City or Locality` == "Sao Paulo",
  select = c("City or Locality", # select colunas
             "Measurement Year",
             "PM2.5 (μg/m3)",
             "NO2 (μg/m3)")
)
# OBS: Nome das colunas tem que ser bem escritas!

# Trocar nome das colunas para melhor manipulação
names(oms_sp) <- c("cidade", "ano", "pm25", "no2")

# Quantos anos o padrão da OMS NO2 foi superado (40)?
no2_sp <- subset(oms_sp, subset = no2 > 40)

# Agora vamos trabalhar com qualR! :)
library(qualR)

# Saber as estações
cetesb_aqs

# Saber que poluentes ou parâmetros
cetesb_param

meus_pol <- c("O3", "NO", "NO2")
# Vou baixar dados da primeira seman de jan. Pinehiros
# cetesb_retrieve_param
pin <- cetesb_retrieve_param(
  username = "myuser@gmail.com",
  password = "mypassword",
  parameters = meus_pol, # Ozônio
  aqs_code = 99, # Pinheiros,
  start_date = "01/01/2024", # dd/mm/yyyy
  end_date = "07/01/2024"
  )

# Todos os poluentes
pin_pol <- cetesb_retrieve_pol(
  username = "myuser@gmail.com",
  password = "mypassword",
  aqs_code = "Pinheiros",
  start_date = "01/01/2024",
  end_date = "03/01/2024"
)

# Todos os meteorologia
pin_met <- cetesb_retrieve_met(
  username = "myuser@gmail.com",
  password = "mypassword",
  aqs_code = "Pinheiros",
  start_date = "01/01/2024",
  end_date = "03/01/2024"  
)

# Para baixar tudo
pin_all <- cetesb_retrieve_met_pol(
  username = "myuser@gmail.com",
  password = "mypassword",
  aqs_code = "Pinheiros",
  start_date = "01/01/2024",
  end_date = "02/01/2024"   
)

# Eu quero usar Excel :(
pin_csv <- cetesb_retrieve_param(
  username = "myuser@gmail.com",
  password = "mypassword",
  parameters = c("O3", "NOx"),
  aqs_code = "Pinheiros",
  start_date = "01/01/2024",
  end_date = "03/01/2024",
  to_csv = TRUE
)

# Muitas estações
aqs <- c(83, 99, 95)
params <- c("O3")
user <- "myuser@gmail.com"
pass <- "mypassword"
start <- "01/01/2024"
end <- "03/01/2024"

# Baixar muitos dados.
aqs_o3 <- lapply(
  aqs, 
  cetesb_retrieve_param,
  username = user,
  password = pass,
  parameters = params,
  start_date = start,
  end_date = end)

aqs_o3_df <- do.call(rbind, aqs_o3)

# Selecionar elementos listas
pin1 <- aqs_o3[[1]]
ibi1 <- aqs_o3[[2]]
usp1 <- aqs_o3[[3]]

# Vamos comparar
plot(pin1$date, pin1$o3, t = "l",
     col = "blue", xlab="Data",
     ylab = "O3 [ug/m3]",
     ylim = c(0, 170),
     main = "Concentração de O3 em SP")
lines(ibi1$date, ibi1$o3, col = "red")
lines(usp1$date, usp1$o3, col ="green")
legend("topleft", col = c("blue", "red", "green"), legend=c("PIN", "IBI", "USP"), lty = 1)
