//
//  ChatbotProfile.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import SwiftUI

struct ChatbotProfile: View {
    var body: some View {
        HStack(spacing: 8) {
            Image("wishuProfile")
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .accessibilityHidden(true)
//            Text("wishu")
//                .font(.custom("Pretendard-SemiBold", size: 16))
//                .foregroundColor(.black)
        }
        .padding(.vertical, 5)
    }
}
