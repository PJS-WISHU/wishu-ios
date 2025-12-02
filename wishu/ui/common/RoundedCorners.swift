//
//  RoundedCorners.swift
//  wishu
//
//  Created by 김은영 on 12/2/25.
//

import SwiftUI

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
                
                path.move(to: CGPoint(x: w / 2.0, y: 0))
                
                path.addLine(to: CGPoint(x: w - tr, y: 0))
                path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr,
                            startAngle: .degrees(-90), endAngle: .degrees(0), clockwise: false)
                
                path.addLine(to: CGPoint(x: w, y: h - br))
                path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br,
                            startAngle: .degrees(0), endAngle: .degrees(90), clockwise: false)
                
                path.addLine(to: CGPoint(x: bl, y: h))
                path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl,
                            startAngle: .degrees(90), endAngle: .degrees(180), clockwise: false)
                
                path.addLine(to: CGPoint(x: 0, y: tl))
                path.addArc(center: CGPoint(x: tl, y: tl), radius: tl,
                            startAngle: .degrees(180), endAngle: .degrees(270), clockwise: false)
            }
            .fill(color)
        }
    }
}
