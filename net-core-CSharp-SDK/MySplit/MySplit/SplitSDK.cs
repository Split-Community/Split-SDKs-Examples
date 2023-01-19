using System;
using System.Collections.Concurrent;
using Splitio.Services.Client.Classes;
using Splitio.Services.Client.Interfaces;

namespace MySplit
{
    public class SplitSDK
    {
        SplitFactory factory;
        SplitClient client;
        string apiKey;
        public SplitSDK(string apiKey)
        {
            this.apiKey = apiKey;
        }
        public SplitClient GetSplitClient()
        {
            if (this.factory is null)
            {
                GetFactoryInstance();
            }
            return this.client;
        }
        void GetFactoryInstance()
        {
            var config = new ConfigurationOptions();
//            config.MetricsRefreshRate = 18000;
            this.factory = new SplitFactory(this.apiKey, config);
            this.client = (SplitClient)this.factory.Client();
            this.client.BlockUntilReady(10000);

        }
        void Destry()
        {
            this.factory.Client().Destroy();
        }
    }
}