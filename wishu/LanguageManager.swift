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
        // 시스템 언어 가져오기
        let code = Locale.current.language.languageCode?.identifier ?? "en"

        if code == AppLanguage.korean.rawValue {
            lang = .korean
        } else {
            lang = .english
        }
    }
    
    func setLanguage(_ language: AppLanguage) {
        lang = language
    }
}
