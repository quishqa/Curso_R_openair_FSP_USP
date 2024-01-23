---
marp: true
class: invert
math: mathjack
style: |
---

# Introdução à Linguagem de Programação em R para tratamento de dados da poluição do ar: o pacote **`openair`** :sunny: :earth_americas: :factory: 

Mario Gavidia-Calderón
Rafaela Squizzato
Thiago Nogueira

---
## `openair`

* Pacote disenhado para o tratamento de dados de poluição do ar.
* [Carslaw & Ropkins (2012)](https://www.sciencedirect.com/science/article/pii/S1364815211002064?via%3Dihub)

---
## Instalar `openair`

```r
install.packages('openair') # ação necessária 1 única vez
```

---
## Desinstalar `openair`

```r
remove.packages('openair')
```

---
## Pacote `openair`
- Uma vez instalado, o pacote precisa ser carregado. Utiliza-se então o comando `library()`:

```R
library(openair)
library(readxl) # para ler arquivos do Excel (*.xls)
```
---
## Pacote `openair`: Funções

* As funções presentes no pacote `openair` são dedicadas à análise de dados de poluição atmosférica.
* As funções usan como padrão uma forma de análise mais simples e rápida, proém anaálises mais detalhadas também são possíveis.
* Entre as principais funções temos: `summaryPlot`, `timePlot`, `calendarPlot`, `timeVariation`, `windRose`, `percentilRose`, `polarPlot`, `polarAnnulus`, `scatterPlot`, `corPlot`.
---

## `summarPlot()`

* Interessante para monitoramento, pois resume rapidamente aspectos importantes dos dados, apresentado resumos estatísticos (min, max, mediana, etc).
* Sintaxe: `summaryPlot(dados)`
---

## `summaryPlot()`

```r
summaryPlot(
    dados,
    period = "days", # melhora a visualização do dado para períodos disponíveis
    print.datacap = TRUE, # traz o percetual por período
    date.breaks = 10, # num  de intervalos principais do eixo x a serem usados
    avg.time = "hour", # dados horários/diários
    date.format = "%b-%Y", # formato do eixo X
    col.data = "purple", # cor da barra de datos disponíveis
    col.trend = "red", # cor da linha 
    col.hist = "black", # cor do histograma
    col.mis = "green" # cor a ser usada para mostrar dados ausentes
    )
```



