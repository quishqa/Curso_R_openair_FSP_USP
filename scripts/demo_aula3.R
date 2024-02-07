rm(list = ls())
?openair::summaryPlot
library(openair)

dado <- read.csv("C:/Users/prof/Downloads/dado_horario.csv", header = TRUE)

dado$wd<- replace(dado$wd, dado$wd > 360, NA)

dado$date <- as.POSIXct(
  strptime(dado$date, 
           format= "%Y-%m-%d %H:%M:%S"))

library(dplyr)
dado <- dado %>% mutate_if(is.integer, as.numeric)

dado["hour"] <- format(dado$date, "%H")

#fazendo medias diarias
diario <- timeAverage(dado, avg.time = "day")

#selecionando um periodo
periodo <- selectByDate(dado, 
                        year = 2020, 
                        month = 6:8,
                        hour = 8:18)
#Replace (dados negativos, dados de calibração)
dado$o3 <- replace(dado$o3, dado$hour == "06", NA)
dado$o3 <- replace(dado$o3, dado$o3 <= 0, NA)


write.csv(diario, "C:/Users/prof/Downloads/dado.csv",row.names = FALSE)

# Funções do openair
#1º summaryPlot
setwd("C:/Users/prof/Downloads")
png("summaryplot.png", width = 9*300, height = 5*300, res = 300)
summaryPlot(dado)
dev.off()

setwd("C:/Users/prof/Downloads")
png("summaryplot_modificado.png", width = 9*300, height = 5*300, res = 300)
summaryPlot(dado[,c(1,4,5,6,7)],
            avg.time = "day",
            period = "months",
            print.datacap = FALSE,http://127.0.0.1:25197/graphics/plot_zoom_png?width=1280&height=984
            col.mis = "black",
            col.hist = "blue",
            col.data = "blue")
dev.off()



timePlot(dado, 
         pollutant = c("o3", "no2", "pm25"),
         y.relation = "free",
         date.format = "%d-%Y",
         avg.time = "month",
         windflow = list(scale=0.05, lwd = 2, col = "gray"))

timePlot(selectByDate(dado, year = "2021"),
         pollutant = c("o3", "no2", "pm25"),
         y.relation = "free")


timePlot(selectByDate(dado, 
         year = "2021", month = c("jun", "jul", "ago")),
         pollutant = c("pm25"),
         y.relation = "free",
         avg.time = "day",
         lwd = 2,
         col = "black",
         ylab = "PM25 (ug m-3)",
         ref.y = list(h = 15, lty = 5, col = ("red")),
         name.pol = c("PM25 (ug m-3)"))



calendarPlot(selectByDate(dado, 
             year = "2021", month = c("jun", "jul", "ago")),
             pollutant = "pm25",
             layout = c(3,1),
             annotate = "value",
             limits = c(0,35),
             key.footer = "PM2.5",
             lim = 15,
             cols = c("Purples"),
             col.lim = c("black", "orange"),
             main = "Estação Pinheiros")



timeVariation(dado, pollutant = c("o3"))

timeVariation(selectByDate(dado,
                      year = "2021", 
                      month = c("jun", "jul", "ago")),
                      pollutant = c("o3"),
                      group = "month",
              hemisphere = "southern")

timeVariation(dado, pollutant = c("o3"),
              group = "month")




tv <- splitByDate(dado, dates = "01/01/2021",
              labels = c("Ano 2020", "Ano 2021"))

hour <- timeVariation(tv, pollutant = c("no2"),
            ylab = "NO2 (ug m-3)",
            group = "split.by",
            cols = c("blue", "red"),
          xlab = c("Hora", "Hora", "Mês", "Semana"))

plot(hour, subset = "day.hour")

#day, month, day.hour, hour

###########################################
# usando Cbind e Rbind
anos <- seq(2000, 2022)
o3 <- runif(length(anos), 0, 160)
o3_sp <- data.frame(anos, o3)

no2 <-runif(length(anos), 0, 160)
no2_sp <- data.frame(anos, no2)

sp <- cbind (o3_sp, no2_sp)


anos <- seq (2023,2024)
o3 <-runif (length(anos), 0, 160)
o3_new <- data.frame(anos, o3)

sp_new <- rbind(o3_sp, o3_new)
############################################





