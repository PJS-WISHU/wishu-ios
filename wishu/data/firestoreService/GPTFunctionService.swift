//
//  GPTFunctionService.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import FirebaseFunctions
import Foundation

class GPTFunctionService {
    private let functions = Functions.functions()
    
    func askChatbot(type: String, value: String, completion: @escaping (String?) -> Void) {
        let data: [String: Any] = [
            "type": type,
            "value": value
        ]
        
        functions.httpsCallable("chatbot").call(data) { result, error in
            if let error = error as NSError? {
                completion(nil)
                return
            }

            if let resultData = result?.data as? [String: Any],
               let answer = resultData["answer"] as? String {
                completion(answer)
            } else {
                completion(nil)
            }
        }
    }
}
