---
title: "main"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
df = read.delim("pbc_noExtreme.txt")
```

# STA302 : TP SAS Modèles linéaires mixtes (19.10.21)

## Notation

- Marqueurs répété : Yij
- Temps observé : tij
- Variables explicatives Xi ou Xij
- Pour i sujets et j mesures pour un sujet

## Spécification du modèle

$$ Y_{ij} = (\beta_{0} + u_{0i}) + (\beta_{1} + u_{1i})t_{ij} + \epsilon_{ij}$$

Avec :

- $Y_{ij}$ : le taux d'albumine du sujet i à l'observation j
- $\beta_{0}$ : le taux d'albumine moyen au $t_{0}$
- $u_{0i}$ : la déviation spécifique de l'albuminémie au $t_{0}$ pour chaque sujet
- $\beta_{1}$ : l'évolution moyenne pour chaque unité de temps de l'albuminémie
- $u_{1i}$ : la déviation spécifique au sujet de la pente d'albuminémie au $t_{0}$ pour une unité de temps
- $t_{ij}$ : le temps d'observation j du sujet i
- $\epsilon_{ij}$ : l'erreur résiduelle

Avec :
 $$\left(\begin{array}{c}
 u_{0i} \\
 u_{1i}
 \end{array}\right)
 \sim \mathcal{N}(\left(\begin{array}{c}
0 \\
0
 \end{array}\right),\left(\begin{array}{cc} 
\sigma_{0}^{2} & \sigma_{01}\\ 
\sigma_{01} & \sigma_{1}^{2}
\end{array}\right)) $$

et

$$
\epsilon_{ij} \sim \mathcal{N}(0,\sigma_{e}^{2})
$$

### interprétation du modèle :

- effets fixes :
  - year : 
- effets aléatoires :
  - 
- paramètres de covariance :
  - UN(1,1) : variance de l'intercept aléatoire
  - UN(2,2) : variance de la pente aléatoire
  - UN(2,1) : covariance de l'intercept aléatoire et de la pente aléatoire
  - Residual : variance des résidus

Déterminer la covariance (Yij, Yij') :
$$cov(Y_{ij},Y_{ij'}) = cov(X_{ij}^{T}\beta + Z_{ij}u_{i}+\epsilon_{ij},X_{ij'}^{T}\beta + Z_{ij'}u_{i}+\epsilon_{ij'})$$
$$ = cov(Z_{ij}u_{i}, Z_{ij'}u_{i})$$
$$ = Z_{ij}cov(u_{i},u_{i}) Z_{ij'}^{T}$$

$$ = (\begin{array}{c} 1 & t_{ij} \end{array}) \times var(u_{i}) \times \left( \begin{array}{c} 1 \\ t_{ij} \end{array}\right)$$

$$ = (\begin{array}{c} 1 & t_{ij} \end{array}) \times \left(\begin{array}{cc} 
\sigma_{0}^{2} & \sigma_{01}\\ 
\sigma_{01} & \sigma_{1}^{2}
\end{array}\right) \times \left( \begin{array}{c} 1 \\ t_{ij'} \end{array}\right)$$

$$cov(Y_{ij},Y_{ij'}) = \sigma_{0}^{2} + \sigma_{1}^{2}t_{ij}t_{ij'} + \sigma_{01}(t_{ij}+t_{ij'})$$

## Code SAS

Pour un modèle à intercept aléatoire :

```{r sas}

#proc mixed data = tp.df method = ML plots = all;
#class id;
#model albumin = year;/*au niveau de la population*/
#random intercept / subject = id type = UN; /*au niveau de l'individu*/
#run;
```

Pour un modèle à intercept et pente aléatoires :
```{r sas2}

#proc mixed data = tp.df method = ML plots = all;
#class id;
#model albumin = year;/*au niveau de la population*/
#random intercept year / subject = id type = UN; /*au niveau de l'individu*/
#run;
```
