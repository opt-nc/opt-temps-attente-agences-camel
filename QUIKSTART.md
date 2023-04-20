# __QuickStart__

## 🧰 Prérequis

Les éléments suivant doivent-être installés (cf. liens d'installation ci-dessous) :

* <a href="https://docs.docker.com/engine/install/" target="_blank"> Docker </a>
* <a href="https://www.jbang.dev/documentation/guide/latest/installation.html" target="_blank"> JBang </a>

`
sdk install jbang && jbang app setup
`
* <a href="https://camel.apache.org/manual/camel-jbang.html" target="_blank"> Camel-JBang </a>

`jbang app install camel@apache/camel`
* KafkaCat : 
 
`sudo apt install -y kafkacat`

Les ports suivant doivent-être libres pour que les conteneurs Docker puissent fonctionner :

* 8080 - opt-temps-attente-agences-api
* 8888 - kowl
* 9092 / 9093 - kafka
* 2181 - zookeeper

 ## 🧑 Mode opératoire ‍🎓

 * Lancer une invite de commande bash
 * Se placer dans le dossier _scripts_ 

`cd scripts`
 * Exécuter le fichier _.sh_ pour Linux.

 `./quickstart.sh`
 
:warning: A noter qu'il sera sans doute nécessaire d'actualiser la page RedPanda pour que le flux de données soit visible.
