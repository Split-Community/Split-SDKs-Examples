//
//  SplitWrapper.swift
//  SplitSDK
//
//  Created by Bilal Al-Shahwany on 5/29/19.
//  Copyright © 2019 Split. All rights reserved.
//

import Foundation
import Split

class SplitWrapper {
    var isSDKReady=false
    var client:SplitClient
    init(apiKey: String, key: Key) {
        let config = SplitClientConfig()
//        config.isVerboseModeEnabled=true
        config.isDebugModeEnabled=true
        config.impressionRefreshRate=5
        config.featuresRefreshRate=30
        let builder = DefaultSplitFactoryBuilder()
        let factory = builder.setApiKey(apiKey)
            .setKey(key)
            .setConfig(config)
            .build()

        self.client = factory!.client
        self.client.on(event: SplitEvent.sdkReady) {
            print("SDK Ready now")
            self.isSDKReady=true
        }
    }
    
    func getSplitTreatment(splitName: String) -> (String) {
        let treatment = self.client.getTreatment(splitName)
        return treatment
    }
    func getSplitTreatmentWithConfig(splitName: String) -> (treatment: String, config: Any) {
        let result = self.client.getTreatmentWithConfig(splitName)
        let config = try? JSONSerialization.jsonObject(with: (result.config?.data(using: .utf8)!)!, options: []) as? [String: Any]
         print("\nConfig: \(config)")

        return (result.treatment, config)
    }
    func sendTrack(trafficType: String, eventType: String, properties: [String:Any]) -> (Bool) {
        return self.client.track(trafficType: trafficType, eventType: eventType, properties: properties)
    }
}

