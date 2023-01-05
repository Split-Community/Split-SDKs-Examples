using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Splitio.Services.Client.Classes;
using Common.Logging;
using Common.Logging.Factory;
using Common.Logging.NLog;
using NLog;
using Splitio.Services.Client.Interfaces;

namespace ConsoleApp1
{
    public class MyAdapter : AbstractCachingLoggerFactoryAdapter
    {
            protected override ILog CreateLogger(string name)
            {
                return (ILog)typeof(NLogLogger).GetConstructor(System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance, null, new Type[] { typeof(NLog.Logger) }, null).Invoke(new object[] {NLog.LogManager.GetLogger(name) });
            }
    }
    class Program
    {
        static void Main(string[] args)
        {
            
            var configLog = new NLog.Config.LoggingConfiguration();
            var fileTarget = new NLog.Targets.FileTarget();
            configLog.AddTarget("file", fileTarget);
            fileTarget.FileName = @"mylog.log";
            fileTarget.ArchiveFileName = "ANYFILENAME";
            fileTarget.LineEnding = NLog.Targets.LineEndingMode.CRLF;
//            fileTarget.Layout = "${ longdate} ${ level: uppercase = true} ${ logger} - ${ message} - ${ exception: format = tostring}";
            fileTarget.ConcurrentWrites = true;
            fileTarget.CreateDirs = true;
            fileTarget.ArchiveNumbering = NLog.Targets.ArchiveNumberingMode.Date;
            var rule = new NLog.Config.LoggingRule("*", NLog.LogLevel.Debug, fileTarget);
            configLog.LoggingRules.Add(rule);
            NLog.LogManager.Configuration = configLog;

            System.Collections.Specialized.NameValueCollection properties = new System.Collections.Specialized.NameValueCollection();
            properties["configType"] = "INLINE";
            Common.Logging.LogManager.Adapter = new MyAdapter();

            ISplitClient sdk;
            ISplitFactory factory;

            var splitConfig = new ConfigurationOptions();
  //          splitConfig.Ready = 10000;

            for (var i = 1; i < 3; i++)
            {
                factory = new SplitFactory("API KEY", splitConfig);
                sdk = factory.Client();
                sdk.BlockUntilReady(10000);
                var attributes = new Dictionary<string, object>();
                attributes.Add("stateCd", "TX");
                attributes.Add("hasAdvancedDegree", true);
                var user_id = "1010101010";

                var treatment = sdk.GetTreatment(user_id, "clients", attributes);
                Console.Write(treatment+"\n");
               // System.Threading.Thread.Sleep(40000);
                sdk.Destroy();
            }
        }
        
    }
}
