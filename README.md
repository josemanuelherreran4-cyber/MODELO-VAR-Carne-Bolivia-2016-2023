# MODELO-VAR-Carne-Bolivia-2016-2023
Para realizar este tipo de análisis econométricos se pueden usar distintos modelos matriciales. Como los modelos de “Método de Mínimos Cuadrados Ordinario”, “Modelos doble log”, etc. Se decidió por un modelo VAR “Vectores Autorregresivos” por sus capacidades ateóricas. 
**Objetivo del proyecto:**  

- Analizar y determinar el impacto de variables macroeconómicas  relacionadas al crecimiento de la demanda externa, y situación del comercio internacional de Bolivia.
- Fuente(s) de datos:  Instituto Nacional de Estadística.
- Herramientas: R / Excel/ GGplot2

---

## 1. INTRODUCCIÓN

Para realizar este tipo de análisis econométricos se pueden usar distintos modelos matriciales. Como los modelos de “**Método de Mínimos Cuadrados Ordinario”, “Modelos doble log”,** etc. Se decidió por un modelo VAR “**Vectores Autorregresivos”** por sus capacidades ateóricas. 

---

## **2. DESARROLLO**

Se reviso bibliografía relacionada al entender el fenómeno que ocurre con el gran crecimiento de las exportaciones de carne bovina, que experimentaron un crecimiento del 5000% entre el 2018 a 2024. Determinar si es sostenible o si se encuentra en una situación de estabilización. 

Se escogieron 3 variables explicativas que determinan la cantidad exportada:

- PIB real; es el valor de los productos finales ajustado por la inflación de un período.
- Tipo de cambio real Multilateral: ;Mide la competitividad de una economía comparando  el precio de sus bienes y servicios con los de sus principales socios comerciales, ponderando los tipos de cambio reales bilaterales según el flujo de comercio.
- Índice en términos de intercambio: Es el precio relativo de las exportaciones en términos del precio de las importaciones; el cociente entre ambos.

### 2.1 Estacionalidad de las variables

Para el análisis de series de tiempo la estacionalidad es fundamental por que si una series es estacionaria, no cambian sus propiedades fundamentales no cambian. Para ser estacionaria se debe cumplir 3 condiciones, 1) media infinita y constante. 2) Varianza finita y constante respecto al tiempo. 3) covarianza finita y constante.
Para verificar estacionariedad se puede usar las pruebas ADF (Dickey Fuller Aumentada), PP (Phillips Perron) y KPPS

### 2.2 Resultados de las variables en primera diferencia

- **KPSS**, el p value indica que se rechaza la Ho de estacionariedad en todos los casos.
- **PP,** Todas las variables son menores al 0,05 rechazamos la H0, de presencia de raíces unitarias la serie es estacionaria.
- **DFA;** Todas las variables a 0,05 se rechaza la Ho, se rechaza la presencia de raíces unitarias. Es estacionaria.

### 2.3 **Planteamiento de la Ecuación VAR(4) de las Series de Tiempo**

Un modelo VAR describe un sistema de ecuaciones interrelacionadas entre múltiples variables a lo largo del tiempo.

El modelo VAR es útil para el análisis de las series de tiempo económicas. Con las ventajas de:

- Tienen un enfoque ateórico.
- Es capaz de separar los efectos pasados que explican el vector de las variables endógenas a través de su pasado o mediante variables regresivas.

Se determina la cantidad de rezagos del modelo según los criterios AIC, HQ, SC, FE.

---

## 3. RESULTADOS DEL MODELO

