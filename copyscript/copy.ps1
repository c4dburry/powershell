$sourcepath = "\\netshare\Applications\TeamViewerQS"
$targetpath = "C:\QS\"

if (-not (Test-Path -Path $targetpath)) {
    New-Item -ItemType Directory -Path $targetpath | Out-Null
}
Copy-Item -Path $sourcepath\*.* -Destination $targetpath -Recurse -Force -Verbos