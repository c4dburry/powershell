$Mailboxes = Get-Mailbox -ResultSize Unlimited | ? { $_.ExchangeUserAccountControl -like "AccountDisabled" -and $_.RecipientTypeDetails -eq 'UserMailbox' } | select alias

foreach ($mailbox in $Mailboxes) {
    New-MailboxExportRequest -DomainController SBER01-DC01.brasst.local -mailbox $mailbox.alias -FilePath \\SBER02-EXCH01\Exports\script\$mailbox.pst
} 