$Mailboxes = Get-Mailbox -ResultSize Unlimited | ? { $_.ExchangeUserAccountControl -like "AccountDisabled" -and $_.RecipientTypeDetails -eq 'UserMailbox' } | select alias
$Mailboxes | Export-Csv $PSScriptRoot\export.csv -NoTypeInformation -Encoding UTF8
foreach ($mailbox in $Mailboxes) {
    Disable-Mailbox -DomainController DC.domain.local -identity $mailbox.alias 
} 