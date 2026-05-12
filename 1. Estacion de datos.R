#librerias
library(lmtest)
library(readxl)
library(vars)
library(ggplot2)
library(reshape2)
library(tseries)
library(rugarch)
library(FinTS)
library(forecast)
library(mgarchBEKK)
#corregir errores en las librerias


# Install/update tseries (and forecast if you want it)
if(!require(tseries)){install.packages("tseries")}
if(!require(forecast)){install.packages("forecast")}
install.packages("forecast")

packageVersion("tseries")

#   1 importación de datos


datos <- read_excel("~/TRABAJO DIRIGIDO/1. Fuentes TRABAJO DIRIGIDO/! Variables del modelo.xlsx")
View(datos)

# 2: Series temporales
ts_vol <- ts(datos$carne_kg, start= 2016, frequency = 12)
plot(ts_vol)

ts_pib_r <-ts(datos$PIB_r, start= 2016, frequency = 12)
plot(ts_pib_r)


ts_tcrm <- ts(datos$TCRM, start= 2016, frequency = 12)
plot(ts_tcrm)

ts_iti <-ts(datos$ITI, start = 2016, frequency = 12)
plot(ts_iti)

# 2.1: Series de tiempo en logaritmo

lg_ts_carne <- log(ts_vol)
plot(lg_ts_carne)

lg_ts_pib <- log(ts_pib_r)
plot(lg_ts_pib)

lg_ts_it <- log(ts_iti)
plot(lg_ts_it)

lg_ts_tcrm <- log(ts_tcrm)
plot(lg_ts_tcrm)


# aplicación de la primera diferencia 

diff_ts_lg_vol <- diff(lg_ts_carne)
plot(diff_ts_lg_vol)

diff_lg_ts_pib <- diff(lg_ts_pib)
plot(diff_lg_ts_pib)

diff_lg_ts_tcrm <- diff (lg_ts_tcrm)
plot(diff_lg_ts_tcrm)

diff_lg_ts_it <-diff (lg_ts_it)
plot(lg_ts_it)

# diff_ts_lg_vol, diff_lg_ts_pib, diff_lg_ts_tcrm, diff_lg_ts_it


# 3 PRUEBAS DE ESTACIONARIDAD primero en logaritmo 



# pruebas KPPS:
#Hipótesis Nula (H₀): La serie de tiempo es estacionaria alrededor de una tendencia determinista.
#Hipótesis Alternativa (H₁): La serie de tiempo no es estacionaria y tiene una raíz unitaria.

kpss.test(lg_ts_carne)
kpss.test(lg_ts_pib)
kpss.test(lg_ts_tcrm)
kpss.test(lg_ts_it)

# pruebas PP
#Hipótesis Nula (H₀): Esta afirma que la serie de tiempo tiene una raíz unitaria. En otras palabras, la serie no es estacionaria.
# Hipótesis Alternativa (H₁): Esta afirma que la serie de tiempo no tiene una raíz unitaria. Es decir, la serie es estacionaria.

pp.test(lg_ts_carne)
pp.test(lg_ts_pib)
pp.test(lg_ts_tcrm)
pp.test(lg_ts_it)

#pruebas DFA

# Hipótesis Nula (H₀): La serie de tiempo tiene una raíz unitaria, es decir, es no estacionaria. Esto implica que los shocks o perturbaciones tienen un efecto permanente en el nivel de la serie.
#Hipótesis Alternativa (H₁): La serie de tiempo no tiene una raíz unitaria, es decir, es estacionaria. Esto significa que los shocks tienen un efecto temporal y la serie tiende a volver a su media a largo plazo.

adf.test(lg_ts_carne)
adf.test(lg_ts_pib)
adf.test(lg_ts_tcrm)
adf.test(lg_ts_it)

# PRUEBAS DE ESTACIONARIDAD segundo ademas en 1 diff

# PRUEBAS DICKEY-FULLER AUMENTADA

# Hipótesis Nula (H₀): La serie de tiempo tiene una raíz unitaria, es decir, es no estacionaria. Esto implica que los shocks o perturbaciones tienen un efecto permanente en el nivel de la serie.
#Hipótesis Alternativa (H₁): La serie de tiempo no tiene una raíz unitaria, es decir, es estacionaria. Esto significa que los shocks tienen un efecto temporal y la serie tiende a volver a su media a largo plazo.


adf.test(diff_ts_lg_vol)
adf.test(diff_lg_ts_pib)
adf.test(diff_lg_ts_tcrm)
adf.test(diff_lg_ts_it)


# Prueba KPPS

#Hipótesis Nula (H₀): La serie de tiempo es estacionaria alrededor de una tendencia determinista.
#Hipótesis Alternativa (H₁): La serie de tiempo no es estacionaria y tiene una raíz unitaria.

