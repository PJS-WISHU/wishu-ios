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
            Image("onboarding")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                onFinish()
            }
        }
    }
}
