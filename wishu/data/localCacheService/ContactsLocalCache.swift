//
//  ContactsLocalCache.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import Foundation

final class ContactsLocalCache {
    static let shared = ContactsLocalCache()
    private init() {}

    private var cachedItem: ContactsItem?

    func getCachedItem() -> ContactsItem? {
        return cachedItem
    }

    func save(item: ContactsItem) {
        cachedItem = item
    }

    func clear() {
        cachedItem = nil
    }
}
