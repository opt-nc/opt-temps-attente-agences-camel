# Prérequis

* docker 
* camel-jbang


## Installer camel-jbang  
## Linux :
Note: Java n'a pas besoin d'être déjâ présent car jbang va le télécharger automatiquement si java 8 ou un JDK plus récent n'est pas détecté.
    
### 1. Installer jbang 
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

## Windows :
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
Ouvrir une invite de commande ou un terminal et exécuter la commande suivante :
``` bash 
jbang app install camel@apache/camel
``` 

# Utilisation de la route camel : 
Ouvrir un terminal ou une invite de commande puis exécuter les commandes suivantes :

* Lancement de l'API des temps d'attente en agence de l'optnc avec docker
``` bash 
docker run -d --rm -p 8080:8080 optnc/opt-temps-attente-agences-api:latest
```

* Lancement de la route camel 
``` bash 
camel run routeXML.xml
```
# Déroulement et résultat attendu de la route : 
Une fois lancé, la route camel envoie une requête get-HTTP vers l'API des temps d'attente de l'OPT. Cette dernière lui répond et la route reçoit le message de retour dans lequel se trouve les temps d'attente de toutes les agences du territoire. Dans la continuité, les données sont convertie au format CSV puis ajoutées au fichier **temps-attente.csv** se trouvant dans le dossier nommé **data**

Cette procédure est répétée toute les 5 minutes tant que la route n'est pas manuellement arrêtée. 
