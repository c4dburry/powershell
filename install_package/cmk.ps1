### Skript zur Installation des CheckMK Agents und
### Registrierung des Agenten
### 12.03.2024 - Hannover
### Mathis Keyser - Mathis.Keyser@it-syn.de


### CheckMK Agent installieren
Write-Host -ForegroundColor Green "Installation CheckMK Agent"

## Location zum aktuellen Verzeichnis setzen
$defaultlocale = "C:\"
$scriptlocal = $PSScriptRoot
Set-Location $scriptlocal
$registerbat = $scriptlocal + "\register.bat"

## Installation Start
Start-Process msiexec.exe -Wait -ArgumentList '/I check-mk-agent.msi /quiet /qn /norestart WIXUI_CLEANINSTALL='

# Installation Abgeschlossen
Write-Host -ForegroundColor Green "Installation abgeschlossen"

### CheckMK Agent registrieren
Write-Host -ForegroundColor Green "Register CheckMK Agent"
#"C:\install_package\register.bat"
#Start-Process cmd.exe /c $registerbat -Wait
Start-Process -Filepath $registerbat -Wait

#Location reset
Set-Location $defaultlocale