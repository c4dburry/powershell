### Skript zum Upload des AD-Exports
### 12.03.2024 - Hannover
### Mathis Keyser - Mathis.Keyser@it-syn.de
##Version 1.0

#authentication + server
$username = "user"
$password = "password"
$server = "server"
$client = "testing"

# files/paths
$localdir = $PSScriptRoot
$dir = $localdir+"\adexport\"
# create latest export file and remote-file
$LatestTextFile = Get-ChildItem -Path $dir -Filter *.csv | Sort-Object -Property CreationTime -Descending | Select-Object -First 1
$RemoteFile = "ftp://$server/private/$client/$($LatestTextFile.Name)"
 
write-host "----------RFILE------------"
Write-Host $RemoteFile
write-host "----------LATESTFILE------------"
Write-Host $LatestTextFile
write-host "--------LOCALDIR-------------"
Write-Host $localdir
write-host "---------DIR-----------"
Write-Host $dir

# Create FTP Request Object
$FTPRequest = [System.Net.FtpWebRequest]::Create("$RemoteFile")
$FTPRequest = [System.Net.FtpWebRequest]$FTPRequest
$FTPRequest.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile
$FTPRequest.Credentials = new-object System.Net.NetworkCredential($Username, $Password)
$FTPRequest.UseBinary = $true
$FTPRequest.UsePassive = $true
# Read the File for Upload
$FileContent = Get-Content -Encoding Byte -Path $LatestTextFile.FullName
$FTPRequest.ContentLength = $FileContent.Length
# Get Stream Request by bytes
$Run = $FTPRequest.GetRequestStream()
$Run.Write($FileContent, 0, $FileContent.Length)
# Cleanup
$Run.Close()
$Run.Dispose()