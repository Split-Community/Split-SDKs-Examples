## Overview
This is a console app example to show how to implement debug logging for .NET SDK

 
## Getting Started 
Follow the steps below in an empty ConsoleApp project:

Please Add below NuGet packages explicitly to your application:

```
- Microsoft.Extensions.DependencyInjection
- Microsoft.Extensions.Logging
- Microsoft.Extensions.Logging.Console
- Serilog.Extensions.Logging.File

- Register logging in the ConfigureServices method
- Register SplitLogs in the loggerFactory
```

```
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Splitio.Services.Client.Classes;
using System;

namespace ConsoleApp
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");
            ConfigureServices();
            var configurations = new ConfigurationOptions();
            var factory = new SplitFactory("YOUR-API-KEY", configurations);
            var splitClient = factory.Client();
            splitClient.BlockUntilReady(10000);
            Console.ReadLine();
        }

        private static void ConfigureServices()
        {
            var servicesProvider = new ServiceCollection()
                .AddLogging()// use .AddLogging(configure => configure.AddConsole()) if you want see the logs on the console.
                .Configure<LoggerFilterOptions>(options => options.MinLevel = LogLevel.Debug)
                .BuildServiceProvider();

            var loggerFactory = servicesProvider.GetService<ILoggerFactory>();
            loggerFactory
                .AddSplitLogs()
                .AddFile("Logs/splitio-{Date}.log", LogLevel.Debug);
        }
    }
}
```