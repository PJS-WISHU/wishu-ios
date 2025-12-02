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
        lang == .korean ? "메시지를 입력해주세요." : "Type a message..."
    }

    var body: some View {
        HStack {
            HStack {
                TextField(placeholder, text: $messageText)
                    .accessibilityLabel("텍스트필드")
                    .padding(.leading, 20)
                
                Button(action: onSend) {
                    Image("sendMessage")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .accessibilityHidden(true)
                }
                .accessibilityLabel("메시지 보내기")
                .padding(.trailing, 20)
            }
            .padding(.vertical, 10)
            .background(Color(hex: "F2F2F2"))
            .cornerRadius(20)
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 5)
        .background(Color.white)
    }
}
