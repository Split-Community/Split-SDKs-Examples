//
//  PartOfSetMatcher.swift
//  Split
//
//  Created by Natalia  Stele on 24/11/2017.
//

import Foundation

class PartOfSetMatcher: BaseMatcher, MatcherProtocol {
    
    var data: Set<String>?
    
    //--------------------------------------------------------------------------------------------------
    init(data:[String]?, splitClient: DefaultSplitClient? = nil, negate: Bool? = nil, attribute: String? = nil , type: MatcherType? = nil) {
        
        super.init(splitClient: splitClient, negate: negate, attribute: attribute, type: type)
        
        if let dataElements = data {
            
            let set: Set<String> = Set(dataElements.map { $0 })
            self.data = set
            
        }
    }
    //--------------------------------------------------------------------------------------------------
    func evaluate(matchValue: Any?, bucketingKey: String?, attributes: [String : Any]?) -> Bool {
        
        var setToCompare: Set<String>?
        
        if let dataElements = matchValue as? [String], !dataElements.isEmpty {
            
            setToCompare = Set(dataElements.map { $0 })
            
            
        } else {
            
            return false
            
        }
        
        guard let matchValueSet = setToCompare, let dataElements = data else {
            
            return false
            
        }
        
                
        return matchValueSet.isSubset(of: dataElements)
        
    }
    //--------------------------------------------------------------------------------------------------
    
    
}

