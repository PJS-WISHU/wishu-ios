//
//  TimetableRemoteService.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import Foundation
import FirebaseFirestore

final class TimetableRemoteService {
    private let db = Firestore.firestore()

    func fetchTimetable(completion: @escaping (TimetableItem?) -> Void) {
        db.collection("swu_info")
            .document("classroom_timetable")
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

                // 필드 파싱
                guard let url = doc.data()?["url"] as? String else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }

                let item = TimetableItem(url: url)

                DispatchQueue.main.async {
                    completion(item)
                }
            }
    }
}
