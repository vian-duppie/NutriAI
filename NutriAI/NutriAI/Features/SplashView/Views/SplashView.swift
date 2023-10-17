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
//                        .fontWeight(.bold)
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
            .ignoresSafeArea(.all, edges: .bottom)
            .onAppear {
                withAnimation(.interpolatingSpring(stiffness: 100, damping: 7, initialVelocity: 0.1)) {
                    animateSpring = true
                }
                
                withAnimation(.easeInOut(duration: 1)) {
                    animate = true
                }
            }

    }
}

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




#Preview {
    SplashView()
}
