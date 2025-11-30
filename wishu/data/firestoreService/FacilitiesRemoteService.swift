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

    func fetchFacilitiesItems(lang: AppLanguage, completion: @escaping ([FacilitiesItem]) -> Void) {
        
        let isKR = (lang == .korean)
        
        let collectionName = isKR
            ? "current_facilities"
            : "current_facilities_en"
        
        db.collection("swu_info")
            .document("facilities")
            .collection(collectionName)
            .getDocuments { snapshot, error in
                
                let docs = snapshot?.documents ?? []

                let items: [FacilitiesItem] = docs.compactMap { doc in
                    let data = doc.data()
                    
                    print("📄 Loaded documents: \(docs.count)")
                    
                    let name     = data[isKR ? "name"     : "name_en"] as? String ?? ""
                    let location = data[isKR ? "location" : "location_en"] as? String ?? ""
                    let hours    = data[isKR ? "hours"    : "hours_en"] as? String ?? ""
                    
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
