set wmiComputer = GetObject( _
    "winmgmts:" _
    & "\\.\root\Microsoft\SqlServer\ComputerManagement10")
set tcpProperties = wmiComputer.ExecQuery( _
    "select * from ServerNetworkProtocolProperty " _
    & "where InstanceName='SUCAVE' and " _
    & "ProtocolName='Tcp' and IPAddressName='IPAll'")

for each tcpProperty in tcpProperties
	dim setValueResult, requestedValue

    if tcpProperty.PropertyName = "TcpPort" then
        requestedValue = "1433"
    elseif tcpProperty.PropertyName ="TcpDynamicPorts" then
        requestedValue = ""
    end if

    setValueResult = tcpProperty.SetStringValue(requestedValue)
    if setValueResult = 0 then 
        Wscript.Echo "" & tcpProperty.PropertyName & " set."
    else
        Wscript.Echo "" & tcpProperty.PropertyName & " failed!"
    end if       
next

Wscript.Echo "Reiniciando servicioo............................."

RestartServices ".", "MSSQL$SUCAVE"

Wscript.Echo "Se reinició el servicio satisfactoriamente! Puedes probar lo ke has hecho!!"

Sub RestartServices(Computer, ServiceNames)
  Dim ServiceName, Counter, aServiceNames

  'Get the array of service names  
  aServiceNames = split(ServiceNames,",")
  
  'loop services from beginning, stop them 
  For Each ServiceName In aServiceNames 
    StopService Computer, ServiceName, True
  Next 

  'loop services from end, start them 
  For Counter = ubound(aServiceNames) To 0 Step -1 
    StartService Computer, aServiceNames(Counter), True 
  Next 
End Sub

Sub StopService(Computer, ServiceName, Wait)
  Dim cimv2, oService, Result

  'Get the WMI administration object    
  Set cimv2 = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & _
    Computer & "\root\cimv2")

  'Get the service object
  Set oService = cimv2.Get("Win32_Service.Name='" & ServiceName & "'")
  
  'Check base properties
  If Not oService.Started Then
    ' the service is Not started
    wscript.echo "The service " & ServiceName & " is Not started"
    exit Sub
  End If

  If Not oService.AcceptStop Then
    ' the service does Not accept stop command
    wscript.echo "The service " & ServiceName & " does Not accept stop command"
    exit Sub
  End If
  
  'wscript.echo oService.getobjecttext_

  'Stop the service
  Result  = oService.StopService
  If 0 <> Result Then
    wscript.echo "Stop " & ServiceName & " error: " & Result
    exit Sub 
  End If 
  
  Do While oService.Started And Wait
    'get the current service state
    Set oService = cimv2.Get("Win32_Service.Name='" & ServiceName & "'")

    wscript.echo now, "StopService", ServiceName, oService.Started, _
      oService.State, oService.Status
    Wscript.Sleep 200
  Loop   
End Sub


Sub StartService(Computer, ServiceName, Wait)
  Dim cimv2, oService, Result

  'Get the WMI administration object    
  Set cimv2 = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & _
    Computer & "\root\cimv2")

  'Get the service object
  Set oService = cimv2.Get("Win32_Service.Name='" & ServiceName & "'")
  
  
  'Path = "winmgmts:{impersonationLevel=impersonate}!\\" & Computer & _
  '  "\root\cimv2:Win32_Service.Name='" & ServiceName & "'" 

  'Get the WMI administration object of the service    
  'Set oService = GetObject(Path)

  'Check base properties
  If oService.Started Then
    ' the service is Not started
    wscript.echo "The service " & ServiceName & " is started."
    exit Sub
  End If
  
  'Start the service
  Result = oService.StartService
  If 0 <> Result Then
    wscript.echo "Start " & ServiceName & " error:" & Result
    exit Sub 
  End If 
  
  Do While InStr(1,oService.State,"running",1) = 0 And Wait 
    'get the current service state
    Set oService = cimv2.Get("Win32_Service.Name='" & ServiceName & "'")
    
    wscript.echo now, "StartService", ServiceName, oService.Started, _
      oService.State, oService.Status
    Wscript.Sleep 200
  Loop   
End Sub