//
//  LibraryView.swift
//  NutriAI
//
//  Created by Vian du Plessis on 2023/11/08.
//

import SwiftUI

struct LibraryView: View {
    @State var selectedItem = ""
    var categories: [String] = ["Test", "hey", "what"]
    @StateObject var NutriVM = NutriInfoViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                BackView()
                    .padding(.horizontal, 35)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Vian's Library")
                        .font(.custom("Poppins-Medium", size: 26))
                        .foregroundColor(Color("CustomDarkGreen"))
                        
                    Text("You can view your saved foods and your nutritional summary of the day here")
                        .font(.custom("Poppins-Regular", size: 14))
                        .foregroundColor(Color("CustomOrange"))
                }
                .padding(.horizontal, 35)
                
                Text("Saved Foods")
                    .font(.custom("Poppins-Regular", size: 18))
                    .foregroundColor(Color("CustomDarkGreen"))
                    .padding(.horizontal, 35)
                
                
                VStack {
                    ForEach(NutriVM.savedFoodItems) { item in
                        HStack {
                            VStack {
                                Text(item.name)
                                    .font(.custom("Poppins-Medium", size: 16))
                                    .foregroundColor(Color("CustomDarkGreen"))
                                
                                HStack(spacing: 10) {
                                    Image(systemName: "flame")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 15, height: 15)
                                    
                                    Text(String(format: "%.1f%@", item.nutriValues[0].value, item.nutriValues[0].unit))
                                        .font(.custom("Poppins-Light", size: 10))
                                        .foregroundColor(Color("CustomDarkGreen"))
                                }
                            }
                            
                            Spacer()
                            
                            NavigationLink(destination: SavedItemView(data: item)) {
                                Image(systemName: "arrow.right")
                                    .foregroundColor(Color("CustomWhite"))
                                    .padding(5)
                                    .background(Color("CustomLightBlue"))
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color("CustomLightWhite"))
                        .cornerRadius(16)
                    }
                }
                .padding(.horizontal, 35)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            NutriVM.fetchUserSavedFoodItems()
        }
    }
}


struct CategoryFilter: View {
    @State var selectedItem: String = ""
    var categories: [String] = ["Drinks", "Fruit", "Veg"]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 15) {
                Spacer()
                    .frame(width: 20)
                
                ForEach(categories, id: \.self) { item in
                    VStack {
                        Text(item)
                            .foregroundColor(Color("CustomDarkGreen"))
                            .padding(8)
                            .cornerRadius(10)
                            .onTapGesture {
                                withAnimation {
                                    if selectedItem == item {
                                        selectedItem = ""
        //                                        RecipesVM.clearFilter()
                                    } else {
                                        selectedItem = item
        //                                        RecipesVM.categoryFilterRecipes(filterCategory: item.name)
                                    }
                                }
                            }
                        
                        if selectedItem == item {
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(Color("CustomLightBlue"))
                        }
                    }
           
                }
            }
//            .onAppear {
//                selectedItem = ""
//            }
        }
        .scrollIndicators(.hidden)
    }
}

struct NutriValueData: View {
    var totalSize: CGFloat = 35
    var percentage: CGFloat = 20
    var chartColor: String = "CustomOrange"
    var amount: String = "25g"
    var title: String = "Carbohydrate"

    var body: some View {
        HStack {
            ZStack {
                Rectangle()
                    .frame(width: totalSize, height: totalSize)
                    .foregroundColor(Color(chartColor).opacity(0.5))
                
                Rectangle()
                    .frame(width: totalSize * percentage / 100, height: totalSize * percentage / 100)
                    .foregroundColor(Color(chartColor))
            }
            
            VStack(alignment: .leading) {
                Text(amount)
                    .font(.custom("Poppins-Regular", size: 15))
                    .foregroundColor(Color("CustomDarkGreen"))
                
                Text(title)
                    .font(.custom("Poppins-Regular", size: 15))
                    .foregroundColor(Color("CustomDarkGreen"))
            }
        }
    }
}

#Preview {
    LibraryView()
}
