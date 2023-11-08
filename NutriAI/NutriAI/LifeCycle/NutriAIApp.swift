//
//  NutriAIApp.swift
//  NutriAI
//
//  Created by Vian du Plessis on 2023/10/17.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct NutriAIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State private var response: String = ""
    @State private var prompt: String = "Give me the JSON array of objects that represents the nutritional values of (Banana).It should have an object with the following: Carbohydrate, Protein, Fat, Fibre and Calories and each of these objects should also have the values (only the values, no metrics) and the unit of measurement. Each object should be structured like this: {{name: 'Carbohydrate', value: '22', unit: 'g'}} Return only the json object without any explanation"
    
    @StateObject var HomeVM = HomeViewModel()
    @StateObject var UserVM = UserViewModel()
    @StateObject var NutriVM = NutriInfoViewModel()
    
    let openAIConnector = OpenAIConnector()
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                AppSwitcher()
                    .environmentObject(HomeVM)
                    .environmentObject(UserVM)
            }
        }
    }
}

struct AppSwitcher: View {
    @AppStorage ("isUserFirstTime") var isUserFirstTime: Bool = true
    
    @State var isActive: Bool = true
    
    //Firebase auth check
    @EnvironmentObject var UserVM: UserViewModel
    
    var body: some View {
        if isActive {
            SplashView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        isActive = false
                    }
                    UserVM.checkAuth()
                }
        } else {
            if UserVM.isLoggedIn {
                MainView()
                    .navigationBarBackButtonHidden(true)
            } else {
                AppStartSwitcher()
            }
        }
    }
}

struct AppStartSwitcher: View {
    @AppStorage("isOnboardingCompleted") var isOnboardingCompleted: Bool = false
    
    var body: some View {
        if isOnboardingCompleted {
            AuthSwitcher()
        } else {
            OnboardingView()
        }
    }
}

struct AuthSwitcher: View {
    @EnvironmentObject var UserVM: UserViewModel
    
    var body: some View {
        if UserVM.showLogin {
            LoginView()
        } else {
            SignUpView()
        }
    }
}

