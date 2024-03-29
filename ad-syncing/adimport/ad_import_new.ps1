##import/update User-Properties
##Skript Testing mit diffrent Imports

$importdatei = "import_ZIP.csv"
#$importdatei = "default.csv"
#$importdatei = "clear.csv"

$import = $PSScriptRoot + "\" +$importdatei

Import-CSV $import | Foreach-Object { 

    $ldaphash = @{
        info                = $_.info;
    }
    #Get all keys that have null values and store in variable keystoremove 
    $keysToRemoveldap = $ldaphash.keys | Where-Object { 
        !$ldaphash[$_] 
    }
    #Foreach key, remove them from the hashtable 
    $keysToRemoveldap | Foreach-Object { 
        $ldaphash.remove($_) 
    }
#We are doing stuff in here
    $hashtable = @{
        Identity            = Get-ADuser -Filter "ObjectGUID -eq '$($_.ObjectGUID)'" -Properties *
        Company             = $_.Company;
        DisplayName         = $_.DisplayName;
        GivenName           = $_.GivenName;
        Surname             = $_.Surname;
        EmailAddress        = $_.EmailAddress;
        UserPrincipalName   = $_.UserPrincipalName;
        Title               = $_.title;
        description         = $_.description;
        Department          = $_.Department;
        #Office              = $_.office;
        OfficePhone         = $_.officephone;
        #fax                 = $_.fax;
        Mobile         = $_.mobile;
        StreetAddress       = $_.streetAddress;
        City                = $_.City;
        PostalCode          = $_.postalCode;
        State               = $_.State;
        #Country             = $_.Country;
        #HomePage            = $_.wWWHomePage;
        ErrorAction         = "Stop";
        Replace             = $ldaphash
                
    } 
    $keysToRemove = $hashtable.keys | Where-Object { 
        !$hashtable[$_] 
    }
    $keysToRemove | Foreach-Object { 
        $hashtable.remove($_) 

    }
    #If there are no LDAP properties to change, remove it from the main hash table 
    if ($ldaphash.count -eq 0)
    {
        $hashtable.remove("Replace")
    }
    Set-ADUser @hashtable -clear $keysToRemove
}
