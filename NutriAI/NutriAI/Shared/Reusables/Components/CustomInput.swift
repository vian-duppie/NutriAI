//
//  CustomInput.swift
//  NutriAI
//
//  Created by Vian du Plessis on 2023/11/06.
//

import SwiftUI

struct CustomInput: View {
    @Binding var textValue: String
    
    var isPasswordField: Bool = false
    var label: String = ""
    var placeholder: String = ""
    var icon: String = ""
    var iconAction: () -> Void = {}
    
    var showHintLabel: Bool = false
    var hintLabel: String = ""
    var hintIsError: Bool = false
    
    var body: some View {
        VStack(spacing: 5) {
            VStack(alignment: .leading) {
                Text(label)
                    .font(.custom("Poppins-Medium", size: 18))
                    .foregroundColor(Color("CustomDarkGreen"))
                
                HStack {
                    if !isPasswordField {
                        TextField(placeholder, text: $textValue)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                            .font(.custom("Poppins-Regular", size: 16))
                    } else {
                        SecureField(placeholder, text: $textValue)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                            .font(.custom("Poppins-Regular", size: 16))
                    }
                  
                    
                    if !icon.isEmpty {
                        Image(systemName: icon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color("CustomLightBlue"))
                            .frame(width: 30, height: 30)
                            .onTapGesture {
                                iconAction()
                            }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color("CustomWhite"))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.1), radius: 1, x:0, y: 1)
            
            if showHintLabel {
                Text(hintLabel)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .font(.custom("Poppins-Regular", size: 12))
                    .foregroundColor(hintIsError ? .red : Color("CustomDarkBlue"))
                    .opacity(0.5)
            }
        }
    }
}
