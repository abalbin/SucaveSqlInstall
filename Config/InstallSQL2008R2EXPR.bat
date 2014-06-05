@ECHO off
echo Instalando SQL Server 2008 R2 Express!!
date/t
time/t
"C:\SQL\install_files\setup.exe" /SAPWD="<password>" /ConfigurationFile="C:\SQL\ConfigurationFile.ini"
date/t
time/t
echo Se instalo SQL Server 2008 R2 Express correctamente :)
echo Abriendo puertos del firewall!!!
netsh firewall set portopening protocol = TCP port = 1433 name = SQLPort mode = ENABLE scope = SUBNET profile = CURRENT
echo se abrieron los puerto correctamente :))
echo ahora solo falta configurar el puerto TCP del SQL! =/
cscript "C:\SQL\tcpConfig.vbs"
echo listo... ahora es cuestion de probar!