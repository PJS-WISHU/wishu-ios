//
//  Date.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import SwiftUI

extension Date {
    func formattedTime() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "a h:mm"
        return formatter.string(from: self)
    }
}
