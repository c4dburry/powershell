##import/update User-Properties
$importdatei = "ad-export\2024-03-03T17.26.31.6091817+01.00-export.csv"

Import-CSV $importdatei | Foreach-Object { 
    #We are doing stuff in here
    $ADUser = Get-ADuser -Filter "ObjectGUID -eq '$($_.ObjectGUID)'" -Properties *
    if ($_.mobile) {     
        $ADUser.MobilePhone = $_.mobile 
    }
    if ($_.City) {     
        $ADUser.City = $_.City 
    }  
    Set-ADUser -Instance $ADUser
}