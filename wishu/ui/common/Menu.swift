//
//  Menu.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import SwiftUI

struct Menu: View {
    let iconName: String
    let message: String
    let showLinkIcon: Bool
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
            HStack {
                Image(iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .padding(.leading, 20)
                
                Text(message)
                    .font(.custom("Pretendard-Regular", size: 16))
                    .foregroundColor(isTapped ? Color(hex: "BBBBBB") : .black)
                    .padding(.leading, 5)
                
                if showLinkIcon {
                    Image("linkIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22, height: 22)
                }
            }
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 40)
                    .fill(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(Color(hex: "DFDFDF"), lineWidth: 1)
                    )
            )
            .padding(.trailing, 140)
        }
        .buttonStyle(PlainButtonStyle())
        .contentShape(Rectangle())
    }
}
