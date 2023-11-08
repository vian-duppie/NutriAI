//
//  SavedItemView.swift
//  NutriAI
//
//  Created by Vian du Plessis on 2023/11/08.
//

import SwiftUI

struct SavedItemView: View {
    var data: FoodItem
    // TODO: Pass the data
    var body: some View {
        ScrollView {
            ZStack {
                VStack(alignment: .leading, spacing: 20) {
                    BackView()
                        .padding(.horizontal, 35)
                    
                    Text(data.name)
                        .font(.custom("Poppins-Medium", size: 26))
                        .foregroundColor(Color("CustomDarkGreen"))
                        .padding(.horizontal, 35)
                    
                    Text("Nutritional Information")
                        .font(.custom("Poppins-Regular", size: 18))
                        .foregroundColor(Color("CustomDarkGreen"))
                        .padding(.horizontal, 35)
                    
                    VStack(spacing: 15) {
//                        VStack(spacing: 5) {
//                            Image(systemName: "flame")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 20, height: 20)
//
//                            Text("1100kcal")
//                                .font(.custom("Poppins-Regular", size: 15))
//                                .foregroundColor(Color("CustomDarkGreen"))
//                        }
                        
                        VStack(alignment: .leading, spacing: 15) {
                            ForEach(data.nutriValues, id: \.self) { item in
                                if (item.name == "Calories") {
                                    VStack(spacing: 5) {
                                        Image(systemName: "flame")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20, height: 20)
                                        
                                        Text(String(format: "%.1f%@", item.value, item.unit))
                                            .font(.custom("Poppins-Regular", size: 15))
                                            .foregroundColor(Color("CustomDarkGreen"))
                                    }
                                } else {
                                    VStack(alignment: .leading) {
                                        Text(String(format: "%.1f%@", item.value, item.unit))
                                            .font(.custom("Poppins-Regular", size: 15))
                                            .foregroundColor(Color("CustomDarkGreen"))
                                        
                                        Text(item.name)
                                            .font(.custom("Poppins-Regular", size: 15))
                                            .foregroundColor(Color("CustomDarkGreen"))
                                    }
                                }
                            }
                        }.frame(alignment: .leading)
                        
        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(35)
                    .background(Color("CustomLightWhite"))
                    .clipShape(
                        .rect(
                            bottomTrailingRadius: 20, topTrailingRadius: 20,
                            style: .continuous
                        )
                    )
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                    .padding(.trailing, 35)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarBackButtonHidden(true)
    }
}

//#Preview {
//    SavedItemView()
//}
