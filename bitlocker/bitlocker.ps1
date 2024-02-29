Enable-Bitlocker -MountPoint $env:SystemDrive -EncryptionMethod XtsAes128 -SkipHardwareTest -UsedSpaceOnly -TpmProtector
Add-BitLockerKeyProtector -MountPoint $env:SystemDrive -RecoveryPasswordProtector
$BitLockedComputer = $env:ComputerName
$RecoveryIdentifier = (Get-BitLockerVolume -MountPoint "C:").KeyProtector[1].KeyProtectorId
$RecoveryIdentifier = $RecoveryIdentifier.Substring(1,$RecoveryIdentifier.Length-2)
$RecoveryKey = (Get-BitLockerVolume -MountPoint "C:").KeyProtector[1].RecoveryPassword
$RecoveryFile = "BitLocker Drive Encryption recovery key`r`n`r`nTo verify that this is the correct recovery key, compare the start of the following identifier with the identifier value displayed on your PC.`r`n`r`nIdentifier:`r`n`r`n`t$RecoveryIdentifier`r`n`r`nIf the above identifier matches the one displayed by your PC, then use the following key to unlock your drive.`r`n`r`nRecovery Key:`r`n`r`n`t$RecoveryKey`r`n`r`nIf the above identifier doesn't match the one displayed by your PC, then this isn't the right key to unlock your drive.`r`nTry another recovery key, or refer to https://go.microsoft.com/fwlink/?LinkID=260589 for additional assistance."
$RecoveryFile | Out-File "\\netshare\bitlocker\$BitLockedComputer.txt"
$RecoveryFile | Write-Output
Get-BitLockerVolume | Resume-BitLocker