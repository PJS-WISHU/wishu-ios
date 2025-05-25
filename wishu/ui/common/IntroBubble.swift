//
//  IntroBubble.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import SwiftUI

struct IntroBubble: View {

    let onSelect: (IntroMenuType) -> Void
    
    var body: some View {
        VStack(spacing: 5) {
            ChatbotBubble(message: "안녕하세요.슈니.\n저는 위슈입니다. 무엇을 도와드릴까요?", links: [])
            Menu(
                emoji: "🚎",
                message: "셔틀버스 시간표",
                onTap: {
                    onSelect(.shuttle)
                }
            )
            Menu(
                emoji: "🏫",
                message: "교내시설 운영시간",
                onTap: {
                    onSelect(.facility)
                }
            )
            Menu(
                emoji: "🗓️",
                message: "학사일정",
                onTap: {
                    onSelect(.schedule)
                }
            )
            Menu(
                emoji: "☎️",
                message: "교내 연락처",
                onTap: {
                    onSelect(.contacts)
                }
            )
            Menu(
                emoji: "📚",
                message: "강의실 및 시간표",
                onTap: {
                    onSelect(.timetable)
                }
            )
            Menu(
                emoji: "📢",
                message: "공지사항",
                onTap: {
                    onSelect(.notice)
                }
            )
            Menu(
                emoji: "💻",
                message: "수강신청",
                onTap: {
                    onSelect(.registration)
                }
            )
        }
    }
}
