##Script for importing ad-user attributes by .csv

#setting variables
$path=""

#start of script
Import-CSV -Path $path | ForEach-Object {
    $ADUser = Get-ADuser -Filter ""
}