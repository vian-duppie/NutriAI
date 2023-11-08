//
//  ProfileView.swift
//  NutriAI
//
//  Created by Vian du Plessis on 2023/11/08.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var UserVM: UserViewModel
    @State var textValue = ""
    var body: some View {
        VStack {
//            Spacer()
//            
//            VStack {
//                HStack {
//                    Image(systemName: "person")
//                        .resizable()
//                        .frame(width: 20, height: 20)
//                        .aspectRatio(contentMode: .fit)
//                        .foregroundColor(Color("CustomLightBlue"))
//
//                    Text("Vian du Plessis")
//                        .font(.custom("Poppins-Regular", size: 15))
//                        .foregroundColor(Color("CustomDarkGreen"))
//                }
//                
//                Spacer()
//                    .frame(height: 20)
//                
//                VStack {
//                    VStack {
//                        TextField("Calories Goal", text: $textValue)
//                            .textInputAutocapitalization(.never)
//                            .disableAutocorrection(true)
//                            .font(.custom("Poppins-Regular", size: 16))
//                            .multilineTextAlignment(.center)
//                        
//                        Rectangle()
//                            .frame(height: 1)
//                            .foregroundColor(Color("CustomLightBlue"))
//                    }
//                    
//                    VStack {
//                        TextField("Protein Goal", text: $textValue)
//                            .textInputAutocapitalization(.never)
//                            .disableAutocorrection(true)
//                            .font(.custom("Poppins-Regular", size: 16))
//                            .multilineTextAlignment(.center)
//                        
//                        Rectangle()
//                            .frame(height: 1)
//                            .foregroundColor(Color("CustomLightBlue"))
//                    }
//                }
//            
//                
//            }
//            .padding()
//            .frame(maxWidth: .infinity)
//            .background(Color("CustomLightWhite"))
//            .cornerRadius(16)
//            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
            
            Spacer()
            
            VStack {
                Button(action: {
                    UserVM.signOut()
                }) {
                    VStack {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .resizable()
                                .frame(width: 20, height: 20)
                            
                            Text("Log Out")
                                .font(.custom("Poppins-Regular", size: 15))
                                .foregroundColor(Color("CustomDarkGreen"))
                            
                            Spacer()
                        }
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color("CustomLightWhite"))
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
            
            Spacer()
        }
        .padding(.horizontal, 35)
    }
}

#Preview {
    ProfileView()
}
