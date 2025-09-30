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

    func fetchCalendarItems(completion: @escaping ([CalendarItem]) -> Void) {
        db.collection("swu_info")
            .document("calendar")
            .collection("current_calendar")
            .getDocuments { snapshot, error in
                if let error = error {
                    completion([])
                    return
                }

                guard let documents = snapshot?.documents else {
                    completion([])
                    return
                }

                let items: [CalendarItem] = documents.compactMap { doc in
                    let data = doc.data()
                    guard let start = data["start_date"] as? String,
                          let end = data["end_date"] as? String,
                          let month = data["month"] as? String,
                          let date = data["date"] as? String,
                          let event = data["event"] as? String else {
                        return nil
                    }

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
