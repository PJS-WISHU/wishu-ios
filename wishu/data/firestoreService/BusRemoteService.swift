//
//  BusRemoteService.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import Foundation
import FirebaseFirestore

class BusRemoteService {
    private let db = Firestore.firestore()

    func fetchBusItems(completion: @escaping ([BusItem]) -> Void) {
        db.collection("swu_info")
            .document("school_bus")
            .collection("current_school_bus")
            .getDocuments { snapshot, error in
                if let error = error {
                    completion([])
                    return
                }

                guard let documents = snapshot?.documents else {
                    completion([])
                    return
                }

                let items: [BusItem] = documents.compactMap { doc in
                    let data = doc.data()
                    guard let key = data["key"] as? Int,
                          let direction = data["direction"] as? String,
                          let sortation = data["sortation"] as? String,
                          let hour = data["hour"] as? Int,
                          let minute = data["minute"] as? String else {
                        return nil
                    }

                    return BusItem(
                        id: doc.documentID,
                        key: key,
                        direction: direction,
                        sortation: sortation,
                        hour: hour,
                        minute: minute
                    )
                }

                completion(items)
            }
    }
}
