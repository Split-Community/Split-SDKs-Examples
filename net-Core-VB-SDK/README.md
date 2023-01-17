## Overview
This is a basic example to use .NET Split SDK 6.0.1

## Environment:

- Visual Studio

- NuGet 5.3 or later

- .NET Core SDK 2.1.301 or later


Packages:

```
Common.Logging.NLog41 3.4.1

NLog.Config 4.6.8

NLog 4.6.8

NLog.Schema 4.6.8 
```

## Getting started

- Update your relevant Split API Key, User Id and Split names in the following snippet:

``` net
Imports System
Imports Splitio.Services.Client.Classes
Imports Common.Logging.Configuration
Imports NLog
Imports NLog.Config
Imports NLog.Targets

Public Class Application
  Public Shared Sub Main() 
 
' Enable debug Logging
    Dim fileTarget = New FileTarget With {
      .Name = "splitio",
      .FileName = "splitio.log",
      .ArchiveFileName = "splitio.{#}.log",
      .LineEnding = LineEndingMode.CRLF,
      .Layout = "${longdate} ${level: uppercase = true} ${logger} - ${message} - ${exception:format=tostring}",
      .ConcurrentWrites = True,
      .CreateDirs = True,
      .ArchiveNumbering = ArchiveNumberingMode.DateAndSequence,
      .ArchiveAboveSize = 200000000,
      .ArchiveDateFormat = "yyyyMMdd",
      .MaxArchiveFiles = 30
    }
    Dim rule = New LoggingRule("*", LogLevel.Debug, fileTarget)
    Dim config = New LoggingConfiguration()
    config.AddTarget("splitio", fileTarget)
    config.LoggingRules.Add(rule)
    LogManager.Configuration = config
    Dim properties As NameValueCollection = New NameValueCollection()
    properties("configType") = "INLINE"
    Common.Logging.LogManager.Adapter = New Common.Logging.NLog.NLogLoggerFactoryAdapter(properties)
```

Using the Split SDK

```
    Dim splitConfig As ConfigurationOptions
    splitConfig = New ConfigurationOptions()
    Dim factory As SplitFactory
    factory = New SplitFactory("API Key", splitConfig)
    Dim client As SplitClient
    client = factory.Client()
    client.BlockUntilReady(10000)
    System.Console.WriteLine("SDK is Ready")

    Dim treatment As String
    treatment = client.GetTreatment("User ID","Split Name")
    System.Console.WriteLine(treatment)
  End Sub
End Class
```

