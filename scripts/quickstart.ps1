Write-Output "Début du script"

## Variables
$BROKER="localhost:9092"
$TOPIC="temps-attente"
# URL Kowl
$URL = "http://localhost:8888/topics/"+$TOPIC+"?o=-1&p=-1&s=50#messages"

# Exécute docker-compose pour démarrer les conteneurs
Write-Output "Lancement des conteneurs" 
docker-compose -f temps_attente.yml up -d

# ajouter un temps de pause de 5 secondes
Start-Sleep -Seconds 5

Write-Output "Vérification de l'existance du topic Kafka $TOPIC"
# vérifier si le topic existe
if (docker exec -it kafka kafka-topics.sh --bootstrap-server $BROKER --list | Select-String -Pattern "$TOPIC") {
    Write-Output "Le topic $TOPIC existe déjà."
} else {
    # créer un nouveau topic
    #docker exec -it kafka kafka-console-producer.sh --broker-list $BROKER --topic $TOPIC
    docker exec -it kafka kafka-topics.sh --bootstrap-server $BROKER --create --topic $TOPIC --partitions 1 --replication-factor 1


    # vérifier si la création du topic est réussie
    if ($LASTEXITCODE -eq 0) {
        Write-Output "Le topic $TOPIC a été créé avec succès."
    } else {
        Write-Output "La création du topic $TOPIC a échoué."
    }
}

# ajouter un temps de pause de 5 secondes
Start-Sleep -Seconds 5

Write-Output "Lancement de la route Camel API temps d'attente vers Kafka"
# Exécute Camel pour démarrer les routes Kafka
    #camel run route-kafka.xml route-kafka-json.xml --dep camel.dependencies=org.apache.camel:camel-kafka > camel-output.log &
    camel run route-kafka.xml route-kafka-json.xml --dep camel.dependencies=org.apache.camel:camel-kafka > camel-output.log &
# Affiche le PID du processus Camel
Write-Output "Le PID du processus Camel est : $PID"
Write-Output "Fin du script"

# ajouter un temps de pause de 5 secondes
Start-Sleep -Seconds 5

# Lancement de la page Kowl
Start-Process -FilePath $URL