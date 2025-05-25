//
//  NoticeRepository.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import Foundation

final class NoticeRepository {
    private let cache = NoticeLocalCache.shared
    private let remote = NoticeRemoteService()

    func getNotice(completion: @escaping (NoticeItem?) -> Void) {
        if let cached = cache.getCachedItem() {
            completion(cached)
        } else {
            remote.fetchNotice { [weak self] item in
                if let item = item {
                    self?.cache.save(item: item)
                }
                completion(item)
            }
        }
    }
}
