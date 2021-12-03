<h1 align="center">MWM</h1>
<p align="center">
  <a href="https://www.google.com/imgres?imgurl=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2Fthumb%2Fd%2Fd6%2FIOS_13_logo.svg%2F1024px-IOS_13_logo.svg.png&imgrefurl=https%3A%2F%2Fcommons.wikimedia.org%2Fwiki%2FFile%3AIOS_13_logo.svg&tbnid=5bTZmNeQvkBU_M&vet=12ahUKEwjWn7ih3cj0AhVlgHMKHZ3PDs0QMygAegUIARDKAQ..i&docid=NNnWTVcX3uZqZM&w=1024&h=1024&itg=1&q=ios%2013&ved=2ahUKEwjWn7ih3cj0AhVlgHMKHZ3PDs0QMygAegUIARDKAQ"><img alt="ios" src="https://www.google.com/imgres?imgurl=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2Fthumb%2Fd%2Fd6%2FIOS_13_logo.svg%2F1024px-IOS_13_logo.svg.png&imgrefurl=https%3A%2F%2Fcommons.wikimedia.org%2Fwiki%2FFile%3AIOS_13_logo.svg&tbnid=5bTZmNeQvkBU_M&vet=12ahUKEwjWn7ih3cj0AhVlgHMKHZ3PDs0QMygAegUIARDKAQ..i&docid=NNnWTVcX3uZqZM&w=1024&h=1024&itg=1&q=ios%2013&ved=2ahUKEwjWn7ih3cj0AhVlgHMKHZ3PDs0QMygAegUIARDKAQ"/></a>
</p>

### ARCHITECTURE
L' architecture utilisée est mvvm + coordinators dans le but de faire rapide je n' ai utilisé ce modèle que sur le ChoordsViewController  et son ChoordsViewModel.
Le binding se fait via des blocks.
Le viewModel a accès a un repository qui lui même est géré par une couche réseaux et une couche data (NetWorkService et DataService)

L'instanciation des controllers se fait grâce a une factory qui gère l'injection des dépendances.
Tout se fait dans le start de 'AppCoordinator.
### NETWORK
Les appels api son gérés par le NetWorkService qui utilise les URLSession , 'absence de réseaux et les erreurs de parsing sont gérées
### DATA
Je voulais faire une couche Coredata dans mon DataService mais je n'ai pas eu le temps. Donc ce n 'est qu une coquille vide qui stoke les données sérialisées en ram
### UI
La partie la plus compliquée a sans aucun doute la création des deux selecteurs.
Ce sont des UIcollectionsView avec un layout horizontal.
Quelques modifications et implementations subtiles ont été nécessaires pour arriver à l'effet désiré.
### TESTS
POur les test j'en ai fait quelques uns mais je ne couvre pas du tout le champ global de toute l'application.
Ils sont juste là pour illustrer le fait que je sais en faire.
![Home](https://github.com/clebodam/mwm/blob/main/images/home.png "")
![loading](https://github.com/clebodam/mwm/blob/main/images/loading.png "")
![networkerror](https://github.com/clebodam/mwm/blob/main/images/networkerror.png "")
![choords](https://github.com/clebodam/mwm/blob/main/images/choords.png "")
