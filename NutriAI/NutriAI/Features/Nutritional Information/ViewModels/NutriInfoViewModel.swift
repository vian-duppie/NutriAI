//
//  NutriInfoViewModel.swift
//  NutriAI
//
//  Created by Vian du Plessis on 2023/11/08.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseAuth


class NutriInfoViewModel: ObservableObject {
    private let db = Firestore.firestore()
    
    @Published var savedFoodItems: [FoodItem] = []

    // Function to fetch user's saved food items
    func fetchUserSavedFoodItems() {
        if let userId = Auth.auth().currentUser?.uid {
            print(userId)
            db.collection("Library")
                .whereField("userId", isEqualTo: userId)
                .addSnapshotListener { (querySnapshot, error) in
                    if let error = error {
                        print("Error fetching user's saved food items: \(error)")
                    } else {
                        var items: [FoodItem] = []
                        for document in querySnapshot?.documents ?? [] {
                            if let foodItem = try? document.data(as: FoodItem.self) {
                                items.append(foodItem)
                            } else {
                                print("Problem")
                            }
                        }
                        self.savedFoodItems = items
                    }
                }
        }
    }

    func saveFoodItemToLibrary(foodItem: FoodItem) {
        do {
            _ = try db.collection("Library").addDocument(from: foodItem)
            print("Food item saved with an auto-generated ID")
        } catch {
            print("Error saving food item: \(error.localizedDescription)")
        }
    }
}

struct FoodItem: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var nutriValues: [OpenAIResponse]
    var userId: String
}
