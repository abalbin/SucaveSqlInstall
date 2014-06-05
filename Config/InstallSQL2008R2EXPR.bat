@ECHO off
echo  _______  _______  _______    _______  _______  ______    __   __ 
echo ^|       ^|^|  _    ^|^|       ^|  ^|       ^|^|       ^|^|    _ ^|  ^|  ^| ^|  ^|
echo ^|  _____^|^| ^|_^|   ^|^|  _____^|  ^|    _  ^|^|    ___^|^|   ^| ^|^|  ^|  ^| ^|  ^|
echo ^| ^|_____ ^|       ^|^| ^|_____   ^|   ^|_^| ^|^|   ^|___ ^|   ^|_^|^|_ ^|  ^|_^|  ^|
echo ^|_____  ^|^|  _   ^| ^|_____  ^|  ^|    ___^|^|    ___^|^|    __  ^|^|       ^|
echo  _____^| ^|^| ^|_^|   ^| _____^| ^|  ^|   ^|    ^|   ^|___ ^|   ^|  ^| ^|^|       ^|
echo ^|_______^|^|_______^|^|_______^|  ^|___^|    ^|_______^|^|___^|  ^|_^|^|_______^|
echo ======================================================================================
echo Instalando SQL Server 2008 R2 Express!!
date/t
time/t
"install_files\setup.exe" /SAPWD="<password>" /ConfigurationFile="ConfigurationFile.ini"
date/t
time/t
echo Se instalo SQL Server 2008 R2 Express correctamente :)
echo Abriendo puertos del firewall!!!
netsh firewall set portopening protocol = TCP port = 1433 name = SQLPort mode = ENABLE scope = SUBNET profile = CURRENT
echo se abrieron los puertos correctamente :))
echo ahora solo falta configurar el puerto TCP del SQL! =/
cscript "tcpConfig.vbs"
echo listo... ahora es cuestion de probar! si no funciona desactivar el firewall!