//
//  NoticeRemoteService.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import Foundation
import FirebaseFirestore

final class NoticeRemoteService {
    private let db = Firestore.firestore()

    func fetchNotice(completion: @escaping (NoticeItem?) -> Void) {
        db.collection("swu_info")
            .document("notice")
            .getDocument { document, error in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }

                guard let doc = document else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }

                if !doc.exists {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }

                guard let url = doc.data()?["url"] as? String else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }

                let item = NoticeItem(url: url)

                DispatchQueue.main.async {
                    completion(item)
                }
            }
    }
}
