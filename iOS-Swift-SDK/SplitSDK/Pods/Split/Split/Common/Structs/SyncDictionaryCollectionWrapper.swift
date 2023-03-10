//
//  SynchronizedDictionaryWrapper.swift
//  Split
//
//  Created by Javier on 17/09/2018.
//  Copyright © 2018 Split. All rights reserved.
//

import Foundation

class SyncDictionaryCollectionWrapper<K: Hashable,T> {
    
    private var queue: DispatchQueue
    private var items: [K:[T]]
    
    var all: [K:[T]] {
        var allItems: [K:[T]]? = nil
        queue.sync {
            allItems = items
        }
        return allItems!
    }
    
    var count: Int {
        var count: Int = 0
        queue.sync {
            for (_, values) in items {
                count += values.count
            }
        }
        return count
    }
    
    init(){
        queue = DispatchQueue(label: NSUUID().uuidString, attributes: .concurrent)
        items = [K:[T]]()
    }
    
    func value(forKey key: K) -> [T]? {
        var value: [T]? = nil
        queue.sync {
            value = items[key]
        }
        return value
    }
    
    func removeValues(forKeys keys: [K]) {
        queue.async(flags: .barrier) {
            for key in keys {
                self.items.removeValue(forKey: key)
            }
        }
    }
    
    func removeAll() {
        queue.async(flags: .barrier) {
            self.items.removeAll()
        }
    }
    
    func appendValue(_ value: T, toKey key: K) {
        queue.async(flags: .barrier) {
            var values = self.items[key] ?? []
            values.append(value)
            self.items[key] = values
        }
    }
}
