//
//  NutriInfoView.swift
//  NutriAI
//
//  Created by Vian du Plessis on 2023/11/07.
//

import SwiftUI

struct LibraryActionCard: View {
    @Binding var showLibraryActionCard: Bool
    var body: some View {
        VStack{
            VStack(spacing: 10) {
                Image(systemName: "book.closed")
                    .resizable()
                    .foregroundColor(Color("CustomLightBlue"))
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                
                Text("Added to Library")
                    .font(.custom("Poppins-SemiBold", size: 20))
                    .foregroundColor(Color("CustomDarkGreen"))
                    .padding(.horizontal, 35)
                
                Text("Banana has been added to Vian's Library")
                    .font(.custom("Poppins-Regular", size: 17))
                    .foregroundColor(Color("CustomDarkGreen"))
                    .padding(.horizontal, 35)
                    .multilineTextAlignment(.center)
            }
            .padding(15)
            
            VStack(spacing: 25) {
                NavigationLink(destination: LibraryView()) {
                    Text("Open Library")
                        .font(.custom("Poppins-Medium", size: 17))
                        .foregroundColor(Color("CustomDarkGreen"))
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .padding(10)
                        .border(.gray)
                }
                
                Button(action: {
                    //
                    showLibraryActionCard = false
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(Color("CustomWhite"))
                        .aspectRatio(contentMode: .fit)
                        .padding(10)
                        .background(.red)
                        .cornerRadius(216)
                }
            }
        }
        .padding(.bottom, 15)
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.7), radius: 8, x: 0, y: 4)
        
    }
}

struct NutriInfoView: View {
    @State var name: String
    
    var nutriValues: [OpenAIResponse] = [
        OpenAIResponse(name: "Carbohydrate", value: 22, unit: "g"),
        OpenAIResponse(name: "Protein", value: 1, unit: "g"),
        OpenAIResponse(name: "Fibre", value: 2.6, unit: "g"),
        OpenAIResponse(name: "Calories", value: 89, unit: "kcal")
    ]
//    [["unit": g, "value": 22, "name": Carbohydrate], ["unit": g, "value": 1, "name": Protein], ["value": 0.3, "name": Fat, "unit": g], ["unit": g, "value": 2.6, "name": Fibre], ["unit": kcal, "value": 89, "name": Calories]]
    
    var screenWidth = UIScreen.main.bounds.size.width
    @State var showLibraryActionCard: Bool = false
    
//    init(nutriValues: [OpenAIResponse]) {
//           self.nutriValues = nutriValues.sorted(by: { $0.name == "Calories" && $1.name != "Calories" })
//       }
    
    @EnvironmentObject var HomeVM: HomeViewModel
    @StateObject var NutriVM =  NutriInfoViewModel()
    @EnvironmentObject var UserVM: UserViewModel
    
    // TODO: Pass the data
    var body: some View {
        ScrollView {
            ZStack {
                if showLibraryActionCard {
                    LibraryActionCard(showLibraryActionCard: $showLibraryActionCard)
                        .padding(.vertical, 30)
                        .padding(.horizontal, 35)
                        .zIndex(999)
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    BackView()
                        .padding(.horizontal, 35)
                    
                    Text(name)
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
                            ForEach(nutriValues, id: \.self) { item in
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
                    
                    Spacer()
                        .frame(height: 20)
                    
                    VStack {
                        Button(action: {
                            //
                            print(nutriValues)
                            print(name)
                            let foodItem = FoodItem(name: name, nutriValues: nutriValues, userId: UserVM.getUserId())
                                        NutriVM.saveFoodItemToLibrary(foodItem: foodItem)
                            showLibraryActionCard = true
                        }) {
                            //TODO: Add colour and responsiveness
                            Text("Add to Library")
                                .font(.custom("Poppins-Medium", size: 15))
                                .foregroundColor(Color("CustomWhite"))
                                .aspectRatio(contentMode: .fit)
                                .padding(10)
                                .background(Color("CustomLightBlue"))
                                .cornerRadius(16)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarBackButtonHidden(true)
    }
}

struct BackView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Button(action: {
                dismiss()
            }) {
                //TODO: Add colour and responsiveness
                Image(systemName: "arrow.left")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color("CustomWhite"))
                    .aspectRatio(contentMode: .fit)
                    .padding(10)
                    .background(Color("CustomLightBlue"))
                    .cornerRadius(200)
                    
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    NutriInfoView(name: "test", nutriValues: [
        OpenAIResponse(name: "Carbohydrate", value: 22, unit: "g"),
        OpenAIResponse(name: "Protein", value: 1, unit: "g"),
        OpenAIResponse(name: "Fibre", value: 2.6, unit: "g"),
        OpenAIResponse(name: "Calories", value: 89, unit: "kcal")
    ])
}
