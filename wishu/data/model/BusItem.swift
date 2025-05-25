//
//  BusItem.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import Foundation

struct BusItem: Identifiable, Hashable, Equatable {
    let id: String
    let key: Int
    let direction: String
    let sortation: String
    let hour: Int
    let minute: String
}
