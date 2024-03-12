### Skript zur Installation des CheckMK Agents und
### Registrierung des Agenten
### 12.03.2024 - Hannover
### Mathis Keyser - Mathis.Keyser@it-syn.de


### CheckMK Agent installieren
Write-Host -ForegroundColor Green "Installation CheckMK Agent"

## Location zum aktuellen Verzeichnis setzen
$defaultlocal = (Get-Location.path)
Write-Host $defaultlocal
$setlocal =

## Dateiname
$file = "check-mk-agent.msi"

## Installation Start
Start-Process msiexec.exe -Wait -ArgumentList '/I check-mk-agent.msi /quiet /qn /norestart WIXUI_CLEANINSTALL='

# Ende
Write-Host -ForegroundColor Green "Installation abgeschlossen"

### CheckMK Agent registrieren
Write-Host -ForegroundColor Green "Register CheckMK Agent"
Write-Host $setlocal
#Start-Process cmd.exe /c $setlocal\register.bat -Wait

#Location reset
Set-Location "C:\"
Get-Location | Write-Host -ForegroundColor Red