| **Variable** | **β** | **Error Estándar** |
| --- | --- | --- |
| ∆log_VOL_1 | -0.537306 | 0.118192 |
| ∆log_PIB_1 | 0.292292 | 0.090304 |
| ∆log_TCRM_1 | 2.392166 | 2.488820 |
| ∆log_ITI_1 | -2.319420 | 1.059269 |
| ∆log_VOL_2 | -0.201409 | 0.125536 |
| ∆log_PIB_2 | 0.098145 | 0.097905 |
| ∆log_TCRM_2 | -0.066219 | 2.537327 |
| ∆log_ITI_2 | 0.082976 | 1.048246 |
| ∆log_VOL_3 | -0.236820 | 0.120973 |
| ∆log_PIB_3 | 0.159134 | 0.201841 |
| ∆log_TCRM_3 | 3.294767 | 2.540579 |
| ∆log_ITI_3 | 0.963190 | 1.047301 |
| ∆log_VOL_4 | 0.125596 | 0.104202 |
| ∆log_PIB_4 | 0.441317 | 0.097848 |
| ∆log_TCRM_4 | 5.128027 | 2.329000 |
| ∆log_ITI_4 | -0.001743 | 1.056041 |
| Constante | 0.052315 | 0.040069 |
| Dumm_1 | 0.052315 |  |
| Dumm_2 | -0.076619 |  |
| Dumm_3 | -0.166616 |  |
| Dumm_4 | -0.383783 |  |
| Dumm_5 | -0.493052 |  |
| Dumm_6 |  |  |
|  |  |  |
| R2 | 0.2704
0.2376
8.246
   1.052e-05 |  |
| R2 ajustado |  |  |
| F-statistic |  |  |
| p-value |  |  |
- ∆vol1 = El incremento de las exportaciones del mes anterior está asociada con l una disminución en el volumen de exportación.
- ∆PIB1 = El incremento del PIB de socios, indican un aumento de la exportación de la carne.
- ∆TCRM = El incremento del TCRM, indican un aumento de las exportaciones de carne.
- ∆ITI = El incremento del ITI, indican una relación negativa o caída de las exportaciones.
- Laconstante;0,0523, Indican que las variables explicativas son 0, las exportaciones tienden a aumentar en 5,3%.
- R2 = El 58,7 de las variaciones del volumen de la carne es explicada por las variables.
- R2 ajustado= El modelo explica el 45,5 de las variables de la carne.
- F stadistico = 4,48 con un p value =1,24 indican que al menos una de las variables es explicativa.

---

### 3.1 Preubas del Modelo

**Prueba de No Autocorrelación**

Si existe autocorrelación se viola uno de los supuestos clásicos de la regresión clásica. Se usa la prueba Durwin Watson, donde los valores varían entre 0-4, si lo valores se acercan a , indican la no existencia de correlación.

Los resultados indican que VOL, TCRM, y ITI son cercanos a 2, con un p-value menor 0,05.

La variable PIB, es relativamente cercana a 2, el p value menor a 0,055 indica presencia de autocorrelación.

**Prueba de Homocedastica**

Garantizan las validez y eficiencia de las estimaciones además indican que la varianza de los residuos constante. La prueba Bresuch-Pagan, si el pa value es menor a 0,05 indican heterocedasticidad.

Las variables “Vol, PIB y TCRM” superan el 0,05, no se rechaza la Ho de homocedasticidad.

Pero ITI , presenta un p value 0,05 lo que indica homocedasticidad.

**Prueba de normalidad**

Indican si los residuos se distribuyen de manera normal. Es uno de los supuestos de la regresión si no se cumple la normalidad, los intervalos de confianza pueden ser incorrectos,

Prueba Shapiro Wilks y Kolmogorov-Smirtnov.

- Shapiro Wilks; la H0; Es una distribución normal tangos cercanos a 1 indican una distribución normal el p value menor a 0,05 si se rechaza la Ho.
- Es una prueba no para métrica, donde se comparan 2 distribuciones.

∆Q: No se rechaza la presencia la normalidad.

∆PIB: con un p value 0,01 las variable no presenta normalidad.

∆TCRM y ∆ITI; la prueba Shapiro Wilks sugiere o normalidad, pero la prueba KS, no la rechaza.

---

## CONCLUSIONES DEL MODELO

- El R2 indica que el modelo con dummies explica el 58% de la variabilidad de las exportaciones de carne.
- Sin embargo, las pruebas del modelo, indican que no se cumple a cabalidad los supuestos, la normalidad en los residuos el ∆logPIB, no tiene distribución normal y dependiendo de la prueba ∆logTCRM y ∆logITI presentan posibles problemas de normalidad
- La falta de normalidad en los residuos o errores implica que los intervalos de confianza y los p valor, no son confiables.

---

### Archivos y enlaces

- **Repositorio (GitHub/Drive) con scripts:**
- **Capturas del dashboard:**
