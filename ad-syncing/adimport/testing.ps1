#Get-Aduser -Identity "dueses" -Properties * | Select country
#Set-ADUser -Identity "dueses" -c GB
#Set-ADUser -Identity "dueses" -replace @{country="DE"}
#Set-ADUser -Identity "dueses" -clear c


#Get-Aduser -Identity "dueses" -Properties * | Select info
#Set-ADUser -Identity "dueses" -replace @{info="handwerker"}
#Set-ADUser -Identity "dueses" -clear c


#Get-Aduser -Identity "dueses" -Properties * | Select wWWHomePage
#Set-ADUser -Identity "dueses" -replace @{info="handwerker"}
Set-ADUser -Identity "dueses" -clear HomePage