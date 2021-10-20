//
//  File.swift
//  unirecycle
//
//  Created by Bob Broersen on 02/03/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import Foundation
import UIKit

class User: Account {
    var credits: Int?
    var badges: [Badge]?
    var rewards: [Reward]?
    
//    func addActiveChallenge(challenge: Challenge) {
//        activeChallenges?.append(challenge)
//    }
//
//    func finishChallenge(challenge: Challenge) {
//        guard let index = activeChallenges?.firstIndex(where: {$0 === challenge}) else { return }
//        completedChallenges?.append(challenge)
//        activeChallenges?.remove(at: index)
//    }
    
    func addReward(reward: Reward) {
        rewards?.append(reward)
    }
    
    func addBadge(badge: Badge) {
        badges?.append(badge)
    }
    
}

class UserProfileBuilder {
    private var id: String = String()
    private var firstname: String = String()
    private var secondName: String = String()
    private var email: String = String()
    private var password: String = String()
    private var profileImage: UIImage = UIImage()
    private var joinedDate: String = String()
    private var coins: Int = Int()
    private var activeChallenge: [ActiveChallengeModel] = [ActiveChallengeModel]()
    private var completedChallenges: [CompletedChallengeModel] = [CompletedChallengeModel]()
    private var badgeEarned: [String] = [String]()



    func addFirstName(firstname: String) -> Self {
        self.firstname = firstname
        return self
    }
    
    func addSecondName(secondName: String) -> Self {
        self.secondName = secondName
        return self
    }
    
    @discardableResult
    func addEmail(email: String) -> Self {
        self.email = email
        return self
    }
    
    @discardableResult
    func addPassword(password: String) -> Self {
        self.password = password
        return self
    }
    
    @discardableResult
    func addProfileImage(profileImage: UIImage) -> Self {
        self.profileImage = profileImage
        return self
    }
    
    @discardableResult
    func addId(id: String) -> Self {
        self.id = id
        return self
    }
    
    @discardableResult
    func addDateJoined(joinedDate: String) -> Self {
        self.joinedDate = joinedDate
        return self
    }
    
    @discardableResult
    func addCoins(coins: Int) -> Self {
        self.coins = coins
        return self
    }
    
    @discardableResult
    func addChallenge(activechallenges: [ActiveChallengeModel]) -> Self {
        self.activeChallenge = activeChallenge
        return self
    }
    
    @discardableResult
    func addCompletedChallenge(completedChallenges: [CompletedChallengeModel]) -> Self {
        self.completedChallenges = completedChallenges
        return self
    }
    
    @discardableResult
    func addBadgeEarned(badgeEarned: [String]) -> Self {
        self.badgeEarned = badgeEarned
        return self
    }
    
    func build() -> User{
        return User(id: id, firstName: firstname, secondName: secondName, email: email, password: password, profileImage: profileImage, joinedDate: joinedDate, coins: coins, activeChallenges: activeChallenge, completedChallenges: completedChallenges, badgeEarned: badgeEarned)
    }
}
