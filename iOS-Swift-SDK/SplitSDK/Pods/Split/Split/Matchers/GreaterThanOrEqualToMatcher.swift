//
//  GreaterThanOrEqualToMatcher.swift
//  Split
//
//  Created by Natalia  Stele on 26/11/2017.
//

import Foundation

class GreaterThanOrEqualToMatcher: BaseMatcher, MatcherProtocol {
    
    var data: UnaryNumericMatcherData?
    
    
    //--------------------------------------------------------------------------------------------------
    init(data: UnaryNumericMatcherData?, splitClient: DefaultSplitClient? = nil, negate: Bool? = nil, attribute: String? = nil , type: MatcherType? = nil) {
        
        super.init(splitClient: splitClient, negate: negate, attribute: attribute, type: type)
        self.data = data
    }
    //--------------------------------------------------------------------------------------------------
    func evaluate(matchValue: Any?, bucketingKey: String?, attributes: [String : Any]?) -> Bool {
        
        guard let matcherData = data, let dataType = matcherData.dataType, let value = matcherData.value else {
            return false
        }
        
        switch dataType {
            case DataType.DateTime:
                guard let keyValue = matchValue as? TimeInterval else {return false}
                
                let backendTimeInterval = TimeInterval(value/1000) //Backend is in millis
                let attributeTimeInterval = keyValue
                
                let attributeDate = DateTime.zeroOutSeconds(timestamp: attributeTimeInterval)
                let backendDate = DateTime.zeroOutSeconds(timestamp: backendTimeInterval)
                return  attributeDate >= backendDate
            
            case DataType.Number:
                guard let keyValue = CastUtils.anyToInt64(value: matchValue) else {return false}
                return keyValue >= value
        }
        
    }
    //--------------------------------------------------------------------------------------------------
    
}


