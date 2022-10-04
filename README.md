# ❔ A propos

Cette repo s'inscrit dans le cadre d'un projet conjoint OPT-NC et l'[UNC](https://unc.nc/).

- Le sujet est fourni par l'OPT-NC
- La réalisation est assurée par les étudiants avec en support l'OPT

# ℹ️ Contexte OPT

[L'OPT utilise Kafka](https://kafka.apache.org/powered-by) pour partager et transformer un volume toujours plus important entre ses métier. Nous souhatns maintenant nous attaquer à diverses manières de consommer ces données à moindre effort... puis de les valoriser via des solutions dédiées à la chose.

![image](https://user-images.githubusercontent.com/5235127/193949632-d079458c-47a4-4c34-83d1-6cd30c46eca4.png)

Les résultats de cette expérimentation seront recyclés de manière opérationelle, tant sur les méthodes utilisées que sur les analyses de données produites.

# 🤹🏻 Compétences

- Data Engineering
- Datascientist

#  🧑‍🤝‍🧑 Equipe

- 🧑‍🤝‍🧑 [Antoine GINDRE](https://www.linkedin.com/in/antoine-a-gindre/) (aka. [`@AntoineArthurG`](https://github.com/AntoineArthurG)): développeur
- 🧑‍🤝‍🧑 Kenneth WINCHESTER :  : développeur
- 👨‍🎨 [Adrien SALES](https://www.linkedin.com/in/adrien-sales/) : Product Owner, Architecte

# 🎯 Pitch

Via des outils existants et industriels, configurer une intégration idéalement basée sur de la configuration de données qui : 

1. Via [Apache Camel](https://camel.apache.org/) Consomme les donées de l'[API des temps d'attente en agence](https://github.com/opt-nc/opt-temps-attente-agences-api)
2. Via une route Camel, pousser les données du Poll dans un `csv`
3. Via un **Poll régulier depuis Camel**, pousser les données dans un topic dédié Kafka
4. Via Camel, consommer les messages et les pousser dans une instance OpenSearch
5. Construire un ou des tableaux de bord, utiliser les fonctionnalités de geolocalisation, et explorer les fonctionnalités IA et ML d'OpenSearch
6. **BONUS*** : Via Camel, consommer les messages Kafka et les pousser dans une instance [Apache Spark](https://spark.apache.org/)

# 🗺️ Architecture

Un [draft de haut niveau de l'architecture cible](https://miro.com/app/board/uXjVPTe9O_o=/) : 

![image](https://user-images.githubusercontent.com/5235127/193950043-f36aadd3-e485-4f6b-bd7d-b98b287634d7.png)


# ℹ️ NB

- Les interactions avec Camel passeront idéalement par [JBang!](https://camel.apache.org/manual/camel-jbang.html)
- Une démo [KillerCod](https://killercoda.com/opt-labs/)a sera livrée et intégrée aux cours de l'OPT-NC... et pourra servir de support lors des démos, voire lors de la soutenance
- Les images Docker ou docker-compose seront utilisées pour dépoyer Kafka, OpenSearch, Spark, ...
