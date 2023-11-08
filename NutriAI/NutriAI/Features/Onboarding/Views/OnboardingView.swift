//
//  Test.swift
//  NutriAI
//
//  Created by Vian du Plessis on 2023/10/17.
//

import SwiftUI

struct OnboardingView: View {
    @State var animate: Bool = false
    @State var animateSpring: Bool = false
    @AppStorage("isOnboardingCompleted") var isOnboardingCompleted: Bool = false
    
    @State var onboardingIndex: Int = 0
    
    var body: some View {
            VStack {
                HStack(alignment: .top) {
                    RectangleSemiCircleView(animateSpring: $animateSpring, rectangleColor: onboardingData[onboardingIndex].rectangleColor, circleColor: onboardingData[onboardingIndex].rectangeCircleColor)
                    
                    Button(action: {
                        onboardingIndex -= 1
                    }, label: {
                        Text("Skip")
                            .font(.custom("Poppins-Medium", size: 16))
                            .foregroundColor(Color("CustomDarkBlue"))
                    })
                    
                }
                .padding(.trailing, 35)
                
                LeafShapeAndImageView(
                    animate: $animate,
                    circleColor: onboardingData[onboardingIndex].leafCircleColor,
                    leafColor: onboardingData[onboardingIndex].leafColor,
                    imageBackgroundColor: onboardingData[onboardingIndex].imageBackgroundColor,
                    image: onboardingData[onboardingIndex].image
                )
                
                Spacer()
                    .frame(height: 30)
                
                VStack(alignment: .leading) {
                    Text(onboardingData[onboardingIndex].title)
                        .font(.custom("Poppins-SemiBold", size: 50))
                        .foregroundColor(Color("CustomDarkGreen"))
                                        
                    Text(onboardingData[onboardingIndex].title2)
                        .font(.custom("Poppins-Regular", size: 50))
                        .foregroundColor(Color("CustomLightGreen"))
                }
                .padding(.horizontal, 35)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                HStack {
                    ForEach(Array(onboardingData.enumerated()), id: \.element.id) { index, item in
                        Circle()
                            .frame(width: 16, height: 16)
                            .foregroundColor(Color("CustomLightBlue"))
                            .opacity(index <= onboardingIndex ? 1 : 0.2)
                    }
                    
                    Button(action: {
                        withAnimation(.easeInOut(duration: 1)) {
                            if onboardingIndex == 1 {
                                isOnboardingCompleted = true
                            } else {
                                onboardingIndex += 1
                            }
                            
                        }
                    }, label: {
                        ZStack(alignment: .center){
                            SemiCircleShape()
                                .foregroundColor(.red)
                                .frame(width: animateSpring ? 147: 0, height: 82)
                            
                            Image(systemName: "arrow.right")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25)
                                .offset(x: 25)
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity, alignment: .bottomTrailing)
                    })
                }
                .padding(.leading, 35)
                

            }
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
    OnboardingView()
}
