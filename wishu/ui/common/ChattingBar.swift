//
//  ChattingBar.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import SwiftUI

struct ChattingBar: View {
    @Binding var messageText: String
    var onSend: () -> Void
    let lang: AppLanguage
    
    private var placeholder: String {
            lang == .korean ? "메시지를 입력하세요." : "Type a message..."
        }

    var body: some View {
        HStack {
            HStack {
                TextField(placeholder, text: $messageText)
                    .padding(.leading, 5)
                    .accessibilityLabel("텍스트필드")
                Button(action: onSend) {
                    Image("sendMessage")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.leading, 10)
                        .accessibilityHidden(true)
                }
                .accessibilityLabel("메시지 보내기")
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background(Color.white)
            .cornerRadius(15)
        }
        .padding(10)
        .background(Color(hex: "D1D3D9"))
    }
}
