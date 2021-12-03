#### mwm

L' architecture utilisée est mvvm + coordinators dans le but de faire rapide je n' ai utilisé ce modèle que sur le ChoordsViewController  et son ChoordsViewModel.
Le binding se fait via des blocks.
Le viewModel a accès a un repository qui lui même est géré par une couche réseaux et une couche data (NetWorkService et DataService)

L'instanciation des controllers se fait grâce a une factory qui gère l'injection des dépendances.
Tout se fait dans le start de 'AppCoordinator.

Je voulais faire une couche Coredata dans mon DataService mais je n'ai pas eu le temps.

La partie la plus compliquée a sans aucun doute la création des deux selecteurs.
Ce sont des UIcollectionsView avec un layout horizontal.
Quelques modifications et implementations subtiles ont été nécessaires pour arriver à l'effet désiré.

POur les test j'en ai fait quelques uns mais je ne couvre pas du tout le champ global de toute l'application.
Ils sont juste là pour illustrer le fait que je sais en faire.
![Home](https://github.com/clebodam/mwm/blob/main/images/home.png "")
![loading](https://github.com/clebodam/mwm/blob/main/images/loading.png "")
![networkerror](https://github.com/clebodam/mwm/blob/main/images/networkerror.png "")
![choords](https://github.com/clebodam/mwm/blob/main/images/choords.png "")
