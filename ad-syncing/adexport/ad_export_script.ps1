##AD EXPORT SCRIPT##
##ad_export_script.ps1

##created by Mathis Keyser
##created on 08.02.2024
##Version 1.0

##Script exports users attributes into .csv 


########USER DEFINED VALUES########

#Searchbase Übergeordnete OU wird ausgewählt
#Rechtsklick auf OU  -> Attribute -> Distingushed Name kopieren
$searchscope = "OU=Benutzer,OU=Hogwarts,DC=hogwarts,DC=local"

#Pfadangabe wo die CSV abgelegt werden soll + Dateiname
#Default#### "C:\users\$env:UserName\Documents\"
#DefaultName#### "export.csv"
$exportpath = "C:\users\$env:UserName\Documents\powershell\ad-export\"
$exportname = "export.csv"
$timestamp = Get-Date -Format o | ForEach-Object { $_ -replace ":", "." }
$exportname = $timestamp + "-" + $exportname

#Angabe der Encoding ausgabe - 
#Default#### UTF8
$coding = "UTF8"


$explicitsearch = ""
if ($null -eq $expsearch) {
	$explicitsearch =""
	else {
		$explicitsearch ="-SearchBase $searchscope"
	}
}



####################
####SCRIPT START####
####################

#Import active directory module for running AD cmdlets
	Import-Module ActiveDirectory
#Zusammenführen des Exportpath
	$exportpath = $exportpath+$exportname
#Export-Csv
	Get-ADUser -Filter 'enabled -eq $true' $explicitsearch -Properties * | `
	Select-Object 		`
	company,			`
	ObjectGUID,			`
	objectSid,			`
	DisplayName,		`
	DistinguishedName,	`
	samaccountname,		`
	givenname,			`
	surname,			`
	emailaddress,		`
	UserPrincipalName,	`
	title,				`
	description,		`
	info,				`
	department,			`
	office,				`
	officephone,		`
	telephoneNumber,	`
	ipphone,			`
	fax,				`
	mobile,				`
	streetaddress,		`
	city,				`
	Postalcode,			`
	state,				`
	country,			`
	wWWHomePage 		`
	| Export-Csv $exportpath -NoTypeInformation -Encoding $coding

####################
####SCRIPT ENDE#####
####################
####################