### Construction des URL de tests
$actuatorUri = "http://localhost:8080/actuator"
$healthUri = $actuatorUri +"/health"
$infoUri = $actuatorUri +"/info"

### HealtTestURI
Try {
    $healthTestUri =  Invoke-WebRequest -Uri $healthUri -UseBasicParsing
    $healthStatusCode = $healthTestUri.StatusCode 
           
    If ($healthStatusCode -eq "200"){
    Write-Host "API HealthTest OK :" $healthStatusCode
    }Else {
        Write-Host "API HealthTest KO :" $healthStatusCode
    }

}Catch{
    $healthStatusCode = $_.Exception.Response.StatusCode.value__
}

### InfoTestURI
Try {
    $infoTestUri =  Invoke-WebRequest -Uri $infoUri -UseBasicParsing
    $infoStatusCode = $healthTestUri.StatusCode 

    If ($infoStatusCode -eq "200"){
        Write-Host "API InfoTest OK :" $infoStatusCode
    }Else {
        Write-Host "API InfoTest KO :" $infoStatusCode
    }

}Catch{
    $infoStatusCode = $_.Exception.Response.StatusCode.value__
}


### Test de récupération du csv de toutes les agences
If (($healthTestUri.StatusCode -eq "200") -and  ($healthTestUri.StatusCode -eq "200")) {
    $webdata = Invoke-WebRequest -Uri http://localhost:8080/temps-attente/agences -UseBasicParsing

    write-host "Récupération des données des agences en cours..."
    $releases = ConvertFrom-Json $webdata.Content
    write-host "Récupération des données des agences terminée."

    ### Export des données dans un fichier CSV
    if ($releases) {
       $releases | Export-Csv .\agences.csv -delimiter ';' -NoTypeInformation
        $file = Get-ChildItem agences.csv
        Write-Host "Le fichier" $file.Name "a été créé dans le répertoire courant."
    }

    Write-Host "L'API contient" $releases.Count "agences."

    ### Test pour une agence
    $4161 = Invoke-WebRequest -Uri http://localhost:8080/temps-attente/agence/4161 -UseBasicParsing
    Write-host "Détail de l'agence 4161" -ForegroundColor Green
    $4161
}

