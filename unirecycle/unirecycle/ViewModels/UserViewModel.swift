//
//  UserViewModel.swift
//  unirecycle
//
//  Created by Daron on 05/05/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import Foundation
import Firebase

struct FireStoreActiveChallenge {
    var endDate: Timestamp
    var startDate: Timestamp
    var daysCompleted: [Timestamp]
    var challengeId: String
}

class UserViewModel {
    
    var user = Account()
    private var db = Firestore.firestore()
    
    let currentUser = Auth.auth().currentUser
    
    func fetchUser(callback: @escaping () -> Void){
        
        db.collection("users").document(currentUser!.uid)
            .getDocument { [self] (snapshot, error ) in
                do {
                    if let document = snapshot {
                        let group = DispatchGroup()
                        
                        let id = document.documentID
                        let firstName = document.get("firstName") as? String ?? ""
                        let secondName = document.get("secondName") as? String ?? ""
                        let imageUrl = document.get("imageUrl") as? String ?? ""
                        let joinedDate = document.get("joinedDate") as? String ?? ""
                        let coins = document.get("coins") as? Int ?? 0
                        let challengeDict = document.get("activeChallenges") as? [Dictionary<String, Any>] ?? [[:]]
                        
                        
                        var challenges: [ActiveChallengeModel] = []
                        
                        for challenge in challengeDict {
                            group.enter()
                            let waste = challenge["waste"] as? Int ?? 0
                            let value = challenge["sp"] as? Int ?? 0
                            let co2 = challenge["co2"] as? Int ?? 0
                            let challengeId = challenge["challengeId"] as? String ?? ""
                            let startDateFirebase = challenge["startDate"] as? Timestamp ?? Timestamp()
                            let startDate = startDateFirebase.dateValue() as NSDate
                            let endDateFirebase = challenge["endDate"] as? Timestamp ?? Timestamp()
                            let endDate = endDateFirebase.dateValue() as NSDate
                            let daysCompletedFirebase = challenge["daysCompleted"] as? [Timestamp] ?? [Timestamp()]
                            var daysCompleted = [NSDate]()
                            
                            for d in daysCompletedFirebase {
                                daysCompleted.append(d.dateValue() as NSDate)
                            }
                            
                            getChallenge(challengeId: challengeId, completionChallenge: {
                                category, challenge in
                                challenges.append(ActiveChallengeModel(id: challengeId, title: challenge.title, subtitle: challenge.subtitle, endDate: endDate, startDate: startDate, imageUrl: challenge.imageUrl, value: challenge.value, co2: co2, daysCompleted: daysCompleted, waste: waste, category: category))
                                group.leave()
                            })
                        }
                        
                        let completedChallengeDict = document.get("completedChallenges") as? [Dictionary<String, Any>] ?? [[:]]
                        
                        var completedChallenges: [CompletedChallengeModel] = []
                        
                        for challenge in completedChallengeDict {
                            group.enter()
                            let waste = challenge["waste"] as? Int ?? 0
                            let value = challenge["sp"] as? Int ?? 0
                            let co2 = challenge["co2"] as? Int ?? 0
                            let challengeId = challenge["challengeId"] as? String ?? ""
                            let endDateFirebase = challenge["endDate"] as? Timestamp ?? Timestamp()
                            let endDate = endDateFirebase.dateValue() as NSDate
                            
                            getChallenge(challengeId: challengeId, completionChallenge: {
                                category, challenge in
                                completedChallenges.append(CompletedChallengeModel(id: challengeId, title: challenge.title, subtitle: challenge.subtitle, imageUrl: challenge.imageUrl, value: value, co2: co2, waste: waste, category: category, endDate: endDate))
                                group.leave()
                            })
                        }
                        
                        
                        group.notify(queue: .main, execute: { // executed after all async calls in for loop finish
                            let imageLink = URL(string: imageUrl)
                            
                            let imageData = try? Data(contentsOf: imageLink!)
                            
                            let image = UIImage(data: imageData!) as UIImage?
                            
                            
                            self.user = Account(id: id, firstName: firstName, secondName: secondName, email: "", password: "", profileImage: image ?? UIImage(), joinedDate: joinedDate, coins: coins, activeChallenges: challenges, completedChallenges: completedChallenges, badgeEarned: [""])
                            callback()
                        })
                    }
                    else {
                        print("Document does not exist")
                        
                    }
                }
            }
    }
    
    func getCoinsAllTime() -> Int{
        var coins = 0
        for completedChallenge in user.completedChallenges ?? [] {
            coins += completedChallenge.value
        }
        return coins
    }
    
