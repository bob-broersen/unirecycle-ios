//
//  LeaderboardViewModel.swift
//  unirecycle
//
//  Created by Emre Efe on 06/05/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import Foundation
import UIKit
import Firebase

struct Person {
    var image: UIImage
    var title: String
    var coins: Int
    var myself: Bool
}

class LeaderboardViewModel {
    let collectionUsers = "users"
    var weekLeaderboard = [LeaderboardPerson]()
    var monthLeaderboard = [LeaderboardPerson]()
    var weekPersons = [Person]()
    var monthPersons = [Person]()
    private var db = Firestore.firestore()
    let currentUser = Auth.auth().currentUser
    
    init() {
        fetchAllCompleted()
    }
    
    func getRankForWeek() -> String {
        return weekLeaderboard.filter{ $0.myself == true }.first?.rank ?? "0"
    }
    
    func getRankForMonth() -> String {
        return monthLeaderboard.filter{ $0.myself == true }.first?.rank ?? "0"
    }
    
    func fetchAllCompleted(){
        db.collection("users").getDocuments(){ (snapshot, err) in
            do {
                if let documents = snapshot?.documents {
                    for document in documents {
                        let group = DispatchGroup()
                        let id = document.documentID
                        let firstName = document.get("firstName") as? String ?? ""
                        
                        let imageUrl = document.get("imageUrl") as? String ?? "None"
                        var image = UIImage(named: "no-pf")!
                        if imageUrl != "None" {
                            let url = URL(string: imageUrl)
                            let data = try? Data(contentsOf: url!)
                            if data != nil {
                                image = UIImage(data: data!) ?? UIImage(named: "no-pf")!
                            }
                        }
                        
                        var myself = false
                        
                        let completedChallengeDict = document.get("completedChallenges") as? [Dictionary<String, Any>] ?? [[:]]
                        var weekCoins = 0
                        var monthCoins = 0
                        for challenge in completedChallengeDict {
                            group.enter()
                            let value = challenge["sp"] as? Int ?? 0
                            let endDateFirebase = challenge["date"] as? Timestamp ?? Timestamp()
                            let endDate = endDateFirebase.dateValue() as NSDate
                            if (self.isPrevWeek(from: endDate.timeIntervalSinceNow)){
                                weekCoins += value
                            }
                            if (self.isPrevMonth(from: endDate.timeIntervalSinceNow)){
                                monthCoins += value
                            }
                            
                        }
                        if self.currentUser?.uid == id {
                            myself = true
                        }
                        self.weekPersons.append(Person(image: image, title: firstName, coins: weekCoins, myself: myself))
                        self.monthPersons.append(Person(image: image, title: firstName, coins: monthCoins, myself: myself))
                    }
                }
                else {
                    print("Document does not exist")
                    
                }
            }
            
            self.createWeekLeaderboard()
            self.createMonthLeaderboard()
        }
        
    }
    
    func isPrevWeek(from interval : TimeInterval) -> Bool
    {
        let day = getDayDifference(from: interval)
        if day <= 0 && day >= -7 { return true}
        else { return false }
    }
    
    
    func isPrevMonth(from interval : TimeInterval) -> Bool
    {
        let day = getDayDifference(from: interval)
        if day <= 0 && day >= -30 { return true}
        else { return false }
    }
    
    func getDayDifference(from interval : TimeInterval) -> Int
    {
        let calendar = Calendar.current
        let date = Date(timeIntervalSinceNow: interval)
        let startOfNow = calendar.startOfDay(for: Date())
        let startOfTimeStamp = calendar.startOfDay(for: date)
        let components = calendar.dateComponents([.day], from: startOfNow, to: startOfTimeStamp)
        let day = components.day!
        return day
    }
    
    func createWeekLeaderboard(){
        createLeaderboard(personArray: &weekPersons, leaderboardPersonArray: &weekLeaderboard)
    }
    
    func createMonthLeaderboard(){
        createLeaderboard(personArray: &monthPersons, leaderboardPersonArray: &monthLeaderboard)
    }
    
    func createLeaderboard(personArray: inout [Person], leaderboardPersonArray: inout [LeaderboardPerson]){
        personArray.sort(by: {$0.coins > $1.coins})
        let indexOfPerson1 = personArray.firstIndex(where: {$0.myself == true}) ?? -1
        
        // top 3
        for i in 0..<3 {
            let newIndex = (i + 1).description
            leaderboardPersonArray.append(LeaderboardPerson(rank: newIndex, image: personArray[i].image, title: personArray[i].title, coins: personArray[i].coins, myself: personArray[i].myself))
        }
        
        // top 30
        if(indexOfPerson1 >= 17){
            let minRange = indexOfPerson1 - 15
            let maxRange = indexOfPerson1 + 15
            
            appendToArray(minRange: minRange, maxRange: maxRange, personArray: personArray, leaderboardPersonArray: &leaderboardPersonArray)
        } else {
            var minRange = 0
            var maxRange = 15
            if(indexOfPerson1 > 2){
                minRange = indexOfPerson1 - 2
            } else {
                minRange = 2
            }
            maxRange = maxRange * 2 - minRange
            appendToArray(minRange: minRange, maxRange: maxRange, personArray: personArray, leaderboardPersonArray: &leaderboardPersonArray)
        }
    }
    
    func appendToArray(minRange: Int, maxRange: Int, personArray: [Person], leaderboardPersonArray: inout [LeaderboardPerson]){
        for i in 0..<personArray.count {
            if i <= minRange || i > maxRange {
                /// Avoid
                continue
            }
        let newIndex = (i + 1).description
        leaderboardPersonArray.append(LeaderboardPerson(rank: newIndex, image: personArray[i].image, title: personArray[i].title, coins: personArray[i].coins, myself: personArray[i].myself))
        }
    }
}


