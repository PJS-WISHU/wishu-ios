//
//  FacilitiesRepository.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import Foundation

final class FacilitiesRepository {
    private let cache = FacilitiesLocalCache.shared
    private let remote = FacilitiesRemoteService()

    func getFacilitiesItems(
        lang: AppLanguage,
        completion: @escaping ([FacilitiesItem]) -> Void
    ) {
        if let cached = cache.getCachedItems() {
            completion(cached)
        } else {
            remote.fetchFacilitiesItems(lang: lang) { [weak self] items in
                self?.cache.save(items: items)
                completion(items)
            }
        }
    }
}
