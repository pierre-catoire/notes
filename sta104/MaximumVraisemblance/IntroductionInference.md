# Introduction à l'inférence

## Principe général de l'inférence

L' #inference statistique consiste à tirer des conclusions sur la loi ayant généré les données observées.

Le point de départ de l' #inference est le choix d'un #modele, c'est-à-dire une famille de #distribution indexée par un #parametre $\theta$ (qui peut être unidimensionnel ou un vecteur).

## #Modele statistique

On suppose que l'on observe un échantillon Y d'observations $Y = (Y_{1}, ..., Y_{n})^{T}$ . Il s'agit donc d'un **vecteur aléatoire**. Le cas des observations $Y_{i}$ multivariés est traité dans le cadre des modèles pour données #longitudinale. On considère également pour l'instant que les $Y_{i}$ sont indépendants et identiquement distribués selon une loi, dont on note $f_{Y}^{*}$ la densité de probabilité.

On appelle #modele une famille de distributions caractérisée par une famille de densités $\{f_{Y}^{\theta}\}$ , $\theta \in \Theta$. On dit que le modèle est bien spécifié s'il existe un $\theta^{*}$ tel que $f_{Y}^{*} = f_{Y}^{\theta*}$.

Si $\Theta$ est un sous-ensemble de $\mathbb{R}^{p}$, on dit que le #modele est #parametrique, et alors $\theta$ est un vecteur de $\mathbb{R}^{p}$ : $\theta = (\theta_{1}, ..., \theta_{n})^{T}$. Si $\Theta$ est un sous-ensemble d'un espace de fonctions, le modèle est #non-parametrique, et les éléments de $\Theta$ sont des fonctions.

L'inférence statistique consiste à diminuer l'incertitude concernant $f_{Y}^{*}$ à partir de l'information apportée par $Y$. Dans l'approche fréquentiste, l'information est résumée à l'aide de #statistique dont les propriétés permettent de diminuer l'incertitude sur $f_{Y}^{*}$.

> Définition 1 :
>
> Une statistique est une fonction $T = T(Y)$ des observations $Y = (Y_{1}, ..., Y_{n})^{T}$.

**Attention** : $T$ est une fonction d'une variable aléatoire $Y$ et est donc également une variable aléatoire (ou un vecteur aléatoire). La #distribution de $T$ peut être déterminée à partir de la distribution des $Y_{i}$. Elle peut dépendre ou non de $\theta^{*}$.

On note dans la suite $\theta$ au lieu de $\theta^{*}$, et $f_{Y}^{\theta}$ au lieu de $f_{Y}^{\theta*}$.

## #Estimation ponctuelle

L'estimation ponctuelle de $\theta$ consiste à construire une statistique $\hat{\theta} = T(Y)$ à partir des observations $Y = (Y_{1}, ..., Y_{n})^{T}$, de telle sorte que $\hat{\theta}$ aie de bonnes propriétés.

>Définition 2 :
>
> Un #estimateur de la vraie valeur $\theta$ du paramètre est une statistique $\hat{\theta} = T(Y)$. $\hat{\theta}$ est une variable aléatoire, et on appelle sa distribution la #distribution-echantillonnage.

### Qualité des #estimateur

