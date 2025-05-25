//
//  ContactsRepository.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import Foundation

final class ContactsRepository {
    private let cache = ContactsLocalCache.shared
    private let remote = ContactsRemoteService()

    func getContacts(completion: @escaping (ContactsItem?) -> Void) {
        if let cached = cache.getCachedItem() {
            completion(cached)
        } else {
            remote.fetchContacts { [weak self] item in
                if let item = item {
                    self?.cache.save(item: item)
                }
                completion(item)
            }
        }
    }
}