kpss.test(diff_ts_lg_vol)
kpss.test(diff_lg_ts_pib)
kpss.test(diff_lg_ts_tcrm)
kpss.test(diff_lg_ts_it)

#prueba PP,
#Hipótesis Nula (H₀): Esta afirma que la serie de tiempo tiene una raíz unitaria. En otras palabras, la serie no es estacionaria.
# Hipótesis Alternativa (H₁): Esta afirma que la serie de tiempo no tiene una raíz unitaria. Es decir, la serie es estacionaria.

pp.test(diff_ts_lg_vol)
pp.test(diff_lg_ts_pib)
pp.test(diff_lg_ts_tcrm)
pp.test(diff_lg_ts_it)


# 4 creación de un data frame


df <- data.frame(
  diff_ts_lg_vol = c(diff_ts_lg_vol),
  diff_lg_ts_pib = c(diff_lg_ts_pib),
  diff_lg_ts_tcrm = c(diff_lg_ts_tcrm),
  diff_lg_ts_it= c(diff_lg_ts_it))

var_data <- df[ c ("diff_ts_lg_vol","diff_lg_ts_pib", "diff_lg_ts_tcrm", "diff_lg_ts_it" )]
var_data

ts_var_data <- ts(var_data, start= 2016, frequency = 12)

ts_var_data

plot(ts_var_data)


# 5 PRUEBAS DE AUTOCORRELACIÓN PARCIAL
par(mfrow = c(1, 1))
# Para la serie diff_ts_lg_vol
pacf(diff_ts_lg_vol, 
     plot = TRUE, 
     main="PACF diff_lg_ts_vol",
     col="red",
     cex.axis=0.8,
     cex.main= 0.8, 
     ylab="Autocorrelación Parcial",
     xlab="Rezagos",
     ylim=c(-0.5, 0.5))



#  6  APLICACIÓN DE UN MODELO "VAR"

# Selección del modelo según número de rezagos y creación del modelo

VARselect(ts_var_data, lag.max = 10)# resulta que el mejor modelo esta en el primer rezago

var_model1 <- VAR(ts_var_data, p = 1)

summary(var_model1)

#Pruebas del modelo VAR 1
#1 prueba de raices unitarias
stability <- roots(var_model1, modulus = TRUE)
print(stability)  # Las raíces deben ser menores a 1

#2 prueba de heterocedasticidad
# a. Normalidad
# (Prueba de Jarque-Bera)

normality.test(var_model1)
# prueba de No Autocorrelación  
serial.test(var_model1, type = "PT.asymptotic")

# no homosedasticidad
arch.test(var_model1)


# Agrego dummies al modelo VAR 1 para mejorar analisis

ts_dummy1 <- ts(datos$dumm_1, start=2016, frequency=12)
ts_dummy2 <- ts(datos$dumm_2, start=2016, frequency=12)
ts_dummy3 <- ts(datos$dumm_3, start=2016, frequency=12)
ts_dummy4 <- ts(datos$dumm_4, start=2016, frequency=12)
ts_dummy5 <- ts(datos$dumm_5, start=2016, frequency=12)
ts_dummy6 <- ts(datos$dumm_6, start=2016, frequency=12)

dummies_matrix <- cbind(ts_dummy1, ts_dummy2, ts_dummy3, ts_dummy4, ts_dummy5, ts_dummy6)

dummies_matrix <- dummies_matrix[-1,]

row(dummies_matrix)
row(ts_var_data)
# Ajustar el modelo VAR(1) con dummies como variables exógenas


var_model2 <- VAR(ts_var_data, p = 4, exogen = dummies_matrix)
summary((var_model2))

residuos_var_model2 <- residuals(var_model2)

# pruebas de heterocedasticidad

#pruebas para heterocedasticidad

# Prueba de Breusch-Pagan para cada variable
cat("Prueba de Breusch-Pagan:\n")
for (i in 1:ncol(residuos_var_model2)) {
  bp_test <- bptest(residuos_var_model2[, i] ~ fitted(lm(residuos_var_model2[, i] ~ 1)))
  cat("Variable:", colnames(residuos_var_model2)[i], "\n")
  print(bp_test)
  cat("\n")
}


cat("Prueba de White:\n")
for (i in 1:ncol(residuos_var_model2)) {
  modelo_auxiliar <- lm(residuos_var_model2[, i] ~ 1)
  valores_ajustados <- fitted(modelo_auxiliar)
  white_test <- bptest(residuos_var_model2[, i] ~ valores_ajustados + I(valores_ajustados^2))
  cat("Variable:", colnames(residuos_var_model2)[i], "\n")
  print(white_test)
  cat("\n")
}


#prueba de normalidad
# prueba de normalidad
shapiro_resultados <- apply(residuos_var_model2, 2, shapiro.test)

print(shapiro_resultados)

