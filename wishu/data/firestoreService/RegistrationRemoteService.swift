//
//  RegistrationRemoteService.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import Foundation
import FirebaseFirestore

final class RegistrationRemoteService {
    private let db = Firestore.firestore()

    func fetchRegistration(completion: @escaping (RegistrationItem?) -> Void) {
        db.collection("swu_info")
            .document("course_registration")
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

                guard let data = doc.data(),
                      let graduate_program = data["graduate_program"] as? String,
                      let course_registration = data["course_registration"] as? String,
                      let course_change = data["course_change"] as? String,
                      let retake_registration = data["retake_registration"] as? String,
                      let course_withdrawal = data["course_withdrawal"] as? String,
                      let credit_exchange = data["credit_exchange"] as? String,
                      let credit_carryover = data["credit_carryover"] as? String else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }

                let items = RegistrationItem(
                    graduate_program: graduate_program,
                    course_registration: course_registration,
                    course_change: course_change,
                    retake_registration: retake_registration,
                    course_withdrawal: course_withdrawal,
                    credit_exchange: credit_exchange,
                    credit_carryover: credit_carryover
                )

                DispatchQueue.main.async {
                    completion(items)
                }
            }
    }
}
