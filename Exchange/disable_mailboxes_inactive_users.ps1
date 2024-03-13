### Skript zum Deaktivieren von Postfächern von Deaktivierten Usern
### 13.03.2024 - Hannover
### Mathis Keyser - Mathis.Keyser@it-syn.de
### Version 1.0

#Listet die deaktivieren User-Aliase in die Variable 
$Mailboxes = Get-Mailbox -ResultSize Unlimited | ? { $_.ExchangeUserAccountControl -like "AccountDisabled" -and $_.RecipientTypeDetails -eq 'UserMailbox' } | Select-Object alias
#Export der Variablen
#$Mailboxes | Export-Csv $PSScriptRoot\export.csv -NoTypeInformation -Encoding UTF8
foreach ($mailbox in $Mailboxes) {
    Disable-Mailbox -DomainController DC.domain.local -identity $mailbox.alias 
} 