//
//  SplitClient.swift
//  Pods
//
//  Created by Brian Sztamfater on 18/9/17.
//
//

import Foundation

public typealias SplitAction = () -> Void

@objc public protocol SplitClient {

    func getTreatment(_ split: String, attributes:[String:Any]?) -> String
    func getTreatment(_ split: String) -> String
    @objc(getTreatmentsForSplits:attributes:) func getTreatments(splits: [String], attributes:[String:Any]?) ->  [String:String]
    
    func getTreatmentWithConfig(_ split: String) -> SplitResult
    func getTreatmentWithConfig(_ split: String, attributes: [String : Any]?) -> SplitResult
    @objc(getTreatmentsWithConfigForSplits:attributes:) func getTreatmentsWithConfig(splits: [String], attributes:[String:Any]?) ->  [String:SplitResult]

    func on(event: SplitEvent, execute action: @escaping SplitAction)

    // Track feature
    func track(trafficType: String, eventType: String) -> Bool
    func track(trafficType: String, eventType: String, value: Double) -> Bool
    func track(eventType: String) -> Bool
    func track(eventType: String, value: Double) -> Bool
}
