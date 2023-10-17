//
//  LeafShape.swift
//  NutriAI
//
//  Created by Vian du Plessis on 2023/10/17.
//

import SwiftUI

struct LeafShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.0023*width, y: 0.00535*height))
        path.addCurve(to: CGPoint(x: 0.99774*width, y: 0.99471*height), control1: CGPoint(x: 0.52307*width, y: -0.02688*height), control2: CGPoint(x: 0.96874*width, y: 0.41608*height))
        path.addCurve(to: CGPoint(x: 0.0023*width, y: 0.00535*height), control1: CGPoint(x: 0.47698*width, y: 1.02693*height), control2: CGPoint(x: 0.0313*width, y: 0.58398*height))
        path.closeSubpath()
        return path
    }
}

#Preview {
    LeafShape()
}
