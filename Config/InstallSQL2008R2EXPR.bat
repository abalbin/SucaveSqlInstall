@ECHO off
echo Instalando SQL Server 2008 R2 Express!!
date/t
time/t
"C:\SQL\install_files\setup.exe" /SAPWD="<password>" /ConfigurationFile="C:\SQL\ConfigurationFile.ini"
date/t
time/t