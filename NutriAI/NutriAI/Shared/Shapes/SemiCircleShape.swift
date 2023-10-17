//
//  SemiCircleShape.swift
//  NutriAI
//
//  Created by Vian du Plessis on 2023/10/17.
//

import SwiftUI

struct SemiCircleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.0033*width, y: 0.99992*height))
        path.addCurve(to: CGPoint(x: 0.0033*width, y: 0.99992*height), control1: CGPoint(x: 0.01502*width, y: 0.90854*height), control2: CGPoint(x: 0.01502*width, y: 0.90854*height))
        path.addCurve(to: CGPoint(x: 0.68052*width, y: 0.00724*height), control1: CGPoint(x: 0.06331*width, y: 0.43185*height), control2: CGPoint(x: 0.34436*width, y: 0.00365*height))
        path.addCurve(to: CGPoint(x: 0.99833*width, y: 0.15004*height), control1: CGPoint(x: 0.79542*width, y: 0.00847*height), control2: CGPoint(x: 0.90353*width, y: 0.06*height))
        path.addCurve(to: CGPoint(x: 0.99833*width, y: 0.60357*height), control1: CGPoint(x: 0.99833*width, y: 0.2987*height), control2: CGPoint(x: 0.99833*width, y: 0.43894*height))
        path.addCurve(to: CGPoint(x: 0.99833*width, y: 0.99991*height), control1: CGPoint(x: 0.99833*width, y: 0.85357*height), control2: CGPoint(x: 0.99929*width, y: 0.7167*height))
        path.addLine(to: CGPoint(x: 0.0033*width, y: 0.99992*height))
        path.closeSubpath()
        return path
    }
}

#Preview {
    SemiCircleShape()
}
