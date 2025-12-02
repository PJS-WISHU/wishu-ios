//
//  IntroBubble.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import SwiftUI

struct IntroBubble: View {
    let onSelect: (IntroMenuType) -> Void
    let lang: AppLanguage
    
    
    var body: some View {
        VStack(spacing: 5) {
            ChatbotBubble(
                message: lang == .korean
                    ? "안녕하세요 슈니.\n저는 위슈입니다. 무엇을 도와드릴까요?"
                    : "Hello! I'm wishu.\nHow can I assist you today?",
                links: [],
                lang: lang
            )
            .padding(.bottom, 10)
            
            ForEach(menuList, id: \.self) { menu in
                Menu(
                    iconName: iconName(for: menu),
                    message: menu.title(for: lang),
                    showLinkIcon: menu.needsLinkIcon,
                    onTap: { onSelect(menu) }
                )
            }
        }
    }
    private var menuList: [IntroMenuType] {
        [.shuttle, .facility, .schedule, .contacts, .timetable, .notice, .registration]
    }

    private func iconName(for menu: IntroMenuType) -> String {
        switch menu {
        case .shuttle:       return "shuttle"
        case .facility:      return "facility"
        case .schedule:      return "schedule"
        case .contacts:      return "contacts"
        case .timetable:     return "timetable"
        case .notice:        return "notice"
        case .registration:  return "registration"
        }
    }
}
