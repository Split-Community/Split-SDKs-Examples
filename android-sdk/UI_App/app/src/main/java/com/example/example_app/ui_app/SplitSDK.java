package com.example.bilalal_shahwany.ui_app;

import io.split.android.client.SplitClient;
import io.split.android.client.SplitClientConfig;
import io.split.android.client.SplitFactory;
import io.split.android.client.SplitFactoryBuilder;
import io.split.android.client.api.Key;
import io.split.android.client.events.SplitEvent;
import io.split.android.client.events.SplitEventTask;
import io.split.android.client.SplitResult;

import java.util.Map;
import java.util.HashMap;
import android.content.Context;
import android.util.Log;

public class SplitSDK {
    public SplitClient client;
    boolean isReady=false;
    SplitSDK(String APIKey, Key userId, Context appContext) throws Exception {
        SplitClientConfig config = SplitClientConfig.builder()
                .featuresRefreshRate(60)
                .segmentsRefreshRate(60)
                .impressionsRefreshRate(30)
                .eventFlushInterval(30)
                .enableDebug()
                .build();
        try {
            SplitFactory splitFactory = SplitFactoryBuilder.build(APIKey, userId, config, appContext);
            this.client = splitFactory.client();
            this.client.on(SplitEvent.SDK_READY, new SplitEventTask() {
                @Override
                public void onPostExecutionView(SplitClient client) {
                    isReady = true;
                }
            });
            } catch (Exception e) {
            System.out.print("Exception: "+e.getMessage());
        }
    }

    String GetSplitTreatment(String splitName, Map<String, Object> attributes) {
        return this.client.getTreatment(splitName, attributes);
    }
    String GetSplitTreatment(String splitName) {
        return this.client.getTreatment(splitName);
    }

    SplitResult GetSplitTreatmentWithConfig(String splitName, Map<String, Object> attributes) {
        return this.client.getTreatmentWithConfig(splitName, attributes);
    }

    boolean SendTrackEvent(String trackType, String metricName, double metricValue) {
        return this.client.track(trackType, metricName,metricValue);
    }
    boolean SendTrackEvent(String trackType, String metricName) {
        return this.client.track(trackType, metricName);
    }
}
