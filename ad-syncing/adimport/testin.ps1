#Import active directory module for running AD cmdlets
Import-Module ActiveDirectory

#Log file details
$currentDate = Get-Date -Format "dd-MM-yyyy_HH-mm-ss"
$Logfile = "C:\logs\$currentDate.log"
function WriteLog
{
Param ([string]$LogString)
$Stamp = (Get-Date).toString("dd/MM/yyyy HH:mm:ss")
$LogMessage = "$Stamp $LogString"
Add-content $LogFile -value $LogMessage
}

#Store the data from the csv in the $ADUsers variable
$ADUsers = Import-Csv -Path "C:\Users\mathis.keyser\Documents\mathis-neu.csv"

#Loop through each row containing user details in the CSV file
foreach ($User in $ADUsers) {

  ### Organisation ###
      $city                     		 = $User.'city'
      $cn                     			 = $User.'cn'
      $co                      			 = $User.'co'
      $company                    		 = $User.'company'
      $country                    		 = $User.'country'
      $department                      	 = $User.'department'
      $description                       = $User.'description'
      $displayname                       = $User.'displayname'
      $emailaddress                      = $User.'emailaddress'
      $facsimileTelephoneNumber          = $User.'facsimileTelephoneNumber'
      $fax                      		 = $User.'fax'
      $givenname                    	 = $User.'givenname'
      $homephone                      	 = $User.'homephone'
      $info                        	 	 = $User.'info'
      $ipphone                  	     = $User.'ipphone'
      $mail                     		 = $User.'mail'
      $mobilephone                       = $User.'mobilephone'
      $mobile                	         = $User.'mobile'
      $name                              = $User.'name'
      $office                 		     = $User.'office'            
      $officephone                       = $User.'officephone'
      $organization                      = $User.'organization'
      $pager                   		     = $User.'pager'
      $physicalDeliveryOfficeName        = $User.'physicalDeliveryOfficeName'
      $POBox                    		 = $User.'POBox'
      $Postalcode                	     = $User.'Postalcode'
      $samaccountname                    = $User.'samaccountname'
      $sn                      			 = $User.'sn'
      $state                   			 = $User.'state'
      $streetaddress                     = $User.'streetaddress'
      $surname                       	 = $User.'surname'
      $telephoneNumber                   = $User.'telephoneNumber'
      $title                      		 = $User.'title'
      $UserPrincipalName                 = $User.'UserPrincipalName'
      $wWWHomePage                       = $User.'wWWHomePage'
      
  # Check to see if the user already exists in AD
  # Write-Output "Checking user account for '$UserPrincipalName'"
 Try{
    If ($u = Get-ADUser -Filter {UserPrincipalName -eq $UserPrincipalName} -SearchBase "OU=it & synergy GmbH,DC=zip,DC=local" -ErrorAction Stop) {
            #User does exist then proceed to update the user account
            Try{
                $u | Set-ADUSer -Replace @{city=$city; cn=$cn, co=$co; company=$company; country=$country; department=$department; description=$description; facsimileTelephoneNumber=$facsimileTelephoneNumber; fax=$fax; homephone=$homephone; info=$info; ipphone=$ipphone; mobilephone=$mobilephone; office=$office, officephone=$officephone; organization=$organization, Postalcode=$Postalcode; state=$state; streetaddress=$streetaddress; telephoneNumber=$telephoneNumber; title=$title; wWWHomePage=$wWWHomePage}
                WriteLog "Updated properties for '$UserPrincipalName'"
            }
            Catch{
                WriteLog "Error Updating account details for '$UserPrincipalName'"
                WriteLog $_.Exception.Message
                Continue
            }
        }
    }
    Catch{
        #If user does NOT exist, give a warning
        WriteLog "WARNING: A user account with username '$Email' does not exist in Active Directory."
        WriteLog $_.Exception.Message
        Continue
    }
}



#fix missing