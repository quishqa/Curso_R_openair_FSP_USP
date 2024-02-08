rm(list = ls())

library(openair)

dado <- read.csv("C:/Users/prof/Downloads/dado_horario.csv", header = TRUE)

# Limpar dados acima de 360 e substituir por NA
dado$wd<- replace(dado$wd, dado$wd > 360, NA)

#Para transformar dados character em DATA
dado$date <- as.POSIXct(
  strptime(dado$date, 
           format= "%Y-%m-%d %H:%M:%S"))

#Criou coluna de hora p/ limpar dados de calibração
dado["hour"] <- format(dado$date, "%H")

#Transformar dados integer em numérico (multiplas colunas)
library(dplyr) #necessario abrir livraria
dado <- dado %>% mutate_if(is.integer, as.numeric)


#Replace (dados negativos, dados de calibração)
#Quando a coluna hora esta em character
dado$o3 <- replace(dado$o3, dado$hour == "06", NA)

#Quando a coluna hora esta em numerico
dado$o3 <- replace(dado$o3, dado$hour == 6, NA)

#Retirar dados negativos ou iguais a zero (<=)
dado$o3 <- replace(dado$o3, dado$o3 <= 0, NA)


#Direção e velocidade do vento
windRose(dado)

#Dados de direção e velocidade anual
windRose(dado, 
         type = "year",
         layout = c(3,1))

#Para trasformar o estilo do marcador de velocidade
windRose(dado,
         paddle = FALSE)

#mudando o local da escala
windRose(dado,
         key.position = "top") #left, bottom, right

#Título para a escala de velocidade
windRose(dado,
         key.header = "Velocidade")

#Para limpar as informações
windRose(dado,
          annotate = TRUE)#TRUE (default); FALSE


#Função que combina dados de direção com poluentes
pollutionRose(dado, 
              pollutant = "no2")

# Formas de visulizar a rosa de poluição
pollutionRose(dado,
              pollutant = "no2",
              type = "season") #season, year

#Corrigindo a figura pro Hemisfério Sul
pollutionRose(dado,
              pollutant = "no2",
              type = "season",
              hemisphere = "southern")


# percentileRose
percentileRose(dado,
               pollutant = "o3")

#Usando o método CPF (Função de Probabilidade Condicional)
percentileRose(dado,
              pollutant = "o3",
              percentil = 75,
              method = "cpf",
              smooth = TRUE)#suavizar as linhas da figura

#polarPlot

polarPlot(dado, 
          pollutant = "pm25")

#alterando o local da escala
polarPlot(dado,
          pollutant= "pm25",
          key.position = "bottom")

polarPlot(dado,
          pollutant = "pm25",
          type = "weekday",#season, year, weekday
          layout = c(3,3)) #mudar o layout da figura

#polarAnnulus
polarAnnulus(dado,
             pollutant= "pm25")

#preenchendo os espaços vazios
polarAnnulus(dado,
             pollutant = "pm25",
             exclude.missing = FALSE)

polarAnnulus(dado,
             pollutant = "o3",
             exclude.missing = FALSE)



#gráfico de dispersão
scatterPlot(dado,
            x = "pm25", y= "o3",
            linear = TRUE) #para aparecer a formula 

# observando de acordo com a direção do vento
scatterPlot(dado,
            x= "pm25", y = "o3",
            type = "wd") 

# Grafico de correlação
corPlot(dado)

corPlot(dado,
        pollutants = c("o3", "pm25", "no2"),
        dendrogram = TRUE)
