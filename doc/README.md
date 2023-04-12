
# Prérequis

* docker 
* camel-jbang
* kafka (via docker-compose)
* kafkacat

## Installer camel-jbang  

Note: Java n'a pas besoin d'être déjâ présent car jbang va le télécharger automatiquement si java 8 ou un JDK plus récent n'est pas détecté.
    
### 1. Installer jbang 

### <i>Linux</i> :
Ouvrir un terminal puis exécuter une des deux commandes suivantes :

* Avec SDKMan
``` bash 
sdk install jbang
```
* Avec jbang lui même :
``` bash 
curl -Ls https://sh.jbang.dev | bash -s - app setup
```
Une fois installer, il est recommandé d'exécuter la commande suivante afin de modifier les variables d'environnement pour inclure les scripts jbang :
```bash
jbang app setup
```

### <i>Windows</i> :

* Avec jbang : 
    * ouvrir powershell et exécuter la commande suivante :
    ```powershell
    iex "& { $(iwr -useb https://ps.jbang.dev) } app setup"
    ```
* Avec chocolatey
    * A partir d'une invite commande installer chocolatey :
    ```bash
    choco install jdk11
    ```
    * Une fois java installer : 
    ```bash 
    choco install jbang
    ```


### 2. Installer camel
* Ouvrir une invite de commande ou un terminal et exécuter la commande suivante :
    ``` bash 
    jbang app install camel@apache/camel
    ``` 

### 3. Installer Kafkacat 
* Ouvrir une invite de commande ou un terminal et exécuter la commande suivante :
    ```bash
    apt install -y kafkacat  
    ```

# Utilisation de la route camel : 
Ouvrir un terminal ou une invite de commande puis exécuter les commandes suivantes dans le dossier où le script docker-compose se trouve :

* Lancement des différents conteneur docker dont l'API des temps d'attentes en agence avec le fichier docker-compose a récupérer sur le dépôt Github
    ``` bash 
    docker-compose up -d 
    ```

* Pour afficher le status des conteneurs, exécuter la commande ci-dessous
    ```bash
    docker ps
    ```

    L'affichage devrait correspondre à celui ci-dessous :
    ```bash
    CONTAINER ID   IMAGE                                 COMMAND                  CREATED      STATUS                             PORTS                                                  NAMES
    bcd9edd7de54   quay.io/cloudhut/kowl:v1.3.1          "./kowl"                 4 days ago   Up 6 seconds                       0.0.0.0:8888->8888/tcp                                 kowl
    52bea7369ab6   bitnami/kafka:latest                  "/opt/bitnami/script…"   4 days ago   Up 9 seconds                       0.0.0.0:9092-9093->9092-9093/tcp                       kafka
    84c0d56969ec   optnc/opt-temps-attente-agences-api   "/cnb/process/web"       4 days ago   Up 11 seconds                      0.0.0.0:8080->8080/tcp                                 optnc
    551fff613ee6   bitnami/zookeeper:latest              "/opt/bitnami/script…"   4 days ago   Up 11 seconds (health: starting)   2888/tcp, 3888/tcp, 0.0.0.0:2181->2181/tcp, 8080/tcp   zookeeper
    ```
    A noter que les conteneurs ont été nommés via le fichier yaml, cf. colonne "NAMES".

* Pour arrêter les conteneurs
    ```bash
    docker-compose stop
    ```

# Kafka
* Création d'un Producer kafka :

### <i>Linux</i> :
* Depuis un terminal
    ```bash
    kafkacat -P -b kafka:9092 -t temps-attente &
    ```
* Pour afficher les topics 
    ```bash
    kafkacat -b localhost:9092 -L
    ```

### <i>Windows</i> :
* Ouvrir un terminal et exécuter les commandes ci-dessous

    ### Depuis Docker
    ```bash
    docker exec -it kafka kafka-console-producer.sh --broker-list localhost:9092 --topic temps-attente -P
    ```
    * Pour afficher les topics 
    ```bash
    docker exec -it kafka  kafka-topics.sh --list --bootstrap-server localhost:9092
    ```
    * Pour supprimer un topic
    ```bash
    docker exec -it kafka kafka-topics.sh --bootstrap-server localhost:9092 --delete --topic "temps-attente"
    ```
### Depuis le conteneur Kafka
* Exécuter les commandes ci-dessous pour accèder au terminal du docker Kafka
    ```bash
    docker exec -it kafka sh
    ```
    Ou
    ```bash
    docker exec -ti kafka bash
    ```
    Se positionner dans le répertoire bin de Kafka
    ```bash
    cd opt/bitnami/kafka/bin/
    ```
    Et exécuter la commande suivante
    ```bash
    kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic temps-attente
    ```
    * Pour afficher les topics 
    ```bash
    kafka-topics.sh --list --bootstrap-server localhost:9092
    ```
    * Pour supprimer un topic
    ```bash
    kafka-topics.sh --bootstrap-server localhost:9092 --delete --topic temps-attente
    ```

## Lancement de la route Camel :

IMPORTANT : la route camel contient une dépendance Kafka, il est nécessaire de l'exécuter comme suit :
```bash
camel run route-kafka.xml --dep camel.dependencies=org.apache.camel:camel-kafka
```


Si vous souhaitez que la sortie se fasse dans un fichier log, ajoutez l'option ci-dessous à la fin de la précédente commande :

```bash 
> output.log 
```

# Déroulement et résultat attendu de la route : 
Une fois lancé, la route camel envoie une requête get-HTTP vers l'API des temps d'attente de l'OPT. 

Cette dernière lui répond et la route reçoit le message de retour au format JSON. 
Les données sont ensuite poussées dans le topic kafka 'temps-attente', créé précédemment. 

Cette procédure est répétée toute les 5 minutes tant que la route n'est pas manuellement arrêtée. 

A noter que la route Camel formatte les données de façons à ce quelles soient sur une seule ligne afin que Kafka puissent l'intégrer.
Par ailleurs le champ idAgence est utilisé comme clé au niveau du topic Kafka.

Les messages reçu sont visibles via le conteneur Kowl en utilisant l'URL suivante https://localhost:8888/topics/temps-attente


## 🔖 Description des livrables

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
 
