Pré-requis : s'assurer que JBang est installé sur le poste
Si ce n'est pas le cas cliquer sur l'url https://www.jbang.dev/documentation/guide/latest/installation.html, repérer l'OS correspondant au poste et suivre les instructions.

Une fois le pré-requis confirmé, réaliser les étapes ci-dessous :
1. Créer un répertoire pour le projet
2. Ouvrir un terminal (DOS ou PowerShell)
3. Se position sur le repertoire créé
4. Y créer un fichier .java et y intégrer le code 
5. Utiliser la commande "jbang init --template=cli 'script.java'" pour initialiser le nouveau projet
	#Initialisation projet JBang
	jbang init --template=cli my-api/agences.java
6. Les commandes ci-dessous permettent d'exécuter le script
	jbang run .\agences.java
	jbang .\agences.java
	
7. Il est possible de créer des alias par script afin d'en faciliter l'exécution ultérieur
	#Création d'un alias Jbang
	jbang alias add --name agence .\my-api\agences.java

	#Affichage des alias disponibles
	jbang alias list

	#Execution du projet JBang via l'alias
	jbang agence
