//
//  BusRepository.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import Foundation

final class BusRepository {
    private let cache = BusLocalCache.shared
    private let remote = BusRemoteService()

    func getBusItems(
        lang: AppLanguage,
        completion: @escaping ([BusItem]) -> Void
    ) {
        if let cached = cache.getCachedItems() {
            completion(cached)
        } else {
            remote.fetchBusItems(lang: lang) { [weak self] items in
                self?.cache.save(items: items)
                completion(items)
            }
        }
    }
}
