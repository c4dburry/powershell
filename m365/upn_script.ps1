#Abfrage USER aus einer OU

Get-ADUser -Filter * -pr    * -SearchBase "OU=TEST,DC=TEST,DC=local"



#primäre SMTP-Mailadresse auf den UPN übertragen bzw. der UPN entsprechend angepasst wird.

$user = get-aduser -Filter * -Properties * -SearchBase "OU=TEST,DC=TEST,DC=local" | Select-Object samaccountname, mail

foreach ($users in $user) {

     write-host processing $user.samaccountname -nonewline



     [string]$sam = $users.samaccountname

     [string]$upn = $users.mail



     if ($user.UserPrincipalName -eq $upn){

       write-host "  UPN bereits ok: $upn" -background green -foreground black

       }

       else {

        set-aduser -identity $sam -UserPrincipalName $upn

        write-host "  UPN wurde angepasst:$upn" -backgroundcolor red

       }

}