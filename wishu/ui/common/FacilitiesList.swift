//
//  FacilitiesList.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import SwiftUI

struct FacilitiesList: View {
    let items: [FacilitiesItem]
    let lang: AppLanguage
    
    private var headerLocation: String {
        lang == .korean ? "위치" : "Location"
    }
    private var headerName: String {
        lang == .korean ? "업체명" : "Name"
    }
    private var headerTime: String {
        lang == .korean ? "영업시간" : "Hours"
    }
    
    @State private var selectedCategory: String? = nil
    
    var body: some View {
        ScrollView {
            
            VStack(alignment: .leading, spacing: 20) {
                ChatbotBubble(
                    message: lang == .korean
                    ? "어떤 종류의 교내시설을 찾으시나요?"
                    : "Which type of campus facility are you looking for?",
                    links: [],
                    lang: lang
                )
                
                HStack(spacing: 10) {
                    Button {
                        selectedCategory = "카페/베이커리"
                    } label: {
                        Text(lang == .korean ? "카페/베이커리" : "Café / Bakery")
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
                        selectedCategory = "식당"
                    } label: {
                        Text(lang == .korean ? "식당" : "Dining")
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
                        selectedCategory = "편의시설"
                    } label: {
                        Text(lang == .korean ? "편의시설" : "Convenience")
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
                
                if let category = selectedCategory {
                    let filtered = filteredFacilities(for: category)
                    
                    if !filtered.isEmpty {
                        
                        if selectedCategory == "카페/베이커리" {
                            ChatbotBubble(
                                message: lang == .korean
                                ? "학교 내 카페 전체 운영 시간표에요."
                                : "Here is the full operating schedule for all cafés on campus.",
                                links: [],
                                lang: lang
                            )
                        } else if selectedCategory == "식당" {
                            ChatbotBubble(
                                message: lang == .korean
                                ? "학교 내 식당 전체 운영 시간표에요."
                                : "Here is the full operating schedule for all dining facilities on campus.",
                                links: [],
                                lang: lang
                            )
                        } else if selectedCategory == "편의시설" {
                            ChatbotBubble(
                                message: lang == .korean
                                ? "학교 내 편의시설 전체 운영 시간표에요."
                                : "Here is the full operating schedule for all convenience facilities on campus.",
                                links: [],
                                lang: lang
                            )
                        }
                        
                        VStack(spacing: 0) {
                            // 헤더
                            HStack {
                                Text(headerLocation)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                Text(headerName)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                Text(headerTime)
                                    .frame(maxWidth: .infinity, alignment: .center)
                            }
                            .font(.custom("Pretendard-SemiBold", size: 14))
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .background(RoundedCorners(color: Color(hex: "B3DBC0"), tl: 20, tr: 20, bl: 0, br: 0))
                            
                            // 리스트 출력 (location 기준 정렬)
                            let sortedItems = filtered.sorted { $0.location < $1.location }
                            
                            ForEach(sortedItems) { item in
                                Rectangle()
                                    .fill(Color(hex: "B3DBC0"))
                                    .frame(height: 1)
                                HStack {
                                    Text(item.location)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                    Rectangle()
                                        .fill(Color(hex: "B3DBC0"))
                                        .frame(width: 1)
                                    Text(item.name)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                    Rectangle()
                                        .fill(Color(hex: "B3DBC0"))
                                        .frame(width: 1)
                                    Text(item.hours)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }
                                .font(.custom("Pretendard-Medium", size: 14))
                                .foregroundColor(.black)
                                .padding(.vertical, 8)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color(hex: "B3DBC0"), lineWidth: 1)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                }
            }
        }
    }
    
    // MARK: - 필터링된 리스트 생성
    private func filteredFacilities(for category: String) -> [FacilitiesItem] {
        switch category {
        case "카페/베이커리", "Café / Bakery":
            let keywordsKR = [
                "뚜레쥬르",
                "카페 ING",
                "에땅",
                "공차(신규입점)",
                "컴포즈커피",
                "카페딕셔너리",
                "카페 팬도로시"
            ]

            let keywordsEN = [
                "TOUS les JOURS",
                "Café ING",
                "Etang",
                "Gong Cha (New)",
                "Compose Coffee",
                "Café Dictionary",
                "Café PANDOROSI"
            ]

            return items.filter { item in
                if lang == .korean {
                    return keywordsKR.contains { keyword in item.name.contains(keyword) }
                } else {
                    return keywordsEN.contains { keyword in item.name.contains(keyword) }
                }
            }

        case "식당", "Dining":
            let keywordsKR = [
                "감탄떡볶이",
                "오니기리와이규동",
                "교직원식당",
                "퀴즈노스",
                "츄밥",
                "더큰도시락",
                "버거ING",
                "구시아 푸드코트",
                "기숙사식당"
            ]

            let keywordsEN = [
                "Gamtan Tteokbokki",
                "Onigiri & Gyudon",
                "Faculty Cafeteria",
                "Quiznos",
                "Chubap",
                "The Bigger Dosirak",
                "Burger ING",
                "Gusia Food Court",
                "Dormitory Cafeteria"
            ]

            return items.filter { item in
                if lang == .korean {
                    return keywordsKR.contains { keyword in item.name.contains(keyword) }
                } else {
                    return keywordsEN.contains { keyword in item.name.contains(keyword) }
                }
            }

        case "편의시설", "Convenience":
            let keywordsKR = [
                "CU 편의점",
                "카피웍스",
                "구내서점",
                "누리스토어",
                "SWEET U",
                "세븐일레븐 편의점",
                "GS25편의점",
                "설화방"
            ]

            let keywordsEN = [
                "CU Convenience Store",
                "CopyWorks",
                "Nuri Store",
                "SWEET U",
                "7-Eleven Convenience Store",
                "GS25 Convenience Store",
                "Seolhwatbang"
            ]

            return items.filter { item in
                if lang == .korean {
                    return keywordsKR.contains { keyword in item.name.contains(keyword) }
                } else {
                    return keywordsEN.contains { keyword in item.name.contains(keyword) }
                }
            }

        default:
            return items
        }
    }
}
