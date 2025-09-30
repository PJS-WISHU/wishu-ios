//
//  FacilitiesRemoteService.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import Foundation
import FirebaseFirestore

class FacilitiesRemoteService {
    private let db = Firestore.firestore()

    func fetchFacilitiesItems(completion: @escaping ([FacilitiesItem]) -> Void) {
        db.collection("swu_info")
            .document("facilities")
            .collection("current_facilities")
            .getDocuments { snapshot, error in
                if let error = error {
                    completion([])
                    return
                }

                guard let documents = snapshot?.documents else {
                    completion([])
                    return
                }

                let items: [FacilitiesItem] = documents.compactMap { doc in
                    let data = doc.data()
                    guard let name = data["name"] as? String,
                          let location = data["location"] as? String,
                          let hours = data["hours"] as? String
                    else {
                        return nil
                    }

                    return FacilitiesItem(
                        id: doc.documentID,
                        name: name,
                        location: location,
                        hours: hours
                    )
                }

                completion(items)
            }
    }
}
