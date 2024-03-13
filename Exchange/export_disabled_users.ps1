$Mailboxes = Get-Mailbox -ResultSize Unlimited | ? { $_.ExchangeUserAccountControl -like "AccountDisabled" -and $_.RecipientTypeDetails -eq 'UserMailbox' } | select alias

foreach ($mailbox in $Mailboxes) {
    New-MailboxExportRequest -DomainController DC.domain.local -mailbox $mailbox.alias -FilePath \\netshare\Exports\script\$mailbox.pst
} 