//
//  ChatViewModel.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import Foundation

class ChatViewModel: ObservableObject {
    @Published var lastMessageID: UUID?
    
    // gpt
    @Published var messages: [ChatMessage] = []
    // 통학버스
    @Published var busItems: [BusItem] = []
    // 학사일정
    @Published var calendarItems: [CalendarItem] = []
    // 교내 연락처
    @Published var contactsURL: String = ""
    // 공지사항
    @Published var noticeURL: String = ""
    // 시간표
    @Published var timetableURL: String = ""
    // 교내 시설
    @Published var facilitiesItems: [FacilitiesItem] = []
    // 수강신청
    @Published var graduate_program: String = ""
    @Published var course_registration: String = ""
    @Published var course_change: String = ""
    @Published var retake_registration: String = ""
    @Published var course_withdrawal: String = ""
    @Published var credit_exchange: String = ""
    @Published var credit_carryover: String = ""

    private let gptService = GPTFunctionService()
    private let busRepo = BusRepository()
    private let calendarRepo = CalendarRepository()
    private let contactsRepo = ContactsRepository()
    private let noticeRepo = NoticeRepository()
    private let timetableRepo = TimetableRepository()
    private let facilitiesRepo = FacilitiesRepository()
    private let registrationRepo = RegistrationRepository()

    // gpt 요청
    func sendMessage(_ text: String) {
        let trimmed = text.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return }

        let userMessage = ChatMessage(type: .text(trimmed), isFromUser: true)
            messages.append(userMessage)
            lastMessageID = userMessage.id
        
        gptService.askChatbot(type: "question", value: trimmed) { [weak self] answer in
                DispatchQueue.main.async {
                    guard let self else { return }

                    let response = answer ?? "죄송합니다. 응답을 불러오지 못했어요."
                    let botMessage = ChatMessage(type: .text(response), isFromUser: false)
                    self.messages.append(botMessage)
                    self.lastMessageID = botMessage.id
                }
            }
    }
    
    // 통학버스 데이터 로드
    func loadBus(completion: @escaping () -> Void) {
        busRepo.getBusItems { [weak self] items in
            DispatchQueue.main.async {
                self?.busItems = items
                completion()
            }
        }
    }

    // 학사일정 데이터 로드
    func loadCalendar(completion: @escaping () -> Void) {
        calendarRepo.getCalendarItems { [weak self] items in
            DispatchQueue.main.async {
                self?.calendarItems = items
                completion()
            }
        }
    }

    // 교내연락처 데이터 로드
    func loadContacts(completion: @escaping () -> Void) {
        contactsRepo.getContacts { [weak self] item in
            DispatchQueue.main.async {
                self?.contactsURL = item?.url ?? "불러오기 실패"
                completion()
            }
        }
    }

    // 공지사항 데이터 로드
    func loadNotice(completion: @escaping () -> Void) {
        noticeRepo.getNotice { [weak self] item in
            DispatchQueue.main.async {
                self?.noticeURL = item?.url ?? "불러오기 실패"
                completion()
            }
        }
    }

    // 강의실/시간표 데이터 로드
    func loadTimetable(completion: @escaping () -> Void) {
        timetableRepo.getTimetable { [weak self] item in
            DispatchQueue.main.async {
                self?.timetableURL = item?.url ?? "불러오기 실패"
                completion()
            }
        }
    }

    // 교내시설 데이터 로드
    func loadFacilities(completion: @escaping () -> Void) {
        facilitiesRepo.getFacilitiesItems { [weak self] items in
            DispatchQueue.main.async {
                self?.facilitiesItems = items
                completion()
            }
        }
    }
    
    // 수강신청 데이터 로드
    func loadRegistration(completion: @escaping () -> Void) {
        registrationRepo.getRegistrationItem { [weak self] item in
            DispatchQueue.main.async {
                guard let item = item else {
                    return
                }

                self?.graduate_program = item.graduate_program
                self?.course_registration = item.course_registration
                self?.course_change = item.course_change
                self?.retake_registration = item.retake_registration
                self?.course_withdrawal = item.course_withdrawal
                self?.credit_exchange = item.credit_exchange
                self?.credit_carryover = item.credit_carryover
                completion()
            }
        }
    }
    
    // IntroBubble 메뉴 선택 핸들링
    func handleIntroSelection(_ selected: IntroMenuType) {
        messages.append(ChatMessage(type: .text(selected.displayName), isFromUser: true))
        
        switch selected {
            
        // 셔틀버스
        case .shuttle:
            loadBus {
                let message = ChatMessage(
                    type: .busTimetable(items: self.busItems),
                    isFromUser: false
                )
                self.messages.append(message)
                self.lastMessageID = message.id
            }
            
        // 교내시설
        case .facility:
            loadFacilities {
                let message = ChatMessage(
                    type: .facilitiesList(items: self.facilitiesItems),
                    isFromUser: false
                )
                self.messages.append(message)
                self.lastMessageID = message.id
            }
        
        // 학사일정
        case .schedule:
            loadCalendar {
                let message = ChatMessage(
                    type: .calendar(items: self.calendarItems),
                    isFromUser: false
                )
                self.messages.append(message)
                self.lastMessageID = message.id
            }
            
        // 교내연락처
        case .contacts:
            loadContacts {
                let message = ChatMessage(
                    type: .multiLink(
                        message: "교내 연락처 안내입니다.\n더 궁금한 게 있다면 언제든지 물어보세요!",
                        links: [LinkItem(name: "교내 연락처", url: self.contactsURL)]
                    ),
                    isFromUser: false
                )
                self.messages.append(message)
                self.lastMessageID = message.id
            }
            
        // 강의실 및 시간표
        case .timetable:
            loadTimetable {
                let message = ChatMessage(
                    type: .multiLink(
                        message: "강의실 및 시간표 안내입니다.\n더 궁금한 게 있다면 언제든지 물어보세요!",
                        links: [LinkItem(name: "강의실 및 시간표", url: self.timetableURL)]
                    ),
                    isFromUser: false
                )
                self.messages.append(message)
                self.lastMessageID = message.id
            }
            
        // 공지사항
        case .notice:
            loadNotice {
                let message = ChatMessage(
                    type: .multiLink(
                        message: "공지사항 안내입니다.\n더 궁금한 게 있다면 언제든지 물어보세요!",
                        links: [LinkItem(name: "공지사항", url: self.noticeURL)]
                    ),
                    isFromUser: false
                )
                self.messages.append(message)
                self.lastMessageID = message.id
            }
            
        // 수강신청
        case .registration:
            loadRegistration {
                let tuples: [(String, String)] = [
                    ("석사학위과정", self.graduate_program),
                    ("수강신청", self.course_registration),
                    ("수강정정", self.course_change),
                    ("재수강신청", self.retake_registration),
                    ("중도포기", self.course_withdrawal),
                    ("학점교류", self.credit_exchange),
                    ("학점이월제", self.credit_carryover)
                ]

                let links: [LinkItem] = tuples.map { LinkItem(name: $0.0, url: $0.1) }

                let message = ChatMessage(
                    type: .multiLink(
                        message: "수강신청 안내입니다.\n더 궁금한 게 있다면 언제든지 물어보세요!",
                        links: links
                    ),
                    isFromUser: false
                )
                self.messages.append(message)
                self.lastMessageID = message.id
            }
            
        default:
            messages.append(
                ChatMessage(
                    type: .text("\(selected) 기능은 준비 중입니다."),
                    isFromUser: false
                )
            )
        }
    }

}
