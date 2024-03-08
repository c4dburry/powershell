Get-Aduser -Identity dueses -Properties * | Select-Object *

Set-AdUser -Identity dueses -clear facsimileTelephoneNumber


Get-Date -Format o