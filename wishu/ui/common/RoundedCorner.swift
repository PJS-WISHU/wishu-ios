//
//  RoundedCorner.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import SwiftUI

struct RoundedCorner: Shape {
    var radius: CGFloat = 15
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
