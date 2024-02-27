##AD IMPORT SCRIPT##
##ad_import_script.ps1


##created by Mathis Keyser
##created on 08.02.2024
##Version 1.0

##Script imports users attributes from .csv 
##Best use with ad_export_script.ps1

########USER DEFINED VALUES########

$path="C:\users\$env:UserName\Documents\"
$filename="import.csv"


#####INFO#####
###Following attributes will be imported
#1#CITY
#2#Company  
#3#COUNTRY
#4#Department
#5#Description
#6#FAX
#7#OfficePhone
#8#office
#9#Organization
#10#state
#11#streetaddress
#12#Title
#13#wWWHomePage
#14#IpPHone
#15#Mobile
#16#Postalcode
#17#telephoneNumber
#18#info


##DO NOT SYNC AND WONT BE SYNCED
#19#emailaddress
#20#givenname
#21#surname
#22#DisplayName
#23#DistinguishedName
#24#samaccountname




####################
####SCRIPT START####
####################

#Import active directory module for running AD cmdlets
Import-Module ActiveDirectory
#Store the data from the csv in the $ADUsers variable
$pathname=$path+$filename
$USERS = Import-Csv -Path $pathname

#Loop through each row containing user details in the CSV file
$USERS | foreach {
  
  ### Organisation ###
	$company						= $_.'company' 
	$displayname                    = $_.'displayname'
	$DistinguishedName              = $_.'DistinguishedName'
	$samaccountname                 = $_.'samaccountname'  
    $givenname                    	= $_.'givenname'  
	$surname                       	= $_.'surname' 
	$emailaddress                   = $_.'emailaddress'  
	$UserPrincipalName              = $_.'UserPrincipalName'  
	$title                      	= $_.'title'     
	$description                    = $_.'description'     
	$info                        	= $_.'info'         
	$department                     = $_.'department'       
	$office                 		= $_.'office'     
	$officephone                    = $_.'officephone'    
	$telephoneNumber                = $_.'telephoneNumber'     
	$ipphone                  	    = $_.'ipphone'     
	$fax                      		= $_.'fax'         
	$mobile                	        = $_.'mobile'    
	$streetaddress                  = $_.'streetaddress'        
	$city							= $_.'city'      
	$Postalcode                	    = $_.'Postalcode'     
	$state                   		= $_.'state'     
	$country						= $_.'country'      
	$wWWHomePage                    = $_.'wWWHomePage'      

###Setting the Properties###
    Set-ADUSer -Identity $_.samaccountname -Postalcode $Postalcode -city $city -Company $company -Country $country -Department $department -Description $description -fax $fax -OfficePhone $officephone -office $office -Organization $organization -State $state -StreetAddress $streetaddress -Title $title -HomePage $wWWHomePage -Replace @{'ipPhone'=$ipphone; 'mobile'=$mobile; 'info'=$info} 
    }

####################
####SCRIPT ENDE#####
####################