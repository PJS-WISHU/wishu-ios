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
            Text(displayText)
                    .font(.custom("Pretendard-Bold", size: 16))
                    .foregroundColor(.black)
                    .underline()
        }
    }
    private var displayText: String {
        if lang == .korean {
            return "\(linkName) 보러가기 ↗️"
        } else {
            return "Open \(linkName) ↗️"
        }
    }
}
