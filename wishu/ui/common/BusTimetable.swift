//
//  BusTimetable.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import SwiftUI

struct BusTimetable: View {
    let items: [BusItem]
    let lang: AppLanguage
    
    var noticeText: String {
        switch lang {
        case .korean:
            return "셔틀버스는 태릉입구역 7번 출구에서 탑승할 수 있으며, '유비칸 차량관제' 앱을 설치하여 로그인(ID: swubus, PW: 19610520)하면 버스 위치를 실시간으로 알 수 있습니다."
        case .english:
            return "The shuttle bus departs from Exit 7 of Taereung Station. Install the 'Ubican Vehicle Control' app and log in (ID: swubus, PW: 19610520) to check real-time bus locations."
        }
    }
    let destinationsKR = ["서울여대", "태릉입구"]
    let destinationsEN = ["To SWU", "To Taereung Station"]
    var currentDestinations: [String] {
        lang == .korean ? destinationsKR : destinationsEN
    }
    var headerTime: String {
            lang == .korean ? "시간" : "Time"
    }
    var headerSemester: String {
        lang == .korean ? "학기 중" : "During semester"
    }
    var headerSeasonal: String {
        lang == .korean ? "계절학기 중" : "During seasonal semester"
    }

    func displayName(for direction: String) -> String {
        if lang == .korean {
            return direction
        } else {
            switch direction {
            case "To SWU": return "Seoul Women's University"
            case "To Taereung Station": return "Taereung Entrance Station"
            default: return direction
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ChatbotBubble(message: noticeText, links: [], lang: lang)
                
                ForEach(currentDestinations, id: \.self) { rawDestination in
                    let rawDeparture = (rawDestination == destinationsKR.first || rawDestination == destinationsEN.first)
                    ? (lang == .korean ? "태릉입구" : "To Taereung Station")
                    : (lang == .korean ? "서울여대" : "To SWU")
                    
                    let destination = displayName(for: rawDestination)
                    let departure = displayName(for: rawDeparture)

                    VStack(alignment: .leading, spacing: 10) {

                        if lang == .korean {
                            Text("🚌 \(departure) 출발 → \(destination) 도착")
                                .font(.custom("Pretendard-Bold", size: 16))
                        } else {
                            Text("🚌 Departure from \(departure) → Arrival at \(destination)")
                                .font(.custom("Pretendard-Bold", size: 16))
                        }
                        timetableTable(for: rawDestination)
                    }
                }
            }
        }
    }

    private func timetableTable(for destination: String) -> some View {
        let filtered = items
            .filter { $0.direction == destination }
            .sorted(by: { $0.key < $1.key })

        let grouped = Dictionary(grouping: filtered, by: { $0.hour })
        let sortedHours = grouped.keys.sorted()

        return VStack(spacing: 0) {
            // 헤더
            HStack {
                Text(headerTime)
                    .frame(width: 50, alignment: .center)
                Text(headerSemester)
                    .frame(maxWidth: .infinity, alignment: .center)
                Text(headerSeasonal)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .font(.custom("Pretendard-SemiBold", size: 14))
            .foregroundColor(.white)
            .padding(.vertical, 10)
            .background(RoundedCorners(color: Color(hex: "9E1A20"), tl: 20, tr: 20, bl: 0, br: 0))

            // 시간별 행
            ForEach(sortedHours, id: \.self) { hour in
                let hourItems = grouped[hour] ?? []

                let semesterItems = hourItems
                    .filter { $0.sortation == (lang == .korean ? "학기 중" : "During Semester") }
                    .map { $0.minute }
                    .joined(separator: ", ")

                let seasonalItems = hourItems
                    .filter { $0.sortation == (lang == .korean ? "계절학기 중" : "During Seasonal Semester") }
                    .map { $0.minute }
                    .joined(separator: ", ")

                Rectangle()
                    .fill(Color(hex: "9E1A20"))
                    .frame(height: 1)
                HStack(alignment: .top) {
                    Text(String(format: "%02d", hour))
                        .frame(width: 50, alignment: .center)
                    Rectangle()
                        .fill(Color(hex: "9E1A20"))
                        .frame(width: 1)
                    Text(semesterItems)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Rectangle()
                        .fill(Color(hex: "9E1A20"))
                        .frame(width: 1)
                    Text(seasonalItems)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .font(.custom("Pretendard-Medium", size: 14))
                .foregroundColor(.black)
                .padding(.vertical, 8)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(hex: "9E1A20"), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
