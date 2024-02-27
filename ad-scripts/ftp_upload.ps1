#ftp shell script

#authentication
$username = "user"
$password = "password"

# files/paths
$LocalDir = "\\Server\uploads"
$LatestTextFile = Get-ChildItem -Path $LocalDir -Filter *.csv | Sort-Object -Property CreationTime -Descending | Select-Object -First 1
$RemoteFile = "ftp://servername/$($LatestTextFile.Name)"
 
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