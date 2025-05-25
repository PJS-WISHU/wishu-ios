//
//  RegistrationRepository.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import Foundation

final class RegistrationRepository {
    private let cache = RegistrationLocalCache.shared
    private let remote = RegistrationRemoteService()

    func getRegistrationItem(completion: @escaping (RegistrationItem?) -> Void) {
        if let cached = cache.getCachedItem() {
            completion(cached)
        } else {
            remote.fetchRegistration { [weak self] item in
                if let item = item {
                    self?.cache.save(item: item)
                }
                completion(item)
            }
        }
    }
}
