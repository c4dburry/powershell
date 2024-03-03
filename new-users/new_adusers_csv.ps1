Import-Module ActiveDirectory
$pfad = "OU=Benutzer,OU=Hogwarts,DC=hogwarts,DC=local"
$password = "Synergy2024!"

Import-Csv ".\new-users\ImportADUsers.csv" -Delimiter ',' |
ForEach-Object { 

New-ADUser -Name $_.name `
-Path $pfad `
-AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) `
-GivenName $_.givenname `
-Surname $_.surname `
-SamAccountName $_.samAccountName `
-StreetAddress $_.street `
-City $_.street `
-State $_.state `
-PostalCode $_.zip `
-country $_.country `
-EmailAddress $_."emailaddress" `
-Description $_.description `
-UserPrincipalName $_.upn `
-Enabled $true `
-ChangePasswordAtLogon $false
} 