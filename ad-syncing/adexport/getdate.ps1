$timestamp = Get-Date -Format o | ForEach-Object { $_ -replace ":", "." }
$timestamp = Get-Date -Format "yyyyMMdd_HH-mm"

Write-Host $timestamp

