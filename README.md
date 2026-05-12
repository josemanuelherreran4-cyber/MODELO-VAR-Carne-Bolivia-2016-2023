# MODELO-VAR-Carne-Bolivia-2016-2023
Para realizar este tipo de análisis econométricos se pueden usar distintos modelos matriciales. Como los modelos de “Método de Mínimos Cuadrados Ordinario”, “Modelos doble log”, etc. Se decidió por un modelo VAR “Vectores Autorregresivos” por sus capacidades ateóricas. 
**Objetivo del proyecto:**  
Analizar y determinar el impacto de las variables macroeconómicas relacionadas con el crecimiento de la demanda externa y la situación del comercio internacional de Bolivia.

- **Fuente de datos:** Instituto Nacional de Estadística (INE).
- **Herramientas:** R / Excel / ggplot2.

---

## 1. INTRODUCCIÓN

Para realizar este tipo de análisis econométricos se pueden usar distintos modelos matriciales. Como los modelos de “**Método de Mínimos Cuadrados Ordinario”, “Modelos doble log”,** etc. Se decidió por un modelo VAR “**Vectores Autorregresivos”** por sus capacidades ateóricas. 

---

## **2. DESARROLLO**

Para realizar este análisis econométrico, se evaluaron distintos modelos matriciales como el de **Mínimos Cuadrados Ordinarios (MCO)** y modelos **Log-Log**. Finalmente, se optó por un modelo de **Vectores Autorregresivos (VAR)** debido a sus capacidades ateóricas.

### 2.1 Estacionalidad de las variables

En el análisis de series de tiempo, la **estacionariedad** es fundamental. Una serie es estacionaria cuando sus propiedades estadísticas no varían en el tiempo. Para ello, debe cumplir tres condiciones:

- **Media** finita y constante.
- **Varianza** finita y constante respecto al tiempo.
- **Covarianza** finita y constante para cualquier rezago.

Para verificar este supuesto, se aplicaron las pruebas **ADF** (Augmented Dickey-Fuller), **PP** (Phillips-Perron) y **KPSS**.

### 2.2 Resultados de las variables en primera diferencia

- **KPSS:** El p-value indica que no se rechaza la hipótesis nula de estacionariedad.
- **PP y ADF:** En ambos casos, el p-value es menor a 0.05, por lo que se rechaza la hipótesis nula de presencia de raíces unitarias; las series son estacionarias en primeras diferencias.

### 2.3 **Planteamiento de la Ecuación VAR(4) de las Series de Tiempo**

El modelo VAR describe un sistema de ecuaciones interrelacionadas. Sus principales ventajas son su enfoque ateórico y su capacidad para desglosar efectos pasados en el vector de variables endógenas. La cantidad de rezagos (4) se determinó bajo los criterios de información **AIC, HQ, SC y FPE**.

---

## 3. RESULTADOS DEL MODELO

| **Variable** | **Coeficiente (β)** | **Error Estándar** |
| --- | --- | --- |
| $\Delta \log \text{VOL}_{t-1}$ | -0.5373 | 0.1181 |
| $\Delta \log \text{PIB}_{t-1}$ | 0.2922 | 0.0903 |
| $\Delta \log \text{TCRM}_{t-1}$ | 2.3921 | 2.4888 |
| $\Delta \log \text{ITI}_{t-1}$ | -2.3194 | 1.0592 |

**•	∆PIBr:** El crecimiento económico de los socios comerciales está asociado positivamente con el aumento de las exportaciones de carne.

**•	∆TCRM:** Un incremento en el tipo de cambio multilateral sugiere una mayor competitividad, impulsando las exportaciones.

**Bondad de ajuste:** El $R^2$ ajustado indica que el modelo explica el 45.5% de la variabilidad de las exportaciones.

---

### 3.1 Pruebas del Modelo

**No Autocorrelación:** Se utilizó la prueba de **Durbin-Watson**. Los resultados para VOL, TCRM e ITI son cercanos a 2 ($p < 0.05$), indicando ausencia de autocorrelación. La variable PIB muestra ligeros indicios de autocorrelación ($p \approx 0.055$).

**Homocedasticidad:** Mediante la prueba de **Breusch-Pagan**, se confirmó que las variables VOL, PIB y TCRM mantienen una varianza de residuos constante ($p > 0.05$).

**Normalidad:** Se aplicaron las pruebas de **Shapiro-Wilk** y **Kolmogorov-Smirnov**. Los resultados sugieren que los residuos de $\Delta \log \text{PIB}$ no siguen una distribución normal, lo que implica que los intervalos de confianza deben interpretarse con cautela.

---

## CONCLUSIONES DEL MODELO

- El R2 indica que el modelo con dummies explica el 58% de la variabilidad de las exportaciones de carne.
- Sin embargo, las pruebas del modelo, indican que no se cumple a cabalidad los supuestos, la normalidad en los residuos el ∆logPIB, no tiene distribución normal y dependiendo de la prueba ∆logTCRM y ∆logITI presentan posibles problemas de normalidad
- La falta de normalidad en los residuos o errores implica que los intervalos de confianza y los p valor, no son confiables.

---
