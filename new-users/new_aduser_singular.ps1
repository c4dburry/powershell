Import-Module ActiveDirectory
New-ADUser -Name Rfrank -GivenName frank -Surname reich -path "OU=Benutzer,OU=Hogwarts,DC=hogwarts,DC=local" -SamAccountName frankreich -UserPrincipalName frankreich@hogwarts.local -AccountPassword (ConvertTo-SecureString "Synergy2024!" -AsPlainText -Force) -EmailAddress frankreich@hogwarts.de -Enabled $true
