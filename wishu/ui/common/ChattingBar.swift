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

    var body: some View {
        HStack {
            HStack {
                TextField("메시지를 입력하세요...", text: $messageText)
                    .padding(.vertical, 10)
                    .padding(.leading, 20)
                    .padding(.trailing, 5)
                Button(action: onSend) {
                    Image("sendMessage")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.vertical, 10)
                        .padding(.leading, 5)
                        .padding(.trailing, 20)
                }
            }
            .background(Color.white)
            .cornerRadius(15)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .background(Color(hex: "D1D3D9"))
    }
}
