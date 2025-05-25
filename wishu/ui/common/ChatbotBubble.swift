//
//  ChatbotBubble.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import SwiftUI

struct ChatbotBubble: View {
    let message: String
    let links: [LinkItem]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            // 챗봇 프로필+이름
            ChatbotProfile()
            
            // 챗봇 버블
            VStack(alignment: .leading) {
                Text(message)
                    .font(.custom("Pretendard-Medium", size: 16))
                    .lineLimit(nil)
                    .foregroundColor(.black)
                    .padding(15)
                ForEach(links, id: \.url) { link in
                    LinkButton(linkName: link.name, url: link.url)
                        .padding(.horizontal, 15)
                        .padding(.bottom, 15)
                }
            }
            .background(
                RoundedCorner(radius: 20, corners: [.topRight, .bottomRight, .bottomLeft])
                    .fill(.white)
            )
            .overlay(
                RoundedCorner(radius: 20, corners: [.topRight, .bottomRight, .bottomLeft])
                    .stroke(Color(hex: "D1D3D9"), lineWidth: 1)
            )
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct LinkItem: Hashable, Equatable {
    let name: String
    let url: String
}
