//
//  RewardViewModel.swift
//  unirecycle
//
//  Created by Daron on 22/04/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import Firebase

struct rewardsFilter {
    var min: Int
    var max: Int
    var category: String
    var type: String
}

class RewardViewModel {

    private let collectionRewards = "rewards"

    var rewards = [Reward]()
    var filteredArray = [Reward]()
    
    private var db = Firestore.firestore()
    
    init() {
        fetchAllRewards()
    }
    
    func fetchAllRewards() {
        db.collection(collectionRewards).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("something went wrong::: \(err)")
            } else {
                if let documents = querySnapshot?.documents {

                    for doc in documents {
                       
                        let title = doc.data()["title"] as? String ?? ""
                        let imageUrl = doc.data()["imageUrl"] as? String ?? ""
                        let brandName = doc.data()["brandName"] as? String ?? ""
                        let productDescription = doc.data()["productDescription"] as? String ?? ""
                        let price = doc.data()["price"] as? Int ?? 0
                        let category = doc.data()["category"] as? String ?? ""
                        let type = doc.data()["type"] as? String ?? ""
                        self.rewards.append(Reward(brandName: brandName, imageUrl: imageUrl, price: price, productDescription: productDescription, title: title, category: category, type: type))
                        
                    }
                }
            }
        }
    }
    
    
    
    func fetchFilteredRewards(filters: rewardsFilter) {
        filteredArray.removeAll()
        if (filters.category.isEmpty && filters.type.isEmpty) {
            filteredArray = rewards.filter{$0.price >= filters.min && $0.price <= filters.max}
        }
        else if (filters.type.isEmpty) {
            filteredArray = rewards.filter{$0.price >= filters.min && $0.price <= filters.max &&  $0.category.contains(filters.category)}
        }
        else if (filters.category.isEmpty) {
            filteredArray = rewards.filter{$0.price >= filters.min && $0.price <= filters.max &&  $0.type.contains(filters.type)}
        } else {
            filteredArray = rewards.filter{$0.price >= filters.min && $0.price <= filters.max && $0.category.contains(filters.category) &&  $0.type.contains(filters.type)}
        }
    }
    }
