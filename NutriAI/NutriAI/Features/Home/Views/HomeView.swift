//
//  HomeView.swift
//  NutriAI
//
//  Created by Vian du Plessis on 2023/11/07.
//

import SwiftUI

struct HomeView: View {
    @State private var isSearching: Bool = false
//    @State private var searchText: String = ""
    @EnvironmentObject var HomeVM: HomeViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HeaderView(username: "Vian du Plessis")
                
                HStack {
                    //TODO: Add colour and break out into component
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    
                    TextField("Search Food", text: $HomeVM.searchText)
                        .onChange(of: HomeVM.searchText) {
                            if HomeVM.searchText.count == 0 {
                                isSearching = false
                            }
                            print(HomeVM.searchText)
                        }
                    
                    Spacer()
                    
                    // TODO: Check if item exists or do api call
                    Text("search")
                        .font(.custom("Poppins-Medium", size: 14))
                        .foregroundColor(Color("CustomLightBlue"))
                        .onTapGesture {
                            if HomeVM.searchText.count >= 1 {
                                isSearching = true
                                HomeVM.searchItem()
                            }
                            print("hey sakkie, maak n chatgpt calls")
                        }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 15)
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color("CustomDarkBlue"), lineWidth: 2)
                )
                
                if isSearching {
                    VStack(spacing: 15) {
                        HStack {
                            Text("Showing results for \(HomeVM.searchText)")
                                .font(.custom("Poppins-Medium", size: 18))
                                .foregroundColor(Color("CustomDarkGreen"))
                            
                            Spacer()
                            
                            Text("clear")
                                .font(.custom("Poppins-Medium", size: 14))
                                .foregroundColor(Color("CustomLightBlue"))
                                .onTapGesture {
                                    isSearching = false
                                    HomeVM.searchText = ""
                                }
                        }
                             
                        SearchCard(response: HomeVM.responses)
                    }
                }
                
                VStack {
                    Text("What would you like to do")
                        .font(.custom("Poppins-Medium", size: 26))
                        .foregroundColor(Color("CustomDarkGreen"))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
              
                
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 15)], spacing: 15) {
                    ActionCard(icon: "square.3.layers.3d", iconColor: "CustomOrange", title: "Library", description: "View your previously searched foods", navigateToView: LibraryView())
                 }
            }
        }
        .padding(.horizontal, 35)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct HeaderView: View {
    var username: String
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Welcome Back")
                .font(.custom("Poppins-Medium", size: 26))
                .foregroundColor(Color("CustomDarkGreen"))
            
            Text(username)
                .font(.custom("Poppins-Regular", size: 14))
                .foregroundColor(Color("CustomOrange"))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ActionCard<Content: View>: View {
    var icon: String = ""
    var iconColor: String = ""
    var title: String = ""
    var description: String = ""
    var navigateToView: Content
    
    var body: some View {
        NavigationLink(destination: navigateToView) {
            HStack(spacing: 10) {
                VStack {
                    Image(systemName: icon)
                        .resizable()
                        .foregroundColor(Color(iconColor))
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                }
                .padding(15)
                .background(Color(iconColor).opacity(0.2))
                .cornerRadius(16)
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.custom("Poppins-Medium", size: 16))
                        .foregroundColor(Color("CustomDarkGreen"))
                    
                    Text(description)
                        .font(.custom("Poppins-Light", size: 10))
                        .foregroundColor(Color("CustomDarkGreen"))
                }
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color("CustomLightWhite"))
            .cornerRadius(16)
        }
    }
}

struct SearchCard: View {
    var response: [OpenAIResponse]
    @EnvironmentObject var HomeVM: HomeViewModel
    @EnvironmentObject var UserVM: UserViewModel
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(HomeVM.searchText)
                         .font(.custom("Poppins-Medium", size: 16))
                         .foregroundColor(Color("CustomDarkGreen"))

                     HStack(spacing: 10) {
                         Image(systemName: "flame")
                             .resizable()
                             .aspectRatio(contentMode: .fit)
                             .frame(width: 15, height: 15)

                         Text(String(format: "%.1f%@", response[0].value, response[0].unit))
                             .font(.custom("Poppins-Light", size: 10))
                             .foregroundColor(Color("CustomDarkGreen"))
                     }
            }
            
            Spacer()
            
            NavigationLink(destination: NutriInfoView(name: HomeVM.searchText, nutriValues: response).environmentObject(UserVM)) {
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

#Preview {
    HomeView()
}
