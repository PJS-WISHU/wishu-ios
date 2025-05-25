//
//  TimetableLocalCache.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import Foundation

final class TimetableLocalCache {
    static let shared = TimetableLocalCache()
    private init() {}

    private var cachedItem: TimetableItem?

    func getCachedItem() -> TimetableItem? {
        return cachedItem
    }

    func save(item: TimetableItem) {
        cachedItem = item
    }

    func clear() {
        cachedItem = nil
    }
}
