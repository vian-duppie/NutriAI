//
//  LoginView.swift
//  NutriAI
//
//  Created by Vian du Plessis on 2023/10/18.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var LoginVM: UserViewModel
    @State var isPasswordField: Bool = true
    
    var body: some View {
        ZStack{
            if LoginVM.isBusy {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color("CustomWhite")))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.black)
                    .opacity(0.7)
                    .zIndex(10)
            }
                                    
            GeometryReader { geo in
                ScrollView {
                    VStack {
                        AuthenticationHeaderView(
                            heading: "Welcome Back!",
                            subheading1: "Log In",
                            subheading2: "to continue",
                            subheading2Color: "CustomOrange",
                            description: "Complete the form below to log in"
                        )
                        
                        Spacer()
                            .frame(height: 40)
                        
                        VStack(spacing: 15) {
                            CustomInput(
                                textValue: $LoginVM.email,
                                label: "Email Address",
                                placeholder: "johndoe@gmail.com",
                                showHintLabel: LoginVM.showEmailHint,
                                hintLabel: LoginVM.emailHint,
                                hintIsError: LoginVM.isEmailHintError
                            )
                            
                            CustomInput(
                                textValue: $LoginVM.password,
                                isPasswordField: isPasswordField,
                                label: "Password",
                                placeholder: "Enter your password here",
                                icon: isPasswordField ? "eye" : "eye.slash",
                                iconAction: {isPasswordField.toggle()},
                                showHintLabel: LoginVM.showPasswordHint,
                                hintLabel: LoginVM.passwordHint,
                                hintIsError: LoginVM.isPasswordHintError
                            )
                        }
                        
                        Spacer()

                        VStack(alignment: .trailing, spacing: 10) {
                            Button(action: {
                                LoginVM.login()
                            }, label: {
                                Text("Log In")
                                    .font(.custom("Poppins-Medium", size: 18))
                                    .foregroundColor(Color("CustomWhite"))
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                                    .background(Color("CustomLightBlue"))
                                    .cornerRadius(10)
                            })
                            
                            HStack(spacing: 5) {
                                Text("Don't have an account?")
                                    .font(.custom("Poppins-Medium", size: 15))
                                    .foregroundColor(.black)
                                
//                                NavigationLink(destination: SignUpView().navigationBarBackButtonHidden(true)) {
                                    Text("Sign Up")
                                        .font(.custom("Poppins-Medium", size: 15))
                                        .foregroundColor(.black)
                                        .underline()
                                        .onTapGesture {
                                            print("Hey")
                                            LoginVM.showLogin = false
                                        }
//                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.bottom, 30)
                    }
                    .frame(maxWidth: .infinity, minHeight: geo.size.height)
                    .padding(.horizontal, 35)
                }
            }
            .scrollBounceBehavior(.basedOnSize)
            .background(Color("CustomLightWhite"))
        }
    }
}

#Preview {
    LoginView()
}
