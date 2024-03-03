##import/update User-Properties
$importdatei = "ad-export\2024-03-03T17.26.31.6091817+01.00-export.csv"

Import-CSV $importdatei | Foreach-Object { 
    #We are doing stuff in here
    $hashtable = @{
        Identity            = Get-ADuser -Filter "ObjectGUID -eq '$($_.ObjectGUID)'" -Properties *
        Company             = $_.Company
        DisplayName         = $_.DisplayName
        GivenName           = $_.GivenName;
        Surname             = $_.Surname;
        EmailAddress        = $_.EmailAddress;
        UserPrincipalName   = $_.UserPrincipalName;
        Title               = $_.title;
        description         = $_.description;
        info                = $_.info;
        Department          = $_.Department;
        Office              = $_.office;
        OfficePhone         = $_.officephone;
        ipphone             = $_.telephoneNumber;
        fax                 = $_.fax;
        MobilePhone         = $_.mobile;
        StreetAddress       = $_.streetAddress;
        City                = $_.City;
        PostalCode          = $_.postalCode;
        State               = $_.State;
        Country             = $_.Country;
        wWWHomePage         = $_.wWWHomePage;

        ErrorAction         = "Stop"
    } 
     
    $keysToRemove = $hashtable.keys | Where-Object { 
        !$hashtable[$_] 
    }

    $keysToRemove | Foreach-Object { 
        $hashtable.remove($_) 
    }

    Set-ADUser @hashtable
}