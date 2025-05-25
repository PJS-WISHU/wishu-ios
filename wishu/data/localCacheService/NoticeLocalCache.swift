//
//  NoticeLocalCache.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import Foundation

final class NoticeLocalCache {
    static let shared = NoticeLocalCache()
    private init() {}

    private var cachedItem: NoticeItem?

    func getCachedItem() -> NoticeItem? {
        return cachedItem
    }

    func save(item: NoticeItem) {
        cachedItem = item
    }

    func clear() {
        cachedItem = nil
    }
}
