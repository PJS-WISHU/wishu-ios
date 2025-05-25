//
//  CalendarRepository.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import Foundation

final class CalendarRepository {
    private let cache = CalendarLocalCache.shared
    private let remote = CalendarRemoteService()

    func getCalendarItems(completion: @escaping ([CalendarItem]) -> Void) {
        if let cached = cache.getCachedItems() {
            completion(cached)
        } else {
            remote.fetchCalendarItems { [weak self] items in
                self?.cache.save(items: items)
                completion(items)
            }
        }
    }
}
