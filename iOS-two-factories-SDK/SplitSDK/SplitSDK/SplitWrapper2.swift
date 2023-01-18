//
//  SplitWrapper.swift
//  SplitSDK
//
//  Created by Bilal Al-Shahwany on 5/29/19.
//  Copyright © 2019 Split. All rights reserved.
//

import Foundation
import Split

class SplitWrapper2 {
    var isSDKReady2=false
    var client2:SplitClient
    init(apiKey: String, key: Key) {
        let config2 = SplitClientConfig()
        let builder2 = DefaultSplitFactoryBuilder()
        let factory2 = builder2.setApiKey(apiKey)
            .setKey(key)
            .setConfig(config2)
            .build()
        
        self.client2 = factory2!.client
        self.client2.on(event: SplitEvent.sdkReady) {
            print("SDK2 Ready now")
            self.isSDKReady2=true
        }
    }
    
    func getSplitTreatment(splitName: String) -> (String) {
        let treatment = self.client2.getTreatment(splitName)
        return treatment
    }
    func getSplitTreatmentWithConfig(splitName: String) -> (treatment: String, data: Data) {
        let result = self.client2.getTreatmentWithConfig(splitName)
        return (result.treatment, (result.config?.data(using: .utf8))!)
    }
    func sendTrack(trafficType: String, eventType: String, properties: [String:Any]) -> (Bool) {
        return self.client2.track(trafficType: trafficType, eventType: eventType, properties: properties)
    }
}

