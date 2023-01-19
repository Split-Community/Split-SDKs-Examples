using System;
using System.Reflection;
using Common.Logging;
using Common.Logging.Factory;
using Common.Logging.NLog;
using Splitio.Services.Client.Classes;
using System.Collections.Generic;
using System.Threading;
using static MySplit.SplitSDK;
using System.Collections.Concurrent;
using Splitio.Services.Client.Interfaces;
using Newtonsoft.Json;

namespace MySplit
{
    public class MyAdapter : AbstractCachingLoggerFactoryAdapter
    {
        protected override ILog CreateLogger(string name)
        {
            return (ILog)typeof(NLogLogger).GetConstructor(
                BindingFlags.NonPublic | BindingFlags.Instance, null, new Type[] { typeof(NLog.Logger) }, null)
                .Invoke(new object[] { NLog.LogManager.GetLogger(name) });
        }
    }

    class Program
    {
        private static ConcurrentDictionary<string, ISplitClient> splitClientConcurrentDictionary = new ConcurrentDictionary<string, ISplitClient>();

        static void Main(string[] args)
        {
            var configLog = new NLog.Config.LoggingConfiguration();
            var fileTarget = new NLog.Targets.FileTarget();
            configLog.AddTarget("file", fileTarget);
            fileTarget.FileName = @"mylog.log";
            fileTarget.ArchiveFileName = "ANYFILENAME";
            fileTarget.LineEnding = NLog.Targets.LineEndingMode.CRLF;
            fileTarget.Layout = "${longdate} ${level: uppercase = true} ${logger} - ${message}";
            fileTarget.ConcurrentWrites = true;
            fileTarget.CreateDirs = true;
            fileTarget.ArchiveNumbering = NLog.Targets.ArchiveNumberingMode.Date;
            var rule = new NLog.Config.LoggingRule("*", NLog.LogLevel.Trace, fileTarget);
            configLog.LoggingRules.Add(rule);
            NLog.LogManager.Configuration = configLog;

            System.Collections.Specialized.NameValueCollection properties = new System.Collections.Specialized.NameValueCollection();
            properties["configType"] = "INLINE";

            Common.Logging.LogManager.Adapter = new MyAdapter();

            /* Code to use with Redis synchronizer

            var config = new ConfigurationOptions();
            config.Mode = Mode.Consumer;
            config.CacheAdapterConfig = new CacheAdapterConfigurationOptions(); 
            config.CacheAdapterConfig.Type = AdapterType.Redis;
            config.CacheAdapterConfig.Host = "localhost";
            config.CacheAdapterConfig.Port = "6379";
            config.CacheAdapterConfig.Password = "";
            config.CacheAdapterConfig.Database = 0;
            config.CacheAdapterConfig.ConnectTimeout = 5000;
            config.CacheAdapterConfig.ConnectRetry = 3;
            config.CacheAdapterConfig.SyncTimeout = 1000;

            */

            var splitSDK = new SplitSDK("SDK API KEY");

            SplitClient sdk = splitSDK.GetSplitClient();
            sdk.BlockUntilReady(5000);

            var treatment = sdk.GetTreatment("dave", "sample_feature");
            Console.WriteLine("User1, Split1, Treatment is " + treatment);

            var attributes = new Dictionary<string, object>();
            attributes.Add("country", "US");
            treatment = sdk.GetTreatment("split_support", "sample_feature", attributes);
            Console.WriteLine("Treatment is "+treatment);

            var treatmentConfig = sdk.GetTreatmentWithConfig("split_support", "sample_feature", attributes);
            Console.WriteLine("\nTreatment is " + treatmentConfig.Treatment);
            dynamic configData = JsonConvert.DeserializeObject<Dictionary<string, string>>(treatmentConfig.Config);
            foreach (KeyValuePair<string, string> entry in configData)
            {
                Console.WriteLine("\n Key: " + entry.Key + ", Value: " + entry.Value);
            }

            bool success = sdk.Track("john@doe.com", "account", "page_load_time", 85.334);
            Thread.Sleep(60000);

        }
    }
}
