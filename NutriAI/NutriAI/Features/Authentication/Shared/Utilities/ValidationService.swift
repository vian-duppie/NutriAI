//
//  ValidationService.swift
//  NutriAI
//
//  Created by Vian du Plessis on 2023/10/18.
//

import Foundation

//class ValidationService {
    func validateEmail(_ email: String) -> String {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email) ? "" : "Invalid email"
    }

    func validatePassword(_ password: String) -> String {
        return password.isEmpty ? "Password is required" : ""
    }

func validateName(input: String, minLength: Int) -> String {
    if(input.isEmpty) {
        return "Please enter your name"
    }
    
    if(input.count < minLength) {
        return "Too short"
    }
    
    return ""
}

func validateSurname(input: String, minLength: Int) -> String {
    if(input.isEmpty) {
        return "Please enter your surname"
    }
    
    if(input.count < minLength) {
        return "Too short"
    }
    
    return ""
}
//}
