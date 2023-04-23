# ☝️ Prérequis

Les éléments suivant doivent-être installés (cf. liens d'installation ci-dessous) :

- [`docker`](https://docs.docker.com/engine/install/)
- [`KafkaCat`](https://github.com/edenhill/kcat)
- [`sdkman`](https://sdkman.io/)


# 🧰 Tools

## 📥 `JBang!`

Install [`Camel-JBang `](https://www.jbang.dev/download/) :

```shell
sdk install jbang && jbang app setup
```

## 🐪 `Camel-JBang`

[`Camel-JBang`](https://camel.apache.org/manual/camel-jbang.html)


```shell
jbang app install camel@apache/camel
```

## 👂 Ports

Les ports suivant doivent-être libres pour que les conteneurs Docker puissent fonctionner :

- `8080` : [`optnc/opt-temps-attente-agences-api`](https://hub.docker.com/r/optnc/opt-temps-attente-agences-api)
- `8888` : [`red-panda-console`](https://github.com/redpanda-data/console)
- `9092/9093` : [`bitnami/kafka`](https://hub.docker.com/r/bitnami/kafka)
- `2181` : [`docker.io/bitnami/zookeeper:latest`](https://hub.docker.com/r/bitnami/zookeeper/)

 ## 🚀 Démarer

```shell
gh repo clone opt-nc/opt-temps-attente-agences-camel
cd opt-temps-attente-agences-camel/scripts
```

 Exécuter `quickstart.sh`:

```shell
./quickstart.sh`
```

:warning: A noter qu'il sera sans doute nécessaire d'actualiser la page RedPanda pour que le flux de données soit visible.
