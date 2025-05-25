//
//  FacilitiesLocalCache.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import Foundation

final class FacilitiesLocalCache {
    static let shared = FacilitiesLocalCache()
    private init() {}

    private var cachedItems: [FacilitiesItem]? = nil

    func getCachedItems() -> [FacilitiesItem]? {
        return cachedItems
    }

    func save(items: [FacilitiesItem]) {
        cachedItems = items
    }

    func clear() {
        cachedItems = nil
    }
}
