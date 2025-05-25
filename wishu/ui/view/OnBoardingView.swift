//
//  OnBoardingView.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import SwiftUI

struct OnBoardingView: View {
    var onFinish: () -> Void

    var body: some View {
        ZStack {
            Color(hex: "B03539")
                .ignoresSafeArea()

            VStack(spacing: 30) {
                Spacer()
                Image("character")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 70)
                Image("appName")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 130)
                    .padding(.bottom, 100)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                onFinish()
            }
        }
    }
}
