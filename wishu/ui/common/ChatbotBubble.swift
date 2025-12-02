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
    let lang: AppLanguage
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            // 챗봇 프로필+이름
            ChatbotProfile()
            
            // 챗봇 버블
            VStack(alignment: .leading) {
                Text(message)
                    .font(.custom("Pretendard-Regular", size: 16))
                    .lineLimit(nil)
                    .foregroundColor(.black)
                    .padding(15)
            }
            .background(
                RoundedCorner(radius: 20, corners: [.topRight, .bottomRight, .bottomLeft])
                    .fill(.white)
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
            )
            .overlay(
                RoundedCorner(radius: 20, corners: [.topRight, .bottomRight, .bottomLeft])
                    .stroke(Color(hex: "DFDFDF"), lineWidth: 1)
            )
            .frame(maxWidth: .infinity, alignment: .leading)

            ForEach(Array(links.enumerated()), id: \.element.url) { index, link in
                LinkButton(linkName: link.name, url: link.url, lang: lang)
                    .padding(.top, index == 0 ? 10 : 0)
            }

        }
    }
}
