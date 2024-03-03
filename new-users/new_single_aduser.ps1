Import-Module ActiveDirectory
#Setting User-Settings
$Name = "Name des AD Objekts"
$givenName = "Vorname"
$surname = "nachname"
$path = "OU=Benutzer,OU=Hogwarts,DC=hogwarts,DC=local"
$sam = "samAccountName"
$upn = "UserPrincipleName"
$email = "Email Adresse "
$Password = "Synergy2024$"
$enabled = $true #boolean

New-ADUser -Name $name -GivenName $givenName -Surname $surname `
-path $path `
-SamAccountName $sam `
-UserPrincipalName $upn `
 -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) `
 -EmailAddress $email `
 -Enabled $enabled
