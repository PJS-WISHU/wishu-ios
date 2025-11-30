//
//  LanguageManager.swift
//  wishu
//
//  Created by 김은영 on 11/25/25.
//

import Foundation

enum AppLanguage: String, CaseIterable {
    case korean = "ko"
    case english = "en"
}

class LanguageManager: ObservableObject {
    @Published var lang: AppLanguage

    init() {
        let preferred = Locale.preferredLanguages.first ?? "en"
        print("🔥 [LANG DEBUG] preferredLanguages.first = \(preferred)")

        if preferred.hasPrefix("ko") {
            lang = .korean
        } else {
            lang = .english
        }

        print("🌐 [LANG RESULT] 최종 설정된 언어 = \(lang)")
    }
}
