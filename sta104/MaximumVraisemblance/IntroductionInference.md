# Introduction à l'inférence

## Principe général de l'inférence

L' #inference statistique consiste à tirer des conclusions sur la loi ayant généré les données observées.

Le point de départ de l' #inference est le choix d'un #modele, c'est-à-dire une famille de #distribution indexée par un #parametre $\theta$ (qui peut être unidimensionnel ou un vecteur).

## #Modele statistique

On suppose que l'on observe un échantillon Y d'observations $Y = (Y_{1}, ..., Y_{n})^{T}$ . Il s'agit donc d'un **vecteur aléatoire**. Le cas des observations $Y_{i}$ multivariés est traité dans le cadre des modèles pour données #longitudinale. On considère également pour l'instant que les $Y_{i}$ sont indépendants et identiquement distribués selon une loi, dont on note $f_{Y}^{*}$ la densité de probabilité.

On appelle #modele une famille de distributions caractérisée par une famille de densités $\{f_{Y}^{\theta}\}$ , $\theta \in \Theta$. On dit que le modèle est bien spécifié s'il existe un $\theta^{*}$ tel que $f_{Y}^{*} = f_{Y}^{\theta*}$.

Si $\Theta$ est un sous-ensemble de $\mathbb{R}^{p}$, on dit que le #modele est #parametrique, et alors $\theta$ est un vecteur de $\mathbb{R}^{p}$ : $\theta = (\theta_{1}, ..., \theta_{n})^{T}$. Si $\Theta$ est un sous-ensemble d'un espace de fonctions, le modèle est #non-parametrique, et les éléments de $\Theta$ sont des fonctions.

L'inférence statistique consiste à diminuer l'incertitude concernant $f_{Y}^{*}$ à partir de l'information apportée par $Y$. Dans l'approche fréquentiste, l'information est résumée à l'aide de #statistique dont les propriétés permettent de diminuer l'incertitude sur $f_{Y}^{*}$.

> Définition 1 - #statistique :
>
> Une statistique est une fonction $T = T(Y)$ des observations $Y = (Y_{1}, ..., Y_{n})^{T}$.

**Attention** : $T$ est une fonction d'une variable aléatoire $Y$ et est donc également une variable aléatoire (ou un vecteur aléatoire). La #distribution de $T$ peut être déterminée à partir de la distribution des $Y_{i}$. Elle peut dépendre ou non de $\theta^{*}$.

On note dans la suite $\theta$ au lieu de $\theta^{*}$, et $f_{Y}^{\theta}$ au lieu de $f_{Y}^{\theta*}$.

## #Estimation ponctuelle

L'estimation ponctuelle de $\theta$ consiste à construire une statistique $\hat{\theta} = T(Y)$ à partir des observations $Y = (Y_{1}, ..., Y_{n})^{T}$, de telle sorte que $\hat{\theta}$ aie de bonnes propriétés.

>Définition 2 - #estimateur :
>
> Un #estimateur de la vraie valeur $\theta$ du paramètre est une statistique $\hat{\theta} = T(Y)$. $\hat{\theta}$ est une variable aléatoire, et on appelle sa distribution la #distribution-echantillonnage (voir [Distribution d'échantillonnage]([[DistributionEchantillonnage]] DistributionEchantillonnage)).


### Qualité des #estimateur

Le choix de $\hat{\theta}$ repose sur les propriétés de l'estimateur : #biais, #erreur-quadratique-moyenne.

#### Erreur d'estimation et #biais
> Définition 3 - Erreur d'estimation et #biais
>
> L'erreur d'estimation par $\hat{\theta}$ de $\theta$ est une variable aléatoire $(\hat{\theta}-\theta)$. L'espérance de l'erreur d'estimation $\mathop{\mathbb{E}}(\hat{\theta}-\theta)$ est appelée le #biais.

> Définition 4 - #estimateur sans #biais
>
> Un estimateur est sans biais si $\mathop{\mathbb{E}}(\hat{\theta})=\theta$.

