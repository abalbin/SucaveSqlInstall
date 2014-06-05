SucaveSqlInstall
================

Archivos de configuración necesarios para instalar "silenciosamente" una instancia de SQL Server 2008 R2 Express y luego configurarla para que sea accesible remotamente.

Pasos
-----

1. Bajar el instalador del [SQL Server 2008 R2 Express](http://www.microsoft.com/en-us/download/details.aspx?id=30438)
2. Extraer los archivos de instalación en la carpeta en la que se va a trabajar, utilizando el siguiente comando:
    ```
    C:\sql\SQLExpr_x86_enu.exe /Q /X: "C:\sql\files"    
    ```
    La ruta ```C:\sql``` es solo un ejemplo
3. Copiar los archivos de configuración de la carpeta Config a la carpeta donde se trabajó en el paso anterior. Siguiendo el ejemplo sería ```C:\sql```
4. Abrir el archivo InstallSQL2008R2EXPR.bat y modificar el password que tendrá el usuario sa reemplazando la sección ```<password>```
5. Ya puedes correr el archivo InstallSQL2008R2EXPR.bat y esperar a que termine la instalación :)
