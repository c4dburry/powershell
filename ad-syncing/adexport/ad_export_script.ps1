### Skript zum Export der Active Directory Users + Attributes
### 12.03.2024 - Hannover
### Mathis Keyser - Mathis.Keyser@it-syn.de
##Version 1.0

#Import active directory module for running AD cmdlets
Import-Module ActiveDirectory
#Domain Default OU wird gewählt
$searchscope=(Get-ADDomain | Select-Object  DistinguishedName).DistinguishedName
#Skript-Pfad wird gesetzt in Path Variable
$path=$PSScriptRoot

#Manuelle Anpassung Searchscope
#Rechsklick auf OU -> Attributes -> Distinguished Name
#$searchscope = "OU=Benutzer,OU=Hogwarts,DC=hogwarts,DC=local"

#Pfadangabe wo die CSV abgelegt werden soll + Dateiname
$exportname = "export.csv"
$timestamp = Get-Date -Format o | ForEach-Object { $_ -replace ":", "." }
$exportname = $timestamp + "-" + $exportname

### Starting Export
Write-Host -ForegroundColor Green "Starting Export"

#Zusammenführen des Exportpath
	$exportpath = $path+$exportname
#Export-Csv
	Get-ADUser -Filter 'enabled -eq $true' -SearchBase $searchscope -Properties * | Select-Object 		`
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
	| Export-Csv $exportpath -NoTypeInformation -Encoding UTF8

### Export Ende
Write-Host -ForegroundColor Green "Export Erstellt"