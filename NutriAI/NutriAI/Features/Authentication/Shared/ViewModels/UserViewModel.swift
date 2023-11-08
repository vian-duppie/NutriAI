//
//  UserViewModel.swift
//  NutriAI
//
//  Created by Vian du Plessis on 2023/11/08.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseAuth

class UserViewModel: ObservableObject {
    private let db = Firestore.firestore()
    
    @Published var name: String = ""
    @Published var nameHint: String = ""
    @Published var showNameHint: Bool = false
    @Published var isNameHintError: Bool = false
    
    @Published var surname: String = ""
    @Published var surnameHint: String = ""
    @Published var showSurnameHint: Bool = false
    @Published var isSurnameHintError: Bool = false
    
    @Published var email: String = ""
    @Published var emailHint: String = ""
    @Published var showEmailHint: Bool = false
    @Published var isEmailHintError: Bool = false
    
    @Published var password: String = ""
    @Published var passwordHint: String = ""
    @Published var showPasswordHint: Bool = false
    @Published var isPasswordHintError: Bool = false
    
    @Published var isBusy: Bool = false
    @Published var isLoggedIn: Bool = false
    @Published var showLogin: Bool = true
    
    func resetStates() {
        nameHint = ""
        showNameHint = false
        isNameHintError = false
        
        surnameHint = ""
        showSurnameHint = false
        isSurnameHintError = false
        
        emailHint = ""
        showEmailHint = false
        isEmailHintError = false
        
        passwordHint = ""
        showPasswordHint = false
        isPasswordHintError = false
    }
    
    func firebaseSignUp() {
        self.isBusy = true
        
        Auth.auth().createUser(withEmail: email, password: password) { [self] authResult, err in
            if err != nil {
                if let errCode = AuthErrorCode.Code(rawValue: err!._code) {
                    switch errCode {
                        case .emailAlreadyInUse:
                            self.emailHint = "Email is already in use"
                        case .weakPassword:
                            self.passwordHint = "Password must be 6 characters or longer"
                        case .invalidEmail:
                            self.emailHint = "Invalid Email"
                        default:
                            self.passwordHint = err!.localizedDescription
                    }
                    
                    self.isPasswordHintError = true
                    self.isEmailHintError = true
                    self.showEmailHint = isEmailHintError
                    self.showPasswordHint = isPasswordHintError
                }
                
                self.isBusy = false
            } else {
                print(authResult!.user.uid)
                createUserInDB(name: name, surname: surname, email: email, userId: authResult!.user.uid)
                self.isBusy = false
            }
        }
    }
    
    // Add a user document to the db
    func createUserInDB(name: String, surname: String, email: String, userId: String) {
        db
            .collection("Users")
            .document(userId)
            .setData([
                "username": "\(name) \(surname)",
                "email": email
//                "profile_img": ""
            ]) { err in
                if let err = err {
                    print("There was an error writing the document: \(err)")
                } else {
                    print("Document was writed successfully")
                    self.isLoggedIn = true
                }
            }
    }
    
    func signUp() {
        if validateSignUpData() {
            firebaseSignUp()
            print("we can continue")
        }
    }
    
    func validateSignUpData() -> Bool {
        resetStates()
        
        nameHint = validateName(input: name, minLength: 1)
        surnameHint = validateSurname(input: surname, minLength: 1)
        emailHint = validateEmail(email)
        passwordHint = validatePassword(password)

        isNameHintError = !nameHint.isEmpty
        isSurnameHintError = !surnameHint.isEmpty
        isEmailHintError = !emailHint.isEmpty
        isPasswordHintError = !passwordHint.isEmpty
        
        showNameHint = isNameHintError
        showSurnameHint = isSurnameHintError
        showEmailHint = isEmailHintError
        showPasswordHint = isPasswordHintError

        // Return true if there are no errors
        return nameHint.isEmpty && surnameHint.isEmpty && emailHint.isEmpty && passwordHint.isEmpty
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            isLoggedIn = false
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
    func getUserId() -> String {
        return Auth.auth().currentUser?.uid ?? "No user id found"
    }
    
    func checkAuth() {
        if Auth.auth().currentUser?.uid != nil {
            isLoggedIn = true
        } else {
            isLoggedIn = false
        }
    }
    
    func validateLoginData() -> Bool {
        resetStates()
        
        emailHint = validateEmail(email)
        passwordHint = validatePassword(password)

        isEmailHintError = !emailHint.isEmpty
        isPasswordHintError = !passwordHint.isEmpty
        
        showEmailHint = isEmailHintError
        showPasswordHint = isPasswordHintError

        // Return true if there are no errors
        return emailHint.isEmpty && passwordHint.isEmpty
    }
    
    func login() {
        if validateLoginData() {
            firebaseLogin()
        }
    }
    
    func firebaseLogin() {
        self.isBusy = true
        
        Auth.auth().signIn(withEmail: email, password: password) { [self] (res, err) in
            if err != nil {
                if let errCode = AuthErrorCode.Code(rawValue: err!._code) {
                    switch errCode {
                        case .userDisabled:
                            self.passwordHint = "Account disabled"
                        case .wrongPassword:
                            self.passwordHint = "Wrong password"
                        case .invalidEmail:
                            self.emailHint = "Invalid Email"
                        default:
                            self.passwordHint = err!.localizedDescription
                    }
                    
                    self.isPasswordHintError = true
                    self.isEmailHintError = true
                    self.showEmailHint = isEmailHintError
                    self.showPasswordHint = isPasswordHintError
                }
                
                self.isBusy = false
            } else {
                // Success
                print("Success")
                isLoggedIn = true
                self.isBusy = false
            }
        }
    }
}
