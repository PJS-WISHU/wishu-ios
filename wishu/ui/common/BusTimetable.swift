//
//  BusTimetable.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import SwiftUI

struct BusTimetable: View {
    let items: [BusItem]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ChatbotBubble(message: "'유비칸 차량관제' 앱을 설치 후, 로그인(ID: swubus, PW: 19610520)하여 버스 위치를 실시간으로 알 수 있습니다.", links: [])
                
                ForEach(["서울여대", "태릉입구"], id: \.self) { destination in
                    let departure = (destination == "서울여대") ? "태릉입구" : "서울여대"

                    VStack(alignment: .leading, spacing: 10) {
                        Text("🚌 \(departure) 출발 → \(destination) 도착 시간표")
                            .font(.custom("Pretendard-Bold", size: 16))

                        timetableTable(for: destination)
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
                Text("시간")
                    .frame(width: 50, alignment: .center)
                Text("학기 중")
                    .frame(maxWidth: .infinity, alignment: .center)
                Text("계절학기 중")
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
                    .filter { $0.sortation == "학기 중" }
                    .map { $0.minute }
                    .joined(separator: ", ")

                let seasonalItems = hourItems
                    .filter { $0.sortation == "계절학기 중" }
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
