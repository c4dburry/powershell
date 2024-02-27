##Computer EXPORT SCRIPT##
##ad_export_script.ps1


##created by Mathis Keyser
##created on 08.02.2024
##Version 1.0

##Script exports users attributes into .csv 


########USER DEFINED VALUES########

#Searchbase Übergeordnete OU wird ausgewählt
#Rechtsklick auf OU  -> Attribute -> Distingushed Name kopieren
$searchscope = "DC=hogwarts,DC=local"

#Pfadangabe wo die CSV abgelegt werden soll + Dateiname
#Default#### "C:\users\$env:UserName\Documents\"
#DefaultName#### "export.csv"
$exportpath = "C:\users\$env:UserName\Documents\"
$exportname = "export.csv"

#Default#### UTF8
#Angabe der Encoding ausgabe - 
$coding = "UTF8"


####################
####SCRIPT START####
####################

#Import active directory module for running AD cmdlets
	Import-Module ActiveDirectory
#Zusammenführen des Exportpath
	$exportpath = $exportpath+$exportname
#Export-Csv
	Get-ADComputer -Filter 'enabled -eq $true' -SearchBase $searchscope -Properties * | Select-Object Name,DisplayName,DistinguishedName,PrimaryGroup | Export-Csv $exportpath -NoTypeInformation -Encoding $coding


####################
####SCRIPT ENDE#####
####################