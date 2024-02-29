#script for showing Windows License Key
powershell "(Get-WmiObject -query 'select * from SoftwareLicensingService').OA3xOriginalProductKey"