//
//  CalendarLocalCache.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import Foundation

final class CalendarLocalCache {
    static let shared = CalendarLocalCache()
    private init() {}

    private var cachedItems: [CalendarItem]? = nil

    func getCachedItems() -> [CalendarItem]? {
        return cachedItems
    }

    func save(items: [CalendarItem]) {
        cachedItems = items
    }

    func clear() {
        cachedItems = nil
    }
}
