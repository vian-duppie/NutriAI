//
//  LoginView.swift
//  NutriAI
//
//  Created by Vian du Plessis on 2023/10/18.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var SignUpVM: UserViewModel
    @State var isPasswordField: Bool = true
    
    var body: some View {
        ZStack{
            if SignUpVM.isBusy {
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
                            heading: "Welcome!",
                            subheading1: "Sign Up",
                            subheading2: "to get started",
                            subheading2Color: "CustomLightBlue",
                            description: "Complete the form below to create your account"
                        )
                        
                        Spacer()
                            .frame(height: 40)
                        
                        VStack(spacing: 15) {
                            CustomInput(
                                textValue: $SignUpVM.name,
                                label: "Name",
                                placeholder: "Enter your first name here",
                                showHintLabel: SignUpVM.showNameHint,
                                hintLabel: SignUpVM.nameHint,
                                hintIsError: SignUpVM.isNameHintError
                            )
                            
                            CustomInput(
                                textValue: $SignUpVM.surname,
                                label: "Surname",
                                placeholder: "Enter your last name here",
                                showHintLabel: SignUpVM.showSurnameHint,
                                hintLabel: SignUpVM.surnameHint,
                                hintIsError: SignUpVM.isSurnameHintError
                            )
                            
                            CustomInput(
                                textValue: $SignUpVM.email,
                                label: "Email Address",
                                placeholder: "johndoe@gmail.com",
                                showHintLabel: SignUpVM.showEmailHint,
                                hintLabel: SignUpVM.emailHint,
                                hintIsError: SignUpVM.isEmailHintError
                            )
                            
                            CustomInput(
                                textValue: $SignUpVM.password,
                                isPasswordField: isPasswordField,
                                label: "Password",
                                placeholder: "Enter your password here",
                                icon: isPasswordField ? "eye" : "eye.slash",
                                iconAction: {isPasswordField.toggle()},
                                showHintLabel: SignUpVM.showPasswordHint,
                                hintLabel: SignUpVM.passwordHint,
                                hintIsError: SignUpVM.isPasswordHintError
                            )
                        }
                        
                        Spacer()

                        VStack(alignment: .trailing, spacing: 10) {
                            Button(action: {
                                SignUpVM.signUp()
                            }, label: {
                                Text("Sign Up")
                                    .font(.custom("Poppins-Medium", size: 18))
                                    .foregroundColor(Color("CustomWhite"))
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                                    .background(Color("CustomOrange"))
                                    .cornerRadius(10)
                            })
                            
                            HStack(spacing: 5) {
                                Text("Already have an account?")
                                    .font(.custom("Poppins-Medium", size: 15))
                                    .foregroundColor(.black)
                                
//                                NavigationLink(destination: LoginView().navigationBarBackButtonHidden(true)) {
                                    Text("Log In")
                                        .font(.custom("Poppins-Medium", size: 15))
                                        .foregroundColor(.black)
                                        .underline()
                                        .onTapGesture {
                                            SignUpVM.showLogin = true
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
    SignUpView()
}
