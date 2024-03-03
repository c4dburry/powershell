Import-Module ActiveDirectory
$pfad = "OU=Benutzer,OU=Hogwarts,DC=hogwarts,DC=local"
Import-Csv ".\new-users\ImportADUsers.csv" -Delimiter ',' |


ForEach-Object { 
New-ADUser `
-Name $_.DisplayName `
-GivenName $_.givenname `
-Surname $_.surname `
-Path $pfad `
-SamAccountName $_.samAccountName `
-UserPrincipalName ($_.samAccountName + '@' + $env:userdnsdomain) `
-AccountPassword (ConvertTo-SecureString "Synergy2024!" -AsPlainText -Force) `
-EmailAddress $_."E-Mail Address" `
-Enabled $true `
-ChangePasswordAtLogon $false
} 