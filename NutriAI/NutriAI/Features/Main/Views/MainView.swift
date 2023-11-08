//
//  MainView.swift
//  NutriAI
//
//  Created by Vian du Plessis on 2023/11/08.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            HomeView()
                .navigationBarBackButtonHidden(true)
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                        
                        Text("Home")
                    }
                     
                }
//                .toolbarBackground(Color("Background"), for: .tabBar)
            
            LibraryView()
                .navigationBarBackButtonHidden(true)
                .tabItem {
                    VStack {
                        Image(systemName: "book.closed")
                        
                        Text("Library")
                    }
                }
//                .toolbarBackground(Color("Background"), for: .tabBar)
            
//            LibraryView()
//                .navigationBarBackButtonHidden(true)
//                .tabItem {
//                    VStack {
//                        Image(systemName: "frying.pan")
//                        
//                        Text("Recipes")
//                    }
//                }
//                .toolbarBackground(Color("Background"), for: .tabBar)
            
            ProfileView()
                .navigationBarBackButtonHidden(true)
                .tabItem {
                    VStack {
                        Image(systemName: "person")
                        
                        Text("Profile")
                    }
                }
//                .toolbarBackground(Color("Background"), for: .tabBar)
            
//            SettingsView()
//                .navigationBarBackButtonHidden(true)
//                .tabItem {
//                    VStack {
//                        Image(systemName: "gearshape")
//                        
//                        Text("Settings")
//                    }
//                }
////                .toolbarBackground(Color("Background"), for: .tabBar)
            

        }
        .accentColor(Color("CustomLightBlue"))
        .toolbarBackground(Color("CustomLightWhite"), for: .tabBar)
    }
}

#Preview {
    MainView()
}
