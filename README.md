<h1 align="center">MWM</h1>
<p align="center">
  <a href="https://upload.wikimedia.org/wikipedia/commons/d/d6/IOS_13_logo.svg"><img alt="ios" src="https://upload.wikimedia.org/wikipedia/commons/d/d6/IOS_13_logo.svg"/></a>
</p>

### ARCHITECTURE
L' architecture utilisée est mvvm + coordinators dans le but de faire rapide je n' ai utilisé ce modèle que sur le ChoordsViewController  et son ChoordsViewModel.
Le binding se fait via des blocks.
Le viewModel a accès a un repository qui lui même est géré par une couche réseau et une couche data (NetWorkService et DataService)

L'instanciation des controllers se fait grâce a une factory qui gère l'injection des dépendances.
Tout se fait dans le start de l'AppCoordinator.

### NETWORK
Les appels api son gérés par le NetWorkService qui utilise les URLSession, les erreurs sont gérées

### DATA
Je voulais faire une couche Coredata dans mon DataService mais je n'ai pas eu le temps. Donc ce n' est qu une coquille vide qui stocke les données sérialisées en ram

### UI
La partie la plus compliquée a sans aucun doute été la création des deux selecteurs.
Ce sont des UICollectionsView avec un layout horizontal.
Quelques modifications et implementations subtiles ont été nécessaires pour arriver à l'effet désiré.

### TESTS
POur les test j'en ai fait quelques uns mais je ne couvre pas du tout le champ global de toute l'application.
Ils sont juste là pour illustrer le fait que je sais en faire.


![Home](https://github.com/clebodam/mwm/blob/main/images/home.png "")

![loading](https://github.com/clebodam/mwm/blob/main/images/loading.png "")

![networkerror](https://github.com/clebodam/mwm/blob/main/images/networkerror.png "")

![choords](https://github.com/clebodam/mwm/blob/main/images/choords.png "")
