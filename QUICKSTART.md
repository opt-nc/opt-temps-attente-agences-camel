# __QuickStart__

## 🧰 Prérequis

Les éléments suivant doivent-être installés (cf. liens d'installation ci-dessous) :

* <a href="https://docs.docker.com/engine/install/" target="_blank"> Docker </a>
* <a href="https://www.jbang.dev/documentation/guide/latest/installation.html" target="_blank"> JBang </a>
* <a href="https://camel.apache.org/manual/camel-jbang.html" target="_blank"> Camel-JBang </a>

Les ports suivant doivent-être libres pour que les conteneurs Docker puissent fonctionner :

* 8080 - opt-temps-attente-agences-api
* 8888 - kowl
* 9092 / 9093 - kafka
* 2181 - zookeeper

Ajouter dans le fichier host la ligne suivante :
```bash
127.0.0.1 kafka
```

 ## 🧑 Mode opératoire ‍🎓

 * Lancer un invite de commande (bash, PowerShell, Terminal Windows)
 * Se placer dans le dossier _scripts_
 * Exécuter le fichier _.ps1_ pour Windows/Linux (si Powershell est installé) ou _.sh_ pour Linux. 
 
![image](https://github.com/opt-nc/opt-temps-attente-agences-camel/blob/20-fournir-quickstartmd/doc/shell.png)

A noter qu'il sera sans doute nécessaire d'actualiser la page Kowl pour que le flux de données soit visible.
![image](https://github.com/opt-nc/opt-temps-attente-agences-camel/blob/20-fournir-quickstartmd/doc/kowl.png)