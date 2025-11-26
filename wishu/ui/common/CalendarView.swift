//
//  CalendarView.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import SwiftUI

struct CalendarView: View {
    @State private var currentDate = Date()
    @State private var selectedDate: Date? = nil
    let items: [CalendarItem]
    let lang: AppLanguage
    
    private var calendar: Calendar { Calendar.current }
    private var weekdaySymbols: [String] {
        lang == .korean
        ? ["일", "월", "화", "수", "목", "금", "토"]
        : ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = (lang == .korean) ? "yyyy년 M월" : "MMMM yyyy"
        return formatter
    }
    private func dateFromString(_ string: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: string)
    }
    private func isInSchedule(date: Date) -> Bool {
        for item in items {
            guard let start = dateFromString(item.start_date),
                  let end = dateFromString(item.end_date) else { continue }

            if date >= start && date <= end {
                return true
            }
        }
        return false
    }

    // 현재 월의 모든 날짜 구하기
    private var daysInMonth: [Date] {
        guard let range = calendar.range(of: .day, in: .month, for: currentDate),
              let monthStart = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))
        else { return [] }

        return range.compactMap { day -> Date? in
            calendar.date(byAdding: .day, value: day - 1, to: monthStart)
        }
    }

    // 해당 월의 첫 번째 요일 파악
    private var firstWeekday: Int {
        guard let firstDate = daysInMonth.first else { return 0 }
        return calendar.component(.weekday, from: firstDate) - 1 // Sunday = 1 → 0부터 시작하게
    }
    
    var body: some View {
        ChatbotProfile()
        VStack(spacing: 10) {
            Text(lang == .korean ? "학사일정" : "Academic Calendar")
                .font(.custom("Pretendard-SemiBold", size: 26))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
            
            // 상단 월/년 및 이동 버튼
            HStack {
                // 왼쪽: 현재 연도 및 월
                Text(dateFormatter.string(from: currentDate))
                    .font(.custom("Pretendard-SemiBold", size: 16))
                    .foregroundColor(.black)

                Spacer()

                // 오른쪽: 좌우 화살표 버튼
                HStack(spacing: 20) {
                    Button(action: { changeMonth(by: -1) }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color(hex: "DF4D4D"))
                    }
                    .accessibilityLabel("이전 달")

                    Button(action: { changeMonth(by: 1) }) {
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color(hex: "DF4D4D"))
                    }
                    .accessibilityLabel("다음 달")
                }
            }

            // 요일 헤더
            HStack {
                ForEach(weekdaySymbols, id: \.self) { weekday in
                    Text(weekday)
                        .font(.custom("Pretendard-SemiBold", size: 16))
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.black)
                }
            }
            .padding(.vertical)

            // 날짜 그리드
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 5) {
                // 첫 요일까지 빈칸 채우기
                ForEach(0..<firstWeekday, id: \.self) { _ in
                    Text(" ")
                }

                // 날짜 표시
                ForEach(daysInMonth, id: \.self) { date in
                    let day = calendar.component(.day, from: date)
                    let isToday = calendar.isDateInToday(date)
                    let isSchedule = isInSchedule(date: date)
                
                    ZStack {
                        if isToday {
                            Circle().fill(Color(hex: "FCE9E9"))
                        } else if isSchedule {
                            Circle().fill(Color(hex: "E8F3FD"))
                        }

                        Text("\(day)")
                            .foregroundColor(
                                isToday ? Color(hex: "D54242") :
                                isSchedule ? Color(hex: "101077") :
                                Color(hex: "BBBBBB")
                            )
                            .font(.custom("Pretendard-Bold", size: 16))
                            .padding(8)
                    }
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        selectedDate = date
                    }
                }
            }
            
            // 이벤트 박스
            VStack(alignment: .leading, spacing: 8) {
                Text(lang == .korean ? "📌 선택한 날짜의 일정" : "📌 Schedule for Selected Date")
                    .font(.custom("Pretendard-SemiBold", size: 16))
                    .padding(.vertical, 5)

                if let selected = selectedDate {
                    let eventsForDate: [CalendarItem] = items.filter {
                        guard let start = dateFromString($0.start_date),
                              let end = dateFromString($0.end_date) else { return false }
                        return selected >= start && selected <= end
                    }

                    if eventsForDate.isEmpty {
                        Text(lang == .korean ? "해당 날짜에는 일정이 없습니다." : "No events on this date.")

                            .font(.custom("Pretendard-Regular", size: 16))
                            .foregroundColor(.gray)
                            .padding(8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.gray.opacity(0.05))
                            .cornerRadius(8)
                    } else {
                        ForEach(eventsForDate, id: \.id) { event in
                            Text(event.date + ", " + event.event)
                                .font(.custom("Pretendard-Regular", size: 16))
                                .padding(8)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                        }
                    }
                } else {
                    Text(lang == .korean ? "날짜를 선택해주세요." : "Please select a date.")
                        .font(.custom("Pretendard-Regular", size: 16))
                        .foregroundColor(.gray)
                        .padding(8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.gray.opacity(0.05))
                        .cornerRadius(8)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 1)
        }
    }

    private func changeMonth(by value: Int) {
        if let newDate = calendar.date(byAdding: .month, value: value, to: currentDate) {
            currentDate = newDate
            selectedDate = nil
        }
    }
}
