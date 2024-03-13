:Start
echo %date%-%time% >>c:\users\%username%\Desktop\log.txt
echo off
ping localhost -n 1 >>c:\users\%username%\Desktop\log.txt
goto Start