    func getCoinsThisWeek() -> Int {
        let calendar = NSCalendar.current
        let date = Date()
        let startOfWeek = calendar.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: date).date!
        var dayComponent = DateComponents()
        dayComponent.day = 7
        let endOfWeek = calendar.date(byAdding: dayComponent, to: startOfWeek)
        
        
        var coins = 0
        for completedChallenge in user.completedChallenges ?? [] {
            if (completedChallenge.endDate as Date > startOfWeek && endOfWeek! > completedChallenge.endDate as Date) {
                coins += completedChallenge.value
            }
        }
        return coins
    }
    
    func getTotalWasteSaved() -> Int {
        var totalWaste = 0
        for completedChallenge in user.completedChallenges ?? [] {
            totalWaste += completedChallenge.waste
        }
        return totalWaste
    }
    
    func getTotalCo2Saved() -> Int {
        var totalCo2 = 0
        for completedChallenge in user.completedChallenges ?? [] {
            totalCo2 += completedChallenge.co2
        }
        return totalCo2
    }
    
    func getCategory(categoryId: String, completionCategory: @escaping (Category) -> Void) {
        db.collection("categories").document(categoryId).getDocument { (snapshot, error ) in
            do {
                if let document = snapshot {
                    
                    let darkHex = document.get("darkHex") as? String ?? ""
                    let lightHex = document.get("lightHex") as? String ?? ""
                    let imageUrl = document.get("imageUrl") as? String ?? ""
                    let name = document.get("name") as? String ?? ""
                    
                    completionCategory(Category(name: name, imageUrl: imageUrl, challenges: [], darkHex: darkHex, lightHex: lightHex))
                }
                else {
                    print("Document does not exist")
                }
            }
        }
    }
    
    lazy var queue = {
        return DispatchQueue(label: "thread-safe-obj", attributes: .concurrent)
    }()
    
    
    func getChallenge(challengeId: String, completionChallenge: @escaping (Category, Challenge) -> Void) {
        var challenge: Challenge?
        self.db.collection("challenges").document(challengeId).getDocument { (snapshot, error ) in
            if let document = snapshot {
                let title = document.get("title") as? String ?? ""
                let subTitle = document.get("subtitle") as? String ?? ""
                let image = document.get("image") as? String ?? ""
                let categoryId = document.get("category") as? String ?? ""
                let value = document.get("value") as? Int ?? 0
                                
                self.getCategory(categoryId: categoryId, completionCategory: { activeCategory in
                    challenge = Challenge(id: challengeId, title: title, subtitle: subTitle, imageUrl: image, value: value, co2: 0, waste: 0)
                    completionChallenge(activeCategory, challenge!)
                })
            }
            else {
                print("Document does not exist")
            }
        }
    }
    
    func updateUserCoins(coins: Int){
        db.collection("users").document(currentUser!.uid).updateData([
            "coins": coins
        ])
    }
    
    func completeActiveChallenge(coins: Int, earnedCoins: Int, completedChallenge: ActiveChallengeModel) {
        var firestoreActiveChallenge = [Any]()
        var fireStoreCompletedChallenge = [Any]()
        
        var tempFireStoreActiveChall = [String : Any]()
        var tempFireStoreCompletedChall = [String : Any]()

        
        for completedChall in user.completedChallenges! {
            tempFireStoreCompletedChall["challengeId"] = completedChall.id
            tempFireStoreCompletedChall["date"] = Timestamp(date: completedChall.endDate as Date)
            tempFireStoreCompletedChall["sp"] = completedChall.value
            
            fireStoreCompletedChallenge.append(tempFireStoreCompletedChall)
        }
        
        tempFireStoreCompletedChall["challengeId"] = completedChallenge.id
        tempFireStoreCompletedChall["date"] = Timestamp(date: completedChallenge.endDate as Date)
        tempFireStoreCompletedChall["sp"] = earnedCoins
        
        fireStoreCompletedChallenge.append(tempFireStoreCompletedChall)
        
       
        for (index, activeChallenge) in user.activeChallenges!.enumerated() {
            var firestoreDateArray = [Timestamp]()
            
            for dayCompleted in activeChallenge.daysCompleted {
                let firestoreCompletedDate = Timestamp(date: dayCompleted as Date)
                firestoreDateArray.append(firestoreCompletedDate)
            }
            tempFireStoreActiveChall["endDate"] = Timestamp(date: activeChallenge.endDate as Date)
            tempFireStoreActiveChall["startDate"] = Timestamp(date: activeChallenge.startDate as Date)
            tempFireStoreActiveChall["daysCompleted"] = firestoreDateArray
            tempFireStoreActiveChall["challengeId"] = activeChallenge.id
            
            firestoreActiveChallenge.append(tempFireStoreActiveChall)
            
            if activeChallenge.id == completedChallenge.id {
                firestoreActiveChallenge.remove(at: index)
            }
        }
        
        db.collection("users").document(currentUser!.uid).setData(["activeChallenges": firestoreActiveChallenge], merge: true)
        db.collection("users").document(currentUser!.uid).setData(["completedChallenges": fireStoreCompletedChallenge], merge: true)
        updateUserCoins(coins: coins)
    }
    
    func updateDaysComplete(challengeId: String){
        
        var firestoreActiveChallenge = [Any]()
        
        var tempFireStoreActiveC = [String : Any]()
        
        for (index, activeChallenge) in user.activeChallenges!.enumerated() {
            //check for the challenge that has to be updated
            if activeChallenge.id == challengeId {
                
                var firestoreDateArray = [Timestamp]()
                // convert NSDate to FS timestamp
                for dayCompleted in activeChallenge.daysCompleted {
                    let firestoreCompletedDate = Timestamp(date: dayCompleted as Date)
                    //fill array with new timestamps
                    firestoreDateArray.append(firestoreCompletedDate)
                }
                //add current date to activeChallenge to add a day
                firestoreDateArray.append(Timestamp())
                
                // fill in dictionary with all data
                tempFireStoreActiveC["endDate"] = Timestamp(date: activeChallenge.endDate as Date)
                tempFireStoreActiveC["startDate"] = Timestamp(date: activeChallenge.startDate as Date)
                tempFireStoreActiveC["daysCompleted"] = firestoreDateArray
                tempFireStoreActiveC["challengeId"] = activeChallenge.id
                
                //add to array for firestore index
                firestoreActiveChallenge.append(tempFireStoreActiveC)
            }
            //else does not add a new current date to the end, it just copies the existing activeChallenge
            else {
                var firestoreDateArray = [Timestamp]()
                
                for dayCompleted in activeChallenge.daysCompleted {
                    let firestoreCompletedDate = Timestamp(date: dayCompleted as Date)
                    firestoreDateArray.append(firestoreCompletedDate)
                }
                tempFireStoreActiveC["endDate"] = Timestamp(date: activeChallenge.endDate as Date)
                tempFireStoreActiveC["startDate"] = Timestamp(date: activeChallenge.startDate as Date)
                tempFireStoreActiveC["daysCompleted"] = firestoreDateArray
                tempFireStoreActiveC["challengeId"] = activeChallenge.id
                
                firestoreActiveChallenge.append(tempFireStoreActiveC)
            }
        }
        // refetch activechallenges for active challenge page
        db.collection("users").document(currentUser!.uid).setData(["activeChallenges": firestoreActiveChallenge], merge: true)
    }
    
    func updateActiveChallenge(challengeId: String){
        
        var firestoreActiveChallenge = [Any]()
        
        var tempFireStoreActiveC = [String : Any]()
        
        let currentDate = Date()

        var dateComponent = DateComponents()

        dateComponent.day = 7

        let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
      
        for (index, activeChallenge) in user.activeChallenges!.enumerated() {
            tempFireStoreActiveC["endDate"] = Timestamp(date: activeChallenge.endDate as Date)
            tempFireStoreActiveC["startDate"] = Timestamp(date: activeChallenge.startDate as Date)
            var firestoreDateArray = [Timestamp]()
            
            for dayCompleted in activeChallenge.daysCompleted {
                let firestoreCompletedDate = Timestamp(date: dayCompleted as Date)
                firestoreDateArray.append(firestoreCompletedDate)
            }
            tempFireStoreActiveC["daysCompleted"] = firestoreDateArray
            tempFireStoreActiveC["challengeId"] = activeChallenge.id
            firestoreActiveChallenge.append(tempFireStoreActiveC)

        }


                // fill in dictionary with all data
                tempFireStoreActiveC["endDate"] = futureDate
                tempFireStoreActiveC["startDate"] = Date()
                tempFireStoreActiveC["daysCompleted"] = []
                tempFireStoreActiveC["challengeId"] = challengeId
                //add to array for firestore index
        
                firestoreActiveChallenge.append(tempFireStoreActiveC)
            
   
        // refetch activechallenges for active challenge page
        db.collection("users").document(currentUser!.uid).setData(["activeChallenges": firestoreActiveChallenge], merge: true)
    }
}


