//
//  AuthenticationHeaderView.swift
//  NutriAI
//
//  Created by Vian du Plessis on 2023/10/18.
//

import SwiftUI

struct AuthenticationHeaderView: View {
    var heading: String = ""
    var subheading1: String = ""
    var subheading2: String = ""
    var subheading2Color: String = ""
    var description: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(heading)
                .font(.custom("Poppins-Medium", size: 30))
                .foregroundColor(Color("CustomDarkGreen"))
            
            HStack {
                Text(subheading1)
                    .font(.custom("Poppins-Medium", size: 30))
                    .foregroundColor(Color(subheading2Color))
                
                Text(subheading2)
                    .font(.custom("Poppins-Medium", size: 30))
                    .foregroundColor(Color("CustomDarkGreen"))
            }
            
            Spacer()
                .frame(height: 25)
            
            Text(description)
                .font(.custom("Poppins-Regular", size: 17))
                .foregroundColor(.black)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
    }
}

#Preview {
    AuthenticationHeaderView()
}
