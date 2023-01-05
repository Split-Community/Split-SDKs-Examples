//
//  FactoryValidator.swift
//  Split
//
//  Created by Javier L. Avrudsky on 02/05/2019.
//  Copyright © 2019 Split. All rights reserved.
//

import Foundation

struct WeakFactory {
    private(set) weak var factory: SplitFactory?

    init(factory: SplitFactory?) {
        self.factory = factory
    }
}

class FactoryRegistry {

    private var queue: DispatchQueue
    private var weakFactories: [String: [WeakFactory]]

    var count: Int {
        var count: Int = 0
        queue.sync {
            for (key, factories) in self.weakFactories {
                self.compact(for: key)
                count += factories.count
            }
        }
        return count
    }

    init() {
        queue = DispatchQueue(label: NSUUID().uuidString)
        weakFactories = [String: [WeakFactory]]()
    }

    func count(for key: String) -> Int {
        var count: Int = 0
        queue.sync {
            self.compact(for: key)
            count = self.weakFactories[key]?.count ?? 0
        }
        return count
    }

    private func compact(for key: String) {
        if let refs = self.weakFactories[key] {
            let aliveRefs = refs.filter({$0.factory != nil})
            self.weakFactories[key] = aliveRefs
        }
    }

    func append(_ factory: WeakFactory, to key: String) {
        queue.async {
            var factories = self.weakFactories[key] ?? []
            factories.append(factory)
            self.weakFactories[key] = factories
        }
    }
}

protocol FactoryMonitor {
    var allCount: Int { get }
    func instanceCount(for apiKey: String) -> Int
    func register(instance: SplitFactory?, for apiKey: String)
}

class DefaultFactoryMonitor: FactoryMonitor {
    var factoryRegistry: FactoryRegistry

    var allCount: Int {
        return factoryRegistry.count
    }

    init() {
        factoryRegistry = FactoryRegistry()
    }

    func instanceCount(for apiKey: String) -> Int {
        return factoryRegistry.count(for: apiKey)
    }

    func register(instance: SplitFactory?, for apiKey: String) {
        let weakFactory = WeakFactory(factory: instance)
        factoryRegistry.append(weakFactory, to: apiKey)
    }
}
