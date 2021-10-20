//
//  ProfileViewModel.swift
//  unirecycle
//
//  Created by mark on 28/04/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewModel {
    
    var user = Account()
    private var db = Firestore.firestore()
    let currentUser = Auth.auth().currentUser
    
    init() {
        fetchUser()
    }
    
    // Fetch user data from Firestore
    func fetchUser(){
        
        db.collection("users").document(currentUser?.uid ?? "")
            .getDocument { (snapshot, error ) in
                do {
                    if let document = snapshot {
                        
                        let id = document.documentID
                        let firstName = document.get("firstName") as? String ?? ""
                        let secondName = document.get("secondName") as? String ?? ""
                        let imageUrl = document.get("imageUrl") as? String ?? ""
                        let joinedDate = document.get("joinedDate") as? String ?? ""
                        let badgeEarned = document.get("badgeEarned") as? [String] ?? []
                        let completedChallenges = document.get("completedChallenges") as? [CompletedChallengeModel] ?? []
                        
                        
                        let imageLink = URL(string: imageUrl)
                        
                        let imageData = try? Data(contentsOf: imageLink!)
                        
                        let image = UIImage(data: imageData!) as UIImage?
                        
                        self.user = Account(id: "", firstName: firstName, secondName: secondName, email: "", password: "", profileImage: image ?? UIImage(), joinedDate: joinedDate, coins: 0, activeChallenges: [], completedChallenges: completedChallenges, badgeEarned: badgeEarned)
                        
                        
                    } else {
                        
                        print("Document does not exist")
                        
                    }
                } catch{
                    fatalError()
                }
            }
    }
    
    // Upload profile image
    func upload(profileImage: UIImage){
        guard let imageSelected = profileImage.jpegData(compressionQuality: 0.7) else {
            return
        }
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imageRef = storageRef.child("images/profile/" + currentUser!.uid)
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        imageRef.putData(imageSelected, metadata: metaData) { (metaData, error) in
            if error == nil {
                imageRef.downloadURL { (url, error) in
                    if let imageDownloadUrl = url?.absoluteString {
                        
                        self.db.collection("users").document(self.currentUser!.uid)
                            .getDocument { (snapshot, err) in
                                if let document = snapshot {
                                    document.reference.updateData(["imageUrl" : imageDownloadUrl])
                                }
                            }
                    }
                }
                
            }
        }
    }
    
    // Update user data from settings
    func updateUserData(fullname: [String], email: String ){
        
        if fullname.count > 1 {
            db.collection("users").document(currentUser!.uid).updateData([
                "firstName": fullname[0],
                "secondName": fullname[1],
                "email": email
            ])
            currentUser?.updateEmail(to: email){error in if let error = error{
                print(error)
            }}
            
        } else{
            db.collection("users").document(currentUser!.uid).updateData([
                "firstName": fullname[0],
                "secondName": " ",
                "email": email
            ])
            currentUser?.updateEmail(to: email){error in if let error = error{
                print(error)
            }}
        }
    }
}



