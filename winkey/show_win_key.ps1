#script for showing Windows License Key
#2024-03-20
#works on win10 upwards
powershell "(Get-WmiObject -query 'select * from SoftwareLicensingService').OA3xOriginalProductKey"