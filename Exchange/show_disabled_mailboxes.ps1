### Skript zum deaktiviere Postfächer anzeigen lassen
### 13.03.2024 - Hannover
### Mathis Keyser - Mathis.Keyser@it-syn.de
### Version 1.0

$dbs = Get-MailboxDatabase
$dbs | ForEach-Object {Get-MailboxStatistics -Database $_.DistinguishedName} | Where-Object {$_.DisconnectReason -eq "Disabled"} | Format-Table DisplayName,Database,DisconnectDate