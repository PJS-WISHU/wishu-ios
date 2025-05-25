//
//  CalendarItem.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import Foundation

struct CalendarItem: Identifiable, Hashable, Equatable {
    let id: String
    let start_date: String
    let end_date: String
    let month: String
    let date: String
    let event: String
}
