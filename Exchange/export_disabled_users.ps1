### Skript zum Exportieren der Postfächer von deaktivierten Usern
### 13.03.2024 - Hannover
### Mathis Keyser - Mathis.Keyser@it-syn.de
### Version 1.0

$Mailboxes = Get-Mailbox -ResultSize Unlimited | Where-Object { $_.ExchangeUserAccountControl -like "AccountDisabled" -and $_.RecipientTypeDetails -eq 'UserMailbox' } | Select-Object alias
ForEach ($mailbox in $Mailboxes) {
    New-MailboxExportRequest -DomainController DC.domain.local -mailbox $mailbox.alias -FilePath \\netshare\Exports\script\$mailbox.pst
} 