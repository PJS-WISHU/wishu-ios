//
//  Menu.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import SwiftUI

struct Menu: View {
    let emoji: String
    let message: String
    let onTap: () -> Void

    @State private var isTapped = false
    
    var body: some View {
        Button(action: {
            isTapped = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isTapped = false
                onTap()
            }
        }) {
            HStack(spacing: 10) {
                Text(emoji)
                    .font(.custom("Pretendard-SemiBold", size: 16))
                    .accessibilityHidden(true)
                Text(message)
                    .font(.custom("Pretendard-SemiBold", size: 16))
                    .foregroundColor(isTapped ? Color(hex: "BBBBBB") : .black)
            }
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(hex: "D1D3D9"), lineWidth: 1)
                    )
            )
            .padding(.trailing, 100)
        }
        .buttonStyle(PlainButtonStyle())
        .contentShape(Rectangle())
    }
}
