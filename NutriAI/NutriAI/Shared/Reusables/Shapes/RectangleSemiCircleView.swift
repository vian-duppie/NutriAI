//
//  RectangleSemiCircleView.swift
//  NutriAI
//
//  Created by Vian du Plessis on 2023/10/17.
//

import SwiftUI

struct RectangleSemiCircleView: View {
    @State var screenSize = UIScreen.main.bounds
    @Binding var animateSpring: Bool
    var rectangleColor: String
    var circleColor: String
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomLeading) {
                VStack(spacing: 30) {
                    ForEach(0..<4) {_ in
                        Rectangle()
                            .frame(width:  screenSize.size.width * 0.3, height: 13)
                            .foregroundColor(Color(rectangleColor))
                    }
                }
                
                Circle()
                    .frame(width: animateSpring ? 80 : 0, alignment: .leading)
                    .foregroundColor(Color(circleColor))
                    .offset(x: -(80*0.7), y: 35)
                    .zIndex(-1)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

