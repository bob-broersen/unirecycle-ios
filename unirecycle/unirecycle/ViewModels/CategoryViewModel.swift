//
//  ChallengeViewModel.swift
//  unirecycle
//
//  Created by Daron on 12/03/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import UIKit
import Firebase

class CategoryViewModel {
    let collectionCategories = "categories"
    let collectionChallenges = "challenges"

    var categories = [Category]()
    private var db = Firestore.firestore()
    
    init() {
        fetchCategories()
    }
    
    func fetchCategories() {
        db.collection(collectionCategories).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("something went wrong::: \(err)")
            } else {
                if let documents = querySnapshot?.documents {

                    for doc in documents {
                       
                        let name = doc.data()["name"] as? String ?? ""
                        let imageUrl = doc.data()["imageUrl"] as? String ?? ""
                        let darkHex = doc.data()["darkHex"] as? String ?? ""
                        let lightHex = doc.data()["lightHex"] as? String ?? ""

                        var challenges: [Challenge] = []
                    
                        self.getAllChallenges(categoryId: doc.documentID, completion: { retrievedChallenges in
                            challenges = retrievedChallenges
                            self.categories.append(Category(name: name, imageUrl: imageUrl, challenges: challenges, darkHex: darkHex, lightHex: lightHex))
                        })
                    }
                }
            }
        }
    }
    
    func getAllChallenges(categoryId: String, completion: @escaping ([Challenge]) -> Void) {
        var challenges: [Challenge] = []
        db.collection(collectionChallenges).whereField("category", isEqualTo: categoryId).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("something went wrong::: \(err)")
            } else {
                if let documents = querySnapshot?.documents {

                    for doc in documents {
                       
                        let id = doc.documentID
                        let title = doc.data()["title"] as? String ?? ""
                        let subtitle = doc.data()["subtitle"] as? String ?? ""
                        let image = doc.data()["image"] as? String ?? ""
                        let value = doc.data()["value"] as? Int ?? 0
                        let co2 = doc.data()["co2"] as? Int ?? 0
                        let waste = doc.data()["waste"] as? Int ?? 0

                        challenges.append(Challenge(id: id, title: title, subtitle: subtitle, imageUrl: image, value: value, co2: co2, waste: waste))
                    }
                }
                completion(challenges)
            }
        }

    }

    func fetchSpecificChallege(completion: @escaping(Result<Challenge, Error>) -> Void) {
        
        var challanges: Challenge?
        
        db.collection("challenges").document("c7BSWzTnnSRoXclS2b2Q").getDocument { (snapshot, error ) in
            do {
                if let document = snapshot {
                    let title = document.get("title") as? String ?? ""
                    let subtitle = document.get("subtitle") as? String ?? ""
                    let image = document.get("image") as? String ?? ""
                    let value = document.get("value") as? Int ?? 0
                    let waste = document.get("waste") as? Int ?? 0
                    let co2 = document.get("co2") as? Int ?? 0
                    
                    challanges = Challenge(id: ""
                                           , title: title
                                           , subtitle: subtitle
                                           , imageUrl: image
                                           , value: value
                                           , co2: co2
                                           , waste: waste
                    )
                    
                    DispatchQueue.main.async {
                        completion(.success(challanges!))
                    }
                    
                } else {
                    
                }
                
            } catch{
                fatalError()
            }
        }
    }
}
