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

    func fetchBusItems(lang: AppLanguage, completion: @escaping ([BusItem]) -> Void) {
        
        let isKR = (lang == .korean)
        
        let collectionName = isKR
            ? "current_school_bus"
            : "current_school_bus_en"
        
        db.collection("swu_info")
            .document("school_bus")
            .collection(collectionName)
            .getDocuments { snapshot, error in
                
                let docs = snapshot?.documents ?? []

                let items: [BusItem] = docs.compactMap { doc in
                    let data = doc.data()

                    let key      = data[isKR ? "key" : "key_en"] as? Int ?? 0
                    let direction = data[isKR ? "direction" : "direction_en"] as? String ?? ""
                    let sortation = data[isKR ? "sortation" : "sortation_en"] as? String ?? ""
                    let hour     = data[isKR ? "hour" : "hour_en"] as? Int ?? 0
                    let minute   = data[isKR ? "minute" : "minute_en"] as? String ?? ""

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
