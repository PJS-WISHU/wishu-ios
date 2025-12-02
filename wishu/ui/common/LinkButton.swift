//
//  LinkButton.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import SwiftUI

struct LinkButton: View {
    let linkName: String
    let url: String
    let lang: AppLanguage

    var body: some View {
        NavigationLink(destination: WebViewScreen(url: url, title: linkName)) {
            HStack {
                Text(displayText)
                    .font(.custom("Pretendard-Regular", size: 16))
                    .foregroundColor(.black)
                    .padding(.leading, 20)
                
                Image("linkIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 22, height: 22)
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
    }
    private var displayText: String {
        if lang == .korean {
            return "\(linkName) 보러가기"
        } else {
            return "Open \(linkName)"
        }
    }
}
