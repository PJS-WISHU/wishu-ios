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
            return "을 설치하면\n셔틀버스 위치를 실시간으로 알 수 있어요.\n\n(ID: swubus, PW: 19610520)"
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
    
    @State private var selectedDirection: String? = nil

    var body: some View {
        ScrollView {
            
            VStack(alignment: .leading, spacing: 20) {
                ChatbotBubble(
                    message: lang == .korean
                    ? "셔틀버스 출발지를 선택해 주세요."
                    : "Please select the shuttle bus departure point.",
                    links: [],
                    lang: lang
                )

                HStack(spacing: 10) {
                    Button {
                        selectedDirection = "toSWU"   // 태릉입구 → 학교
                    } label: {
                        Text(lang == .korean ? "태릉입구역에서 출발해요" : "Depart from Taereung")
                            .font(.custom("Pretendard-Regular", size: 16))
                            .foregroundColor(.black)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(
                                RoundedRectangle(cornerRadius: 50)
                                    .fill(Color.white)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 50)
                                            .stroke(Color(hex: "DFDFDF"), lineWidth: 1)
                                    )
                            )
                    }

                    Button {
                        selectedDirection = "toStation" // 학교 → 태릉입구
                    } label: {
                        Text(lang == .korean ? "학교에서 출발해요" : "Depart from SWU")
                            .font(.custom("Pretendard-Regular", size: 16))
                            .foregroundColor(.black)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(
                                RoundedRectangle(cornerRadius: 50)
                                    .fill(Color.white)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 50)
                                            .stroke(Color(hex: "DFDFDF"), lineWidth: 1)
                                    )
                            )
                    }
                }
                
                if let direction = selectedDirection {

                    VStack(alignment: .leading, spacing: 10) {

                        let destination = (
                            direction == "toSWU"
                            ? (lang == .korean ? "서울여대" : "To SWU")
                            : (lang == .korean ? "태릉입구" : "To Taereung Station")
                        )

                        let rawDeparture = (
                            direction == "toSWU"
                            ? (lang == .korean ? "태릉입구역" : "Taereung Station")
                            : (lang == .korean ? "서울여대" : "SWU")
                        )

                        // 시간표 출력
                        timetableTable(for: destination)
                        VStack(alignment: .leading) {
                            if lang == .korean {
                                (
                                    Text("유비칸 차량 관제 어플")
                                        .font(.custom("Pretendard-SemiBold", size: 16))
                                    +
                                    Text(noticeText)
                                        .font(.custom("Pretendard-Regular", size: 16))
                                )
                                .lineLimit(nil)
                                .foregroundColor(.black)
                                .padding(15)
                            } else {
                                Text(noticeText)
                                    .font(.custom("Pretendard-Regular", size: 16))
                                    .foregroundColor(.black)
                                    .lineLimit(nil)
                                    .padding(15)
                            }
                        }
                        .background(
                            RoundedCorner(radius: 20, corners: [.topRight, .topLeft, .bottomRight, .bottomLeft])
                                .fill(.white)
                                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                        )
                        .overlay(
                            RoundedCorner(radius: 20, corners: [.topRight, .topLeft, .bottomRight, .bottomLeft])
                                .stroke(Color(hex: "DFDFDF"), lineWidth: 1)
                        )
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 5)
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
        
        return VStack {
            
            if destination == "서울여대" || destination == "To SWU" {
                
                // (태릉입구 → 서울여대)
                ChatbotBubble(
                    message: lang == .korean
                    ? "태릉입구역에서 출발해서 학교에 도착하는\n셔틀버스 시간표입니다."
                    : "This is the shuttle bus timetable\nfrom Taereung Station to SWU.",
                    links: [],
                    lang: lang
                )
                
                VStack(alignment: .leading) {
                    Text(
                        lang == .korean
                        ? "셔틀버스는 태릉입구역 7번 출구에서\n탑승할 수 있어요."
                        : "You can board the shuttle bus\nat Exit 7 of Taereung Station."
                    )
                    .font(.custom("Pretendard-Regular", size: 16))
                    .lineLimit(nil)
                    .foregroundColor(.black)
                    .padding(15)
                }
                .background(
                    RoundedCorner(radius: 20, corners: [.topRight, .topLeft, .bottomRight, .bottomLeft])
                        .fill(.white)
                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                )
                .overlay(
                    RoundedCorner(radius: 20, corners: [.topRight, .topLeft, .bottomRight, .bottomLeft])
                        .stroke(Color(hex: "DFDFDF"), lineWidth: 1)
                )
                .frame(maxWidth: .infinity, alignment: .leading)
                
            } else if destination == "태릉입구" || destination == "To Taereung Station" {
                
                // (서울여대 → 태릉입구)
                ChatbotBubble(
                    message: lang == .korean
                    ? "학교에서 출발해서 태릉입구역에 도착하는\n셔틀버스 시간표입니다."
                    : "This is the shuttle bus timetable\nfrom SWU to Taereung Station.",
                    links: [],
                    lang: lang
                )
            }
            
            VStack(spacing: 0) {
                // 헤더
                HStack {
                    Text(headerTime)
                        .frame(width: 50, alignment: .center)
                    Text(headerSemester)
                        .frame(maxWidth: .infinity, alignment: .center)
                    Text(headerSeasonal)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .font(.custom("Pretendard-Medium", size: 14))
                .foregroundColor(Color(hex: "689290"))
                .padding(.vertical, 10)
                .background(RoundedCorners(color: Color(hex: "B3DBC0"), tl: 20, tr: 20, bl: 0, br: 0))
                
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
                        .fill(Color(hex: "B3DBC0"))
                        .frame(height: 1)
                    HStack(alignment: .top) {
                        Text(String(format: "%02d : 00", hour))
                            .frame(width: 50, alignment: .center)
                            .font(.custom("Pretendard-SemiBold", size: 14))
                            .bold()
                        Rectangle()
                            .fill(Color(hex: "B3DBC0"))
                            .frame(width: 1)
                        Text(semesterItems)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.custom("Pretendard-Regular", size: 14))
                        Rectangle()
                            .fill(Color(hex: "B3DBC0"))
                            .frame(width: 1)
                        Text(seasonalItems)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.custom("Pretendard-Regular", size: 14))
                    }
                    .font(.custom("Pretendard-Regular", size: 14))
                    .foregroundColor(.black)
                    .padding(.vertical, 8)
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(hex: "B3DBC0"), lineWidth: 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.top, 10)
        }
    }
}
