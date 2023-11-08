//
//  HelperUtils.swift
//  NutriAI
//
//  Created by Vian du Plessis on 2023/11/08.
//

import Foundation

func extractTextFromResponse(_ response: String) -> String? {
    if let data = response.data(using: .utf8) {
        do {
            if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let choices = jsonObject["choices"] as? [[String: Any]],
               let firstChoice = choices.first,
               let text = firstChoice["text"] as? String {
                return text
            }
        } catch {
            print("Error extracting text: \(error)")
        }
    }
    return nil
}



func trimStringToSquareBrackets(_ input: String) -> String? {
    guard let startIndex = input.firstIndex(of: "["),
          let endIndex = input.lastIndex(of: "]") else {
        // The string does not contain square brackets
        return nil
    }

    // Create a substring that includes the square brackets
    let trimmedString = input[startIndex...endIndex]

    // Convert the substring back to a String
    let result = String(trimmedString)

    return result
}

func parseJSON(from trimmedString: String) -> [[String: Any]]? {
    if let data = trimmedString.data(using: .utf8) {
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                return jsonArray
            } else {
                print("Failed to parse JSON from the string.")
                return nil
            }
        } catch {
            print("Error parsing JSON: \(error)")
            return nil
        }
    } else {
        print("Error converting the string to data.")
        return nil
    }
}
