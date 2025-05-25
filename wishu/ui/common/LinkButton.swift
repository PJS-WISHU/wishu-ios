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

    var body: some View {
        NavigationLink(destination: WebViewScreen(url: url, title: linkName)) {
                Text(linkName + " 보러가기 ↗️")
                    .font(.custom("Pretendard-Bold", size: 16))
                    .foregroundColor(.black)
                    .underline()
        }
    }
}