#  Kolmogorov-Smirnov
ks_resultados <- apply(residuos_var_model2, 2, function(x) ks.test(x, "pnorm", mean(x), sd(x)))

print(ks_resultados)

# Aplicar la prueba a cada serie de residuos
jarque_bera_resultados <- apply(residuos_var_model2, 2, jarque.bera.test)

# Mostrar los resultados
print(jarque_bera_resultados)

#PRUEBADE RAICES UNITARIAS
#prueba 1 raices unitarias


# Obtener valores propios del modelo VAR

print(roots(var_model2))

#prueba de no autocorrelación

serial.test(var_model2, type="PT.asymptotic") #  Portmanteau- and Breusch-Godfrey


for (i in 1:ncol(residuos_var_model2)) {
  print(paste("Prueba Durbin-Watson para la variable", i))
  print(dwtest(residuos_var_model2[, i] ~ 1))
}

























# 8 pruebas al modelo var_2
#prueba 1 raices unitarias

library(vars)

# Obtener valores propios del modelo VAR
stability_test <- roots(var_model2)

# Mostrar los valores propios
print(stability_test)

# Graficar los valores propios en el plano complejo
plot(stability_test, main="Prueba de estabilidad: Valores propios del modelo VAR")


#prueba 2, no autocorrelación:
serial.test(var_model2, type="PT.asymptotic") #  Portmanteau- and Breusch-Godfrey

residuosvar2 <- residuals(var_model2)

for (i in 1:ncol(residuosvar2)) {
  print(paste("Prueba Durbin-Watson para la variable", i))
  print(dwtest(residuosvar2[, i] ~ 1))
}

dwtest(var_model2) # prueba durwin watson

# prueba 3 homocedasticidad

for (i in 1:ncol(residuosvar2)) {
  print(paste("Prueba de White para la variable", i))
  white_test <- bptest(residuosvar2[, i] ~ fitted(lm(residuosvar2[, i] ~ 1)) + I(fitted(lm(residuosvar2[, i] ~ 1))^2))
  print(white_test)
}

#prueba 4, normalidad de los residuos shapiro-wilks

# Aplicar la prueba de Shapiro-Wilk a cada serie de residuos
for (i in 1:ncol(residuosvar2)) {
  print(paste("Prueba de Shapiro-Wilk para la variable", i))
  shapiro_test <- shapiro.test(residuosvar2[, i])
  print(shapiro_test)
}



# prueba de linealidad 
resultados_bds <- apply(residuosvar2, 2, function(x) bds.test(x))
print(resultados_bds)



# 7 Correccion de homocedasticidad, del Modelo VAR(1)

residuos_var <- residuals(var_model2)
matrix_residuosVAR <- data.frame(residuos_var)
hist(matrix_residuosVAR$diff_ts_lg_vol)
hist(matrix_residuosVAR$diff_lg_ts_pib)
hist(matrix_residuosVAR$diff_lg_ts_tcrm)
hist(matrix_residuosVAR$diff_lg_ts_it)


garch_spec <- ugarchspec(variance.model = list(model = "sGARCH", garchOrder = c(1,1)),
                         mean.model = list(armaOrder = c(0,0)),
                         distribution.model = "std")


garch_fit_vol <- ugarchfit(spec = garch_spec, data = residuos_var[,1])
garch_fit_pib <- ugarchfit(spec = garch_spec, data = residuos_var[,2])
garch_fit_tcrm <- ugarchfit(spec = garch_spec, data = residuos_var[,3])
garch_fit_it <- ugarchfit(spec = garch_spec, data = residuos_var[,4])

#prueba de correccion de residuoss

ArchTest(residuals(garch_fit_vol@fit), lags=7)
ArchTest(residuals(garch_fit_pib@fit), lags=5)
ArchTest(residuals(garch_fit_tcrm@fit), lags=5)
ArchTest(residuals(garch_fit_it@fit), lags=5)

# Extraer volatilidades condicionales de los modelos GARCH
volatilidad_datos <- data.frame(
  Volatilidad_Vol = sigma(garch_fit_vol),
  Volatilidad_PIB = sigma(garch_fit_pib),
  Volatilidad_TCRM = sigma(garch_fit_tcrm),
  Volatilidad_IT = sigma(garch_fit_it)
)

help("ts")
volatilidad_datos2 <-ts(volatilidad_datos, start = c(2016, 3), frequency = 12)
volatilidad_datos2


ts_vara_data_sf2 <- ts(ts_vara_data_sf, start = c(2016, 3), frequency = 12)
ts_vara_data_sf2



var_model3 <- VAR(ts_vara_data_sf2, p = 1, exogen = volatilidad_datos2)

summary(var_model2)

arch.test(var_model2)

# a. Normalidad
# (Prueba de Jarque-Bera)

normality.test(var_model2)
