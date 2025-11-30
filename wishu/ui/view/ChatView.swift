//
//  ChatView.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import SwiftUI

struct ChatView: View {
    let lang: AppLanguage
    @StateObject private var viewModel: ChatViewModel
    @State private var messageText: String = ""
    @State private var lastMessageID: UUID?

    init(lang: AppLanguage) {
        _viewModel = StateObject(wrappedValue: ChatViewModel(lang: lang))
        self.lang = lang
    }

    var body: some View {
        VStack {
            // 상단 로고 영역
            Image("swuLogo")
                .resizable()
                .scaledToFit()
                .frame(height: 40)
                .padding(.vertical, 10)
                .accessibilityHidden(true)
            Divider()

            // 채팅 영역
            ScrollViewReader { scrollProxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(viewModel.messages) { msg in
                            messageView(for: msg)
                        }
                    }
                    .padding()
                    .onAppear {
                        if viewModel.messages.isEmpty {
                            viewModel.messages.append(ChatMessage(type: .intro, isFromUser: false))
                        }
                    }
                }
                .onChange(of: viewModel.lastMessageID) { _, _ in
                    if let id = viewModel.lastMessageID {
                        withAnimation {
                            scrollProxy.scrollTo(id, anchor: .bottom)
                        }
                    }
                }
            }

            // 채팅바 영역
            ChattingBar(
                messageText: $messageText,
                onSend: {
                    viewModel.sendMessage(messageText)
                    messageText = ""
                }
            )
        }
    }
    
    @ViewBuilder
    func messageView(for msg: ChatMessage) -> some View {
        VStack(alignment: msg.isFromUser ? .trailing : .leading, spacing: 5) {
            switch msg.type {
            case .text(let text):
                if msg.isFromUser {
                    UserBubble(message: text)
                } else {
                    ChatbotBubble(message: text, links: [])
                }
                
            case .multiLink(let message, let links):
                ChatbotBubble(message: message, links: links)
                
            case .intro:
                IntroBubble(onSelect: viewModel.handleIntroSelection)
                
            case .busTimetable(let items):
                BusTimetable(items: items, lang: lang)
                
            case.facilitiesList(let items):
                FacilitiesList(items: items, lang: lang
                )
            
            case.calendar(let items):
                CalendarView(items: items, lang: lang)
            }
            
            Text(msg.timestamp.formattedTime())
                .font(.custom("Pretendard-Medium", size: 12))
                .foregroundColor(.gray)
                .padding(.horizontal, 8)
        }
        .frame(maxWidth: .infinity, alignment: msg.isFromUser ? .trailing : .leading)
        .id(msg.id)
    }
}
