//
//  RegistrationLocalCache.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import Foundation

final class RegistrationLocalCache {
    static let shared = RegistrationLocalCache()
    private init() {}

    private var cachedItem: RegistrationItem? = nil

    func getCachedItem() -> RegistrationItem? {
        return cachedItem
    }

    func save(item: RegistrationItem) {
        cachedItem = item
    }

    func clear() {
        cachedItem = nil
    }
}
