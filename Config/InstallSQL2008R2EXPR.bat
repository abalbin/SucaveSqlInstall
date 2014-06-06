@ECHO off
echo.
echo  **********************************************************************
echo  *   _______  _______  _______    _______  _______  ______    __   __ *
echo  * ^|       ^|^|  _    ^|^|       ^|  ^|       ^|^|       ^|^|    _ ^|  ^|  ^| ^|  ^| *
echo  * ^|  _____^|^| ^|_^|   ^|^|  _____^|  ^|    _  ^|^|    ___^|^|   ^| ^|^|  ^|  ^| ^|  ^| *
echo  * ^| ^|_____ ^|       ^|^| ^|_____   ^|   ^|_^| ^|^|   ^|___ ^|   ^|_^|^|_ ^|  ^|_^|  ^| *
echo  * ^|_____  ^|^|  _   ^| ^|_____  ^|  ^|    ___^|^|    ___^|^|    __  ^|^|       ^| *
echo  *  _____^| ^|^| ^|_^|   ^| _____^| ^|  ^|   ^|    ^|   ^|___ ^|   ^|  ^| ^|^|       ^| *
echo  * ^|_______^|^|_______^|^|_______^|  ^|___^|    ^|_______^|^|___^|  ^|_^|^|_______^| *
echo  *                                                                    *
echo  **********************************************************************
echo.
echo Instalando SQL Server 2008 R2 Express!!
date/t
time/t
"files\setup.exe" /SAPWD="<password>" /ConfigurationFile="ConfigurationFile.ini"
date/t
time/t
echo Se instalo SQL Server 2008 R2 Express correctamente
echo Abriendo puertos de firewall
netsh firewall set portopening protocol = TCP port = 1433 name = SQLPort mode = ENABLE scope = SUBNET profile = CURRENT
echo Se abrieron los puertos correctamente
echo Se configurara la instancia para que sea accesible remotamente
cscript "tcpConfig.vbs"
echo Se termino con la confguracion
