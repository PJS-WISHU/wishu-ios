//
//  UserBubble.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import SwiftUI

struct UserBubble: View {
    let message: String
    
    var body: some View {
        Text(message)
            .font(.custom("Pretendard-Regular", size: 16))
            .lineLimit(nil)
            .foregroundColor(.black)
            .padding(15)
            .background(
                RoundedCorner(radius: 20, corners: [.topLeft, .bottomRight, .bottomLeft])
                    .fill(Color(hex: "FFE0C3"))
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
            )
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
}
