//
//  ChatMessage.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import Foundation

struct ChatMessage: Identifiable, Hashable, Equatable {
    let id = UUID()
    let type: MessageType
    let isFromUser: Bool
    let timestamp: Date = Date()
}

enum MessageType: Hashable {
    case text(String)
    case multiLink(message: String, links: [LinkItem])
    case intro
    case busTimetable(items: [BusItem])
    case facilitiesList(items: [FacilitiesItem])
    case calendar(items: [CalendarItem])
}