#### #erreur-quadratique-moyenne

> Définition 5 - #erreur-quadratique-moyenne
>
> L' #erreur-quadratique-moyenne ( *#mean-square-error*, *#MSE*) est l'espérance du carré de l'erreur d'estimation : $MSE_{\theta}(\hat{\theta}) = \mathop{\mathbb{E}}[(\hat{\theta}-\theta)^{2}]$. 

On démontre que  $MSE_{\theta}(\hat{\theta}) = var(\hat{\theta}) + [\mathop{\mathbb{E}}(\hat{\theta}-\theta)]^{2}$ (voir [Variance - Théorème de Konig-Huygens]([[Variance]] Variance)), c'est-à-dire que l'erreur quadratique moyenne est la somme de la #variance et du carré du biais. L'estimateur $\hat{\theta}$ est d'autant plus satisfaisant que sa $MSE_{\theta}(\hat{\theta})$ est faible.

On démontre qu'aucun estimateur sans biais de peut avoir une #variance inférieure à la #borne-cramer-rao, qui est l'inverse de la #matrice-information-fisher $I(\theta^{*})$.

> Théorème : Borne de Cramer Rao
>
> Si $\hat{\theta}$ est un estimateur sans biais de $\theta$, alors l'inverse de la matrice de l'information de Fisher est une borne inférieure de la variance de $\hat{\theta}$ :
> $var(\hat{\theta}) \geq I(\theta)^{-1}  =\mathop{\mathbb{E}} \Big[\Big( \frac{\partial}{\partial \theta}L(X;\theta)\Big)^{2}\Big]^{-1}$
> Si le #modele est #regulier, on a $I(\theta)^{-1}  =\mathop{\mathbb{E}} \Big[\frac{\partial^{2}}{\partial \theta^{2}}L(X;\theta)\Big]^{-1}$
> Avec $L(X;\theta)$ la log-vraisemblance.

On dit qu'un #estimateur est #efficace si sa #variance atteint la #borne-cramer-rao :

> Définition 6 - #estimateur #efficace
>
> $\hat{\theta}$ est efficace si $var(\hat{\theta}) = I(\theta)^{-1}$

**Attention** : il se peut parfois que l'introduction d'un certain degré de biais dans un estimateur entraîne une réduction significative de la variance, de telle sorte que la $MSE_{\theta}(\hat{\theta})$ soit réduite et que l'estimateur soit plus performant. Par ailleurs, il n'est pas toujours possible de calculer $var(\hat{\theta})$, et on est amené à l'estimer.

Une propriété fondamentale d'un bon estimateur est la #convergence :

> Définition 7 - #Convergence
>
> La suite d'estimateurs $\{\hat{\theta}_{n}\}$ est convergente pour $\hat{\theta}$ si $\{\hat{\theta}_{n}\}$ converge en probabilité vers $\theta$, c'est-à-dire si $\lim_{n \to \infty} P_{\theta}(|\hat{\theta}_{n}-\theta| > \epsilon)=0$ $\forall \epsilon, \theta > 0$, et on note $\hat{\theta}_{n} \xrightarrow{\text{p}}\theta$.

> Définition 8 - #biais-asymptotique
>
> Un estimateur $\hat{\theta}_{n}$ (ou plus simplement $\hat{\theta}$) est asymptotiquement sans biais si $\mathop{\mathbb{E}}(\hat{\theta}_{n}-\theta)$ tend vers 0 lorsque n tend vers l'infini.

**NB** : une condition suffisante pour que $\hat{\theta}$ soit #convergent est qu'il soit asymptotiquement sans viais et que sa variance tende vers 0 lorsque n tend vers l'infini : c'est une conséquence de $MSE_{\theta}(\hat{\theta}) = var(\hat{\theta}) + [\mathop{\mathbb{E}}(\hat{\theta}-\theta)]^{2}$.