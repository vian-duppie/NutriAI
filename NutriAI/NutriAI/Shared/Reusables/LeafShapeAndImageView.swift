//
//  LeafShapeAndImageView.swift
//  NutriAI
//
//  Created by Vian du Plessis on 2023/10/17.
//

import SwiftUI

struct LeafShapeAndImageView: View {
    @Binding var animate: Bool
    var circleColor: String
    var leafColor: String
    var imageBackgroundColor: String
    var image: String
    
    var body: some View {
        HStack {
            VStack {
                Circle()
                    .frame(width: animate ? 50 : 0)
                    .foregroundColor(Color(circleColor))
                
                LeafShape()
                    .frame(width: animate ? 70 : 0, height: 70)
                    .foregroundColor(Color(leafColor))
            }
            
            Image(image)
                .resizable()
                .frame(width: 190, height: 190)
                .padding(10)
                .background(Color(imageBackgroundColor))
                .clipShape(Circle())
              
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .offset(x: 60)
    }
}
