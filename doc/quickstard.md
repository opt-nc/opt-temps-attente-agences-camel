# __QuickStart__

## ℹ️  Prérequis

Les éléments suivant doivent-être installés :

* <a href="https://docs.docker.com/engine/install/" target="_blank"> Docker </a>
* <a href="https://www.jbang.dev/documentation/guide/latest/installation.html" target="_blank"> JBang </a>
* <a href="https://camel.apache.org/manual/camel-jbang.html" target="_blank"> Camel-JBang </a>

Les ports suivant doivent-être libres pour que les conteneurs Docker puissent fonctionner :

* 8080 - opt-temps-attente-agences-api
* 8888 - kowl
* 9092 / 9093 - kafka
* 2181 - zookeeper

## Description des livrables

Le répertoire _scripts_ contient :

* 2 fichiers routes en xml

    * _route-kafka.xml_ : récupère les données de l'api temps-d'attente et les routes vers Kafka (Producer)
    * _route-kafka-jsont.xml_ : récupère le données depuis le topic Kafka et les stocke dans un fichier JSON (Consumer) dans le répertoire _files_   
* 1 fichier yaml _temps_attente.yml_ : exécutable avec Docker Compose pour le lancement des différents conteneurs nécessaires (opt-temps-attente-agences-api, kafka, zookeeper, kowl) 
* 2 fichiers quickstart (.ps1 et .sh) qui effectuent les opérations suivantes avec une pause de 5 secondes entre chaque étape :

    * Exécution du fichier Yaml permettant de télécharger et monter les conteneurs via la commande 
    ```bash
     docker-compose 
     ```
    * Vérification de l'existance du topic Kafka  "temps-attente. S'il n'existe pas, il est créé.\
    A noter que la création du topic Kafka est réalisée par l'intermétiaire des commandes natives Kafka afin d'assurer la portabilité du script Powershell (Windows/Linux).
    * Exécution des 2 routes camel via la commande, qui génére aussi un fichier _camel-output.log_ : 
    ```bash
     camel-run 
     ``` 
     * Lancement de l'interface web de kowl dans le naviguateur par défaut du système d'exploitation
 
 ## ℹ️   Mode opératoire

 * Lancer un invite de commande (bash, PowerShell, Terminal Windows)
 * Se placer dans le dossier _scripts_
 * Exécuter le fichier _.ps1_ pour Windows/Linux (si Powershell est installé) ou _.sh_ pour Linux. 
 
![image](.\shell.png)

A noter qu'il sera sans doute nécessaire d'actualiser la page Kowl pour que le flux de données soit visible.
![image](.\kowl.png)