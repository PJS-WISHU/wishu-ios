//
//  TimetableRepository.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import Foundation

final class TimetableRepository {
    private let cache = TimetableLocalCache.shared
    private let remote = TimetableRemoteService()

    func getTimetable(completion: @escaping (TimetableItem?) -> Void) {
        if let cached = cache.getCachedItem() {
            completion(cached)
        } else {
            remote.fetchTimetable { [weak self] item in
                if let item = item {
                    self?.cache.save(item: item)
                }
                completion(item)
            }
        }
    }
}
