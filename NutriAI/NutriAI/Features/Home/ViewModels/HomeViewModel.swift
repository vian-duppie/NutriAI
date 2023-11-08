import Foundation

class HomeViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var responses: [OpenAIResponse] = [] // Store responses as an array
    private var openAIConnector = OpenAIConnector()

    func searchItem() {
        let prompt = "Give me the JSON array of objects that represents the nutritional values of \(searchText).It should have an object with the following: Carbohydrate, Protein, Fat, Fibre and Calories and each of these objects should also have the values (only the values, no metrics) and the unit of measurement. Each object should be structured like this: {{name: 'Carbohydrate', value: '22', unit: 'g'}} Return only the json object without any explanation"
        

        if let result = openAIConnector.processPrompt(prompt: prompt) {
            convertResponseToJson(response: result)
        } else {
            print("Error: Unable to fetch response")
        }
    }

//    func convertResponseToJson(response: String) {
//        if let jsonObject = extractAndDecodeJSON(from: response) {
//            responses = jsonObject.map { item in
//                if let value = Float(item["value"] ?? "0.0") {
//                    return OpenAIResponse(name: item["name"] ?? "", value: value, unit: item["unit"] ?? "")
//                }
//                return OpenAIResponse(name: "", value: 0.0, unit: "")
//            }
//        } else {
//            print("Failed to parse JSON.")
//        }
//    }
  
    func convertResponseToJson(response: Any) {
        if let responseText = extractTextFromResponse(response as! String) {
            if let trimmedString = trimStringToSquareBrackets(responseText) {
                if let jsonArray = parseJSON(from: trimmedString) as? [[String: String]] {
                    // Create an array of OpenAIResponse objects
                    var convertedResponses: [OpenAIResponse] = []
                    for item in jsonArray {
                        if let name = item["name"], let valueString = item["value"], let unit = item["unit"], let value = Float(valueString) {
                            let openAIResponse = OpenAIResponse(name: name, value: value, unit: unit)
                            convertedResponses.append(openAIResponse)
                        }
                    }
                    
                    responses = convertedResponses.sorted(by: { $0.name == "Calories" && $1.name != "Calories" }) // Assign the converted responses to the property
                } else {
                    print("Failed to parse JSON.")
                }
            } else {
                print("No square brackets found in the input string.")
            }
        }
    }
    
//    func convertResponseToJson(response: Any) {
//        if let responseText = extractTextFromResponse(response as! String) {
//            if let trimmedString = trimStringToSquareBrackets(responseText) {
//                if let jsonObject = parseJSON(from: trimmedString) {
//                    print("Parsed JSON:")
//                    print(jsonObject)
//                    print(jsonObject[0]["name"])
//                    responses = jsonObject
//                } else {
//                    print("Failed to parse JSON.")
//                }
//            } else {
//                print("No square brackets found in the input string.")
//            }
//        }
//    }
}


////
////  HomeViewModel.swift
////  NutriAI
////
////  Created by Vian du Plessis on 2023/11/08.
////
//
//import Foundation
//
//class HomeViewModel: ObservableObject {
//    @Published var searchText = ""
//    @Published var response: String = ""
//    private var openAIConnector = OpenAIConnector()
//    
//    func searchItem() {
//        let prompt = "Give me the JSON array of objects that represents the nutritional values of \(searchText).It should have an object with the following: Carbohydrate, Protein, Fat, Fibre and Calories and each of these objects should also have the values (only the values, no metrics) and the unit of measurement. Each object should be structured like this: {{name: 'Carbohydrate', value: '22', unit: 'g'}} Return only the json object without any explanation"
//        
//        if let result = openAIConnector.processPrompt(prompt: prompt) {
//            response = result
//            convertResponseToJson(response: response)
//        } else {
//            print("Hey")
//            response = "Error: Unable to fetch response"
//        }
//       
//        
//    }
//}
//
//func convertResponseToJson(response: Any) {
//    if let responseText = extractTextFromResponse(response as! String) {
//        if let trimmedString = trimStringToSquareBrackets(responseText) {
//            if let jsonObject = parseJSON(from: trimmedString) {
//                print("Parsed JSON:")
//                print(jsonObject)
//                print(jsonObject[0]["name"])
//            } else {
//                print("Failed to parse JSON.")
//            }
//        } else {
//            print("No square brackets found in the input string.")
//        }
//    }
//}
