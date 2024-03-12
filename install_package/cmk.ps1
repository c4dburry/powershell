### Skript zur Installation des CheckMK Agents und
### Aktivierung der benötigten Firewall-Ausnahmen
### 11.11.2020 - Helau :)
### Jan Kappen - j.kappen@building-networks.de
#
### CheckMK Agent installieren
Write-Host -ForegroundColor Green "Installation CheckMK Agent"
Start-Process msiexec.exe -Wait -ArgumentList '/I C:\install\check_mk_agent_1.6.msi /quiet /qn /norestart'
### Firewall Regeln erstellen / aktivieren
# CheckMK Agent Regel
Write-Host -ForegroundColor Green "Erstellung Firewall-Regel CheckMK Agent"
New-NetFirewallRule -Name check_mk -DisplayName "Check_MK Monitoring Agent" -Enabled True -Direction Inbound -Profile Domain,Private,Public -Protocol TCP -LocalPort 6556 -Program "%ProgramFiles(x86)%\checkmk\service\check_mk_agent.exe"
# ICMPv4 erlauben und für alle Profile aktivieren
Write-Host -ForegroundColor Green "Aktivierung von ICMPv4 in Windows Firewall"
Get-NetFirewallRule -Name FPS-ICMP4-ERQ-In | Enable-NetFirewallRule
Set-NetFirewallRule -name FPS-ICMP4-ERQ-In -Profile Domain,Private,Public
# Ende
Write-Host -ForegroundColor Green "Installation abgeschlossen"