### Skript zum Export und Upload der User-Daten vom AD
### 12.03.2024 - Hannover
### Mathis Keyser - Mathis.Keyser@it-syn.de
##Version 1.0


#Import active directory module for running AD cmdlets
Import-Module ActiveDirectory
#Domain Default OU wird gewählt
$searchscope=(Get-ADDomain | Select-Object  DistinguishedName).DistinguishedName
#Skript-Pfad wird gesetzt in Path Variable
$path=$PSScriptRoot
$path=$path+"\"

#Manuelle Anpassung Searchscope
#Rechsklick auf OU -> Attributes -> Distinguished Name
#$searchscope = "OU=Benutzer,OU=Hogwarts,DC=hogwarts,DC=local"

#Pfadangabe wo die CSV abgelegt werden soll + Dateiname
$exportname = "export.csv"
$timestamp = Get-Date -Format "yyyyMMdd_HH-mm" | ForEach-Object { $_ -replace ":", "." }
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


#authentication + server
$username = "user"
$password = "password"
$server = "server"
$client = "testing"

# files/paths
$localdir = $PSScriptRoot
$dir = $localdir+"\adexport\"
# create latest export file and remote-file
$LatestTextFile = Get-ChildItem -Path $dir -Filter *.csv | Sort-Object -Property CreationTime -Descending | Select-Object -First 1
$RemoteFile = "ftp://$server/private/$client/$($LatestTextFile.Name)"
 
write-host "----------RFILE------------"
Write-Host $RemoteFile
write-host "----------LATESTFILE------------"
Write-Host $LatestTextFile
write-host "--------LOCALDIR-------------"
Write-Host $localdir
write-host "---------DIR-----------"
Write-Host $dir

# Create FTP Request Object
$FTPRequest = [System.Net.FtpWebRequest]::Create("$RemoteFile")
$FTPRequest = [System.Net.FtpWebRequest]$FTPRequest
$FTPRequest.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile
$FTPRequest.Credentials = new-object System.Net.NetworkCredential($Username, $Password)
$FTPRequest.UseBinary = $true
$FTPRequest.UsePassive = $true
# Read the File for Upload
$FileContent = Get-Content -Encoding Byte -Path $LatestTextFile.FullName
$FTPRequest.ContentLength = $FileContent.Length
# Get Stream Request by bytes
$Run = $FTPRequest.GetRequestStream()
$Run.Write($FileContent, 0, $FileContent.Length)
# Cleanup
$Run.Close()
$Run.Dispose()