//
//  ContentView.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import SwiftUI
import UIKit

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Pretendard Thin")
                .font(.custom("Pretendard-Thin", size: 20))

            Text("Pretendard ExtraLight")
                .font(.custom("Pretendard-ExtraLight", size: 20))

            Text("Pretendard Light")
                .font(.custom("Pretendard-Light", size: 20))

            Text("Pretendard Regular")
                .font(.custom("Pretendard-Regular", size: 20))

            Text("Pretendard Medium")
                .font(.custom("Pretendard-Medium", size: 20))

            Text("Pretendard SemiBold")
                .font(.custom("Pretendard-SemiBold", size: 20))

            Text("Pretendard Bold")
                .font(.custom("Pretendard-Bold", size: 20))

            Text("Pretendard ExtraBold")
                .font(.custom("Pretendard-ExtraBold", size: 20))

            Text("Pretendard Black")
                .font(.custom("Pretendard-Black", size: 20))
            
            Button("familyNames 출력") {
                for family in UIFont.familyNames.sorted() {
                    print("Family: \(family)")
                    for name in UIFont.fontNames(forFamilyName: family) {
                        print("  Font: \(name)")
                    }
                }
            }
        }
        .padding()
    }
}
