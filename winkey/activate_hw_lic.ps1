#This script performs automatic activation during windows deployments.
#It will check if Windows is activated, if not it will try to activate with the BIOS key.

#Activation function, installs the specified product key and returns true or false if activated successfully.
function Activate
{
    #If $key doesn't exist we can't activate
    if (-not $key) { return }
    
    try
    {
    $instance = (Get-WmiObject -query 'select * from SoftwareLicensingService')
    $instance.InstallProductKey($key)
    $instance.RefreshLicenseStatus()
    } catch { return }
}

#First check and see if windows is already activated.
if (Get-WmiObject SoftwareLicensingProduct | Where-Object {$_.PartialProductKey -and $_.Name -like "*Windows*" -and ($_.LicenseStatus -eq 1 -or $_.LicenseStatus -eq 2)})
{
    #Host is already activated.
    exit
}

#Check for a BIOS key - if it exists, this is what we are going to use first.
$key = (Get-WmiObject -query 'select * from SoftwareLicensingService').OA3xOriginalProductKey

if ($key) 
{
    #BIOS Key exists - use it
    if (Activate $key) { exit }
}