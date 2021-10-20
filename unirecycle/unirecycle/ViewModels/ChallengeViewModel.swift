//
//  ChallengeViewModel.swift
//  unirecycle
//
//  Created by Bob Broersen on 14/04/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import Foundation
import Firebase

class ChallengeViewModel {
    let collectionCategories = "categories"
    let collectionChallenges = "challenges"
    let collectionUsers = "Users"

    var categories = [Category]()
    private var db = Firestore.firestore()
    
    func getLastChallenge(){
//        print(db.collection(collectionUsers).document("NZrEdkzJgJg3IDFxCqMGXwjGtbp2"))
        

    }
}
