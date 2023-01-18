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
    func getSplitTreatmentWithConfig(splitName: String) -> (treatment: String, data: Data) {
        let result = self.client.getTreatmentWithConfig(splitName)
        return (result.treatment, (result.config?.data(using: .utf8))!)
    }
    func sendTrack(trafficType: String, eventType: String, properties: [String:Any]) -> (Bool) {
        return self.client.track(trafficType: trafficType, eventType: eventType, properties: properties)
    }
}

