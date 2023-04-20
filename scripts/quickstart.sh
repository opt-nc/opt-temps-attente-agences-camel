#!/bin/bash

# Variables
BROKER="localhost:9094"
TOPIC="temps-attente"
# URL RedPanda
URL="http://0.0.0.0:8081/topics/$TOPIC?o=-1&p=-1&q&s=50#messages"

# Exécute docker-compose pour démarrer les conteneurs
echo "Lancement des conteneurs" 
docker-compose -f temps_attente.yml up -d

# ajouter un temps de pause de 5 secondes
sleep 5

echo "Vérification de l'existance du topic Kafka $TOPIC"
# vérifier si le topic existe
if #sudo docker exec -it kafka_tps_attente_kml kafka-topics.sh --bootstrap-server $BROKER --list | grep -q "$TOPIC"; then
    kafkacat -b $BROKER -L | grep -q "$TOPIC"; then
    echo "Le topic $TOPIC existe déjà."
else
    # créer un nouveau topic
    #docker exec -it kafka_tps_attente_kml kafka-console-producer.sh --broker-list $BROKER --topic $TOPIC
    docker exec -it kafka_tps_attente_kml kafka-topics.sh --bootstrap-server $BROKER --create --topic $TOPIC --partitions 1 --replication-factor 1

    # vérifier si la création du topic est réussie
    if [ $? -eq 0 ]; then
        echo "Le topic $TOPIC a été créé avec succès."
    else
        echo "La création du topic $TOPIC a échoué."
    fi
fi

# ajouter un temps de pause de 5 secondes
sleep 5

echo "Lancement de la route Camel API temps d'attente vers Kafka"
# Exécute Camel pour démarrer les routes Kafka
camel run route-kafka.xml route-kafka-json.xml --dep camel.dependencies=org.apache.camel:camel-kafka > camel-output.log & PID=$!
# Affiche le PID du processus Camel
echo "Le PID du processus Camel est : $PID"
echo "Fin du script"

# ajouter un temps de pause de 5 secondes
sleep 5

# Lancement de la page Kowl
xdg-open $URL