//
//  EventValidator.swift
//  Split
//
//  Created by Javier L. Avrudsky on 21/01/2019.
//  Copyright © 2019 Split. All rights reserved.
//

import Foundation

/**
 A validator for Track events
 */
protocol EventValidator {
    ///
    /// Validates a split change instance
    ///
    /// - Parameters:
    ///     - key: Matching key to validate
    ///     - trafficTypeName: Traffic type to validate
    ///     - eventTypeId: Event type to validate
    ///     - value: track value to validate
    /// - Returns: nil when validations succeded, otherwise ValidationErrorInfo instance
    ///
    func validate(key: String?, trafficTypeName: String?, eventTypeId: String?, value: Double?, properties: [String: Any]?) -> ValidationErrorInfo?
}

class DefaultEventValidator: EventValidator {

    private let kMaxMatchingKeyLength = ValidationConfig.default.maximumKeyLength
    private let kTrackEventNameValidationPattern = ValidationConfig.default.trackEventNamePattern

    var keyValidator: KeyValidator
    var splitCache: SplitCacheProtocol

    init(splitCache: SplitCacheProtocol){
        keyValidator = DefaultKeyValidator()
        self.splitCache = splitCache
    }

    func validate(key: String?, trafficTypeName: String?, eventTypeId: String?, value: Double?, properties: [String: Any]?) -> ValidationErrorInfo? {

        if let resultInfo = keyValidator.validate(matchingKey: key, bucketingKey: nil) {
            return resultInfo
        }

        if trafficTypeName == nil {
            return ValidationErrorInfo(error: .some, message: "you passed a null or undefined traffic_type_name, traffic_type_name must be a non-empty string")
        }

        if trafficTypeName!.isEmpty() {
            return ValidationErrorInfo(error: .some, message: "you passed an empty traffic_type_name, traffic_type_name must be a non-empty string")
        }

        if eventTypeId == nil {
            return ValidationErrorInfo(error: .some, message: "you passed a null or undefined event_type, event_type must be a non-empty String")
        }

        if eventTypeId!.isEmpty() {
            return ValidationErrorInfo(error: .some, message: "you passed an empty event_type, event_type must be a non-empty String")
        }

        if !isTypeValid(eventTypeId!) {
            return ValidationErrorInfo(error: .some, message: "you passed \(eventTypeId ?? "null"), event name must adhere to the regular expression \(kTrackEventNameValidationPattern). This means an event name must be alphanumeric, cannot be more than 80 characters long, and can only include a dash, underscore, period, or colon as separators of alphanumeric characters")
        }

        var validationInfo: ValidationErrorInfo? = nil
        if trafficTypeName!.hasUpperCaseChar() {
            validationInfo = ValidationErrorInfo(warning: .trafficTypeNameHasUppercaseChars , message: "traffic_type_name should be all lowercase - converting string to lowercase")
        }

        if !splitCache.exists(trafficType: trafficTypeName!) {
            let message = "Traffic Type \(trafficTypeName!) does not have any corresponding Splits in this environment, make sure you’re tracking your events to a valid traffic type defined in the Split console"
            if validationInfo != nil {
                validationInfo!.addWarning(.trafficTypeWithoutSplitInEnvironment, message: message)
            } else {
                validationInfo = ValidationErrorInfo(warning: .trafficTypeWithoutSplitInEnvironment , message: message)
            }
        }
        return validationInfo
    }

    private func isTypeValid(_ typeName: String) -> Bool {
        let validationRegex: NSRegularExpression? = try? NSRegularExpression(pattern: kTrackEventNameValidationPattern, options: .caseInsensitive)
        if let regex = validationRegex {
            let range = regex.rangeOfFirstMatch(in: typeName, options: [], range: NSRange(location: 0,  length: typeName.count))
            return range.location == 0 && range.length == typeName.count
        }
        return false
    }
}
