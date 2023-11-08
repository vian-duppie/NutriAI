//
//  Test.swift
//  NutriAI
//
//  Created by Vian du Plessis on 2023/10/17.
//

import SwiftUI

struct SplashView: View {
    @State var animate: Bool = false
    @State var animateSpring: Bool = false
    
    var body: some View {
            VStack {
                RectangleSemiCircleView(animateSpring: $animateSpring, rectangleColor: "CustomYellow", circleColor: "CustomLightBlue")
                
                LeafShapeAndImageView(animate: $animate, circleColor: "CustomOrange", leafColor: "CustomDarkBlue", imageBackgroundColor: "CustomYellow", image: "SaladImage" )
                
                Spacer()
                    .frame(height: 30)
                
                VStack(alignment: .leading) {
                    HStack(spacing: 0) {
                        Text("Nutri")
                            .font(.custom("Poppins-SemiBold", size: 52))
                            .foregroundColor(Color("CustomDarkGreen"))
                        
                        Text("AI")
                            .font(.custom("Poppins-Regular", size: 52))
                            .foregroundColor(Color("CustomLightGreen"))
                    }
                  
                    Text("your personal nutrition assistant")
                        .font(.custom("Poppins-Regular", size: 18))
                        .foregroundColor(Color("CustomDarkGreen"))
                }
                .padding(.horizontal, 35)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                HStack {
                    SemiCircleShape()
                        .foregroundColor(.red)
                        .frame(width: animateSpring ? 147: 0, height: 82)
                
                }
                .frame(maxWidth: .infinity, alignment: .bottomTrailing)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(.black)
            .ignoresSafeArea(.all, edges: .bottom)
            .onAppear {
                DispatchQueue.main.async {
                    withAnimation(.interpolatingSpring(stiffness: 100, damping: 7, initialVelocity: 0.1)) {
                        animateSpring = true
                    }
                    
                    withAnimation(.easeInOut(duration: 1)) {
                        animate = true
                    }
                }
            }
    }
}

#Preview {
    SplashView()
}
