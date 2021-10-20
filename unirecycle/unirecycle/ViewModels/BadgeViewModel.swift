//
//  ProfileViewModel.swift
//  unirecycle
//
//  Created by mark on 28/04/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import UIKit
import Firebase

class BadgeViewModel {
    
    var badge = [Badge]()
    private var db = Firestore.firestore()
    
    let currentUser = Auth.auth().currentUser
    var userRef: DocumentReference!
    var user = Account()

    
    init() {
        fetchUserBadge()
    }

    // Fetch badges from user collection
    func fetchUserBadge(){
        db.collection("users").document(currentUser?.uid ?? "")
            .getDocument { (snapshot, error ) in
                do {
                if let document = snapshot {
                    
                    let id = document.documentID
                    var badgeEarned = [""]
                    badgeEarned = document.get("badgeEarned") as! [String]

                    for badge in badgeEarned{
                        self.fetchBadgeCollection(receivedId: badge)
                    }
                
                } else {
                    print("Document does not exist")
                }
                } catch{
                    fatalError()
                }
            }    }
    
    
    // Fetch badge data from badge collection
    func fetchBadgeCollection(receivedId: String){
            let userId = Auth.auth().currentUser?.uid
        db.collection("badges").document(receivedId) .getDocument { (querySnapshot, err) in
                if let err = err {
                    print("something went wrong::: \(err)")
                } else {

                        if let doc = querySnapshot {

                            let id = doc.documentID
                            let title = doc.data()?["title"] as? String ?? ""
                            let description = doc.data()?["description"] as? String ?? ""
                            let imageUrl = doc.data()?["imageUrl"] as? String ?? ""

                            let imageLink = URL(string: imageUrl)!

                            let imageData = try! Data(contentsOf: imageLink)

                            let image = UIImage(data: imageData) as UIImage?

                            self.badge.append(Badge(title: title, description: description, imageUrl: imageUrl))
                    }
                }
            }
    }
}




