//
//  User.swift
//  unirecycle
//
//  Created by Bob Broersen on 10/02/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import Foundation
import UIKit

class Account {
    var id: String?
    var firstName: String?
    var secondName: String?
    var email: String?
    var password: String?
    var profileImage: UIImage?
    var coins: Int?
    var joinedDate: String?
    var activeChallenges: [ActiveChallengeModel]?
    var completedChallenges: [CompletedChallengeModel]?
    var badgeEarned: [String]?


    
    init(id: String, firstName: String,secondName: String, email: String, password: String, profileImage: UIImage, joinedDate: String, coins: Int, activeChallenges: [ActiveChallengeModel], completedChallenges: [CompletedChallengeModel], badgeEarned: [String]) {
        self.id = id
        self.firstName = firstName
        self.secondName = secondName
        self.email = email
        self.password = password
        self.profileImage = profileImage
        self.joinedDate = joinedDate
        self.coins = coins
        self.activeChallenges = activeChallenges
        self.completedChallenges = completedChallenges
        self.badgeEarned = badgeEarned
    }
    
    init() {
        
    }
}
