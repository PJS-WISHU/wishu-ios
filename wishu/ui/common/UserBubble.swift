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
            .font(.custom("Pretendard-Medium", size: 16))
            .lineLimit(nil)
            .foregroundColor(.black)
            .padding(15)
            .background(
                RoundedCorner(radius: 20, corners: [.topLeft, .topRight, .bottomLeft])
                    .fill(Color(hex: "FCE9E9"))
            )
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
}
