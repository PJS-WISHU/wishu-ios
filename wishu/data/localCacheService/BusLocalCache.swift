//
//  BusLocalCache.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import Foundation

final class BusLocalCache {
    static let shared = BusLocalCache()
    private init() {}

    private var cachedItems: [BusItem]? = nil

    func getCachedItems() -> [BusItem]? {
        return cachedItems
    }

    func save(items: [BusItem]) {
        cachedItems = items
    }

    func clear() {
        cachedItems = nil
    }
}
