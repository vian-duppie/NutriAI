//
//  OpenAIConnector.swift
//  NutriAI
//
//  Created by Vian du Plessis on 2023/11/08.
//

import Foundation

public class OpenAIConnector {
    // MARK: - IMPORTANT STUFF TO READ
    /// Follow along with the article and fill out these two.
    /// If you're building for MacOS, head to the target using this file, Signing & Capabilities, App Sandbox, and enable Outgoing Connections (Client). This lets your app connect to the OpenAI Servers.
    let openAIURL = URL(string: "https://api.openai.com/v1/engines/text-davinci-002/completions")
    var openAIKey: String {
        return "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"
    }
    
    private func executeRequest(request: URLRequest, withSessionConfig sessionConfig: URLSessionConfiguration?) -> Data? {
        let semaphore = DispatchSemaphore(value: 0)
        let session: URLSession
        if (sessionConfig != nil) {
            session = URLSession(configuration: sessionConfig!)
        } else {
            session = URLSession.shared
        }
        var requestData: Data?
        let task = session.dataTask(with: request as URLRequest, completionHandler:{ (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if error != nil {
                print("error: \(error!.localizedDescription): \(error!.localizedDescription)")
            } else if data != nil {
                requestData = data
            }
            
            print("Semaphore signalled")
            semaphore.signal()
        })
        task.resume()
        
        // Handle async with semaphores. Max wait of 10 seconds
        let timeout = DispatchTime.now() + .seconds(20)
        print("Waiting for semaphore signal")
        let retVal = semaphore.wait(timeout: timeout)
        print("Done waiting, obtained - \(retVal)")
        return requestData
    }
    
    public func processPrompt(prompt: String) -> Optional<String> {
        /// cURL stuff.
        var request = URLRequest(url: self.openAIURL!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(self.openAIKey)", forHTTPHeaderField: "Authorization")
        
        let httpBody: [String: Any] = [
            "prompt" : prompt,
            /// Adjust this to control the maxiumum amount of tokens OpenAI can respond with.
            "max_tokens" : 1000
            /// You can add more parameters below, but make sure they match the ones in the OpenAI API Reference.
        ]
        
        var httpBodyJson: Data
        
        do {
            httpBodyJson = try JSONSerialization.data(withJSONObject: httpBody, options: .prettyPrinted)
        } catch {
            print("Unable to convert to JSON \(error)")
            return nil
        }
        
        request.httpBody = httpBodyJson
         if let requestData = executeRequest(request: request, withSessionConfig: nil) {
             let jsonStr = String(data: requestData, encoding: .utf8)!
             print("Hey from backend")
             print(jsonStr)
//             print("Testing")
//             print(jsonStr)

             return jsonStr
         }
        
        return nil
    }
}

struct OpenAIResponseHandler {
    func decodeJson(jsonString: String) -> OpenAIResponse? {
        let json = jsonString.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        do {
            let product = try decoder.decode(OpenAIResponse.self, from: json)
            return product
            
        } catch {
            print("Error decoding OpenAI API Response")
        }
        
        return nil
    }
}

struct OpenAIResponse: Codable, Hashable {
//    var id: String
    var name: String
    var value: Float
    var unit: String
}


func extractAndDecodeJSON(from text: String) -> [[String: String]]? {
    do {
        // Find the JSON string within the text
        let pattern = "\\[{\\s*\"name\":\"[^\"]+\",\"value\":\"[^\"]+\",\"unit\":\"[^\"]+\"\\}\\]"
        let regex = try NSRegularExpression(pattern: pattern, options: .dotMatchesLineSeparators)
        
        if let match = regex.firstMatch(in: text, options: [], range: NSRange(text.startIndex..., in: text)),
           let jsonRange = Range(match.range, in: text) {
            let jsonString = String(text[jsonRange])
            
            // Remove backslashes
            let cleanedString = jsonString.replacingOccurrences(of: "\\", with: "")
            
            // Decode the JSON
            if let jsonData = cleanedString.data(using: .utf8) {
                let decodedJSON = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: String]]
                return decodedJSON
            }
        }
    } catch {
        print("Error extracting and decoding JSON: \(error)")
    }
    
    return nil
}
//[
//    {
//        "name": "Carbohydrate",
//        "value": "79.15",
//        "unit": "g"
//    },
//    {
//        "name": "Protein",
//        "value": "6.67",
//        "unit": "g"
//    },
//    {
//        "name": "Fat",
//        "value": "0.58",
//        "unit": "g"
//    },
//    {
//        "name": "Fibre",
//        "value": "1.3",
//        "unit": "g"
//    },
//    {
//        "name": "Calories",
//        "value": "358",
//        "unit": "kcal"
//    }
//]


