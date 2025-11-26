//
//  CalendarRemoteService.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import Foundation
import FirebaseFirestore

class CalendarRemoteService {
    private let db = Firestore.firestore()

    func fetchCalendarItems(lang: AppLanguage, completion: @escaping ([CalendarItem]) -> Void) {
        
        let isKR = (lang == .korean)
        
        let collectionName = isKR
            ? "current_calendar"
            : "current_calendar_en"
        
        db.collection("swu_info")
            .document("calendar")
            .collection(collectionName)
            .getDocuments { snapshot, error in
                            
                let docs = snapshot?.documents ?? []

                let items: [CalendarItem] = docs.compactMap { doc in
                    let data = doc.data()
                    
                    let start = data[isKR ? "start_date" : "start_date_en"] as? String ?? ""
                    let end   = data[isKR ? "end_date"   : "end_date_en"] as? String ?? ""
                    let month = data[isKR ? "month"      : "month_en"] as? String ?? ""
                    let date  = data[isKR ? "date"       : "date_en"] as? String ?? ""
                    let event = data[isKR ? "event"      : "event_en"] as? String ?? ""

                    return CalendarItem(
                        id: doc.documentID,
                        start_date: start,
                        end_date: end,
                        month: month,
                        date: date,
                        event: event
                    )
                }

                completion(items)
            }
    }
}
