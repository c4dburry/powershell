#User anlage
$user = "username"
$password = "password"
$password = ConvertTo-SecureString -String $password
$description = "Beschriftung"
$fullname = "Anzeigename"


#create user
New-LocalUser -Name $user -Password $password -Description $description -FullName $fullname -AccountNeverExpires
Add-LocalGroupMember -Group Administrators -Member $user