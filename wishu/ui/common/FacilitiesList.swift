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

    var body: some View {
        ChatbotProfile()
        
        ScrollView {
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
                .background(RoundedCorners(color: Color(hex: "9E1A20"), tl: 20, tr: 20, bl: 0, br: 0))

                // location 기준으로 정렬
                let sortedItems = items.sorted { $0.location < $1.location }

                ForEach(sortedItems) { item in
                    Rectangle()
                        .fill(Color(hex: "9E1A20"))
                        .frame(height: 1)
                    HStack {
                        Text(item.location)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Rectangle()
                            .fill(Color(hex: "9E1A20"))
                            .frame(width: 1)
                        Text(item.name)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Rectangle()
                            .fill(Color(hex: "9E1A20"))
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
                    .stroke(Color(hex: "9E1A20"), lineWidth: 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}

struct RoundedCorners: View {
    var color: Color = .white
    var tl: CGFloat = 0
    var tr: CGFloat = 0
    var bl: CGFloat = 0
    var br: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let w = geometry.size.width
                let h = geometry.size.height

                // 네 모서리 둥글기 적용
                path.move(to: CGPoint(x: w / 2.0, y: 0))
                path.addLine(to: CGPoint(x: w - tr, y: 0))
                path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr,
                            startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                path.addLine(to: CGPoint(x: w, y: h - br))
                path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br,
                            startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                path.addLine(to: CGPoint(x: bl, y: h))
                path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl,
                            startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                path.addLine(to: CGPoint(x: 0, y: tl))
                path.addArc(center: CGPoint(x: tl, y: tl), radius: tl,
                            startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
            }
            .fill(color)
        }
    }
}
