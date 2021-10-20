//
//  FirebasAuthHelper.swift
//  unirecycle
//
//  Created by Bob Broersen on 09/02/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage

class FirebasAuthHelper {
    let db = Firestore.firestore()

    
    func login(email: String, password:String, completion: @escaping (String?) -> ()){
        Auth.auth().signIn(withEmail: email, password: password, completion: {authResult, error in
            if error == nil {
                completion(nil)
            } else {
                let error = error! as NSError
                completion(error.localizedDescription)
            }
        })
    }
    
    func register(user: User, completion: @escaping (Bool) -> ()){
        let editableUser = user
        Auth.auth().createUser(withEmail: user.email!, password: user.password!, completion: {authResult, error in
            if error == nil && authResult?.user.uid != nil{
                editableUser.id = (authResult?.user.uid)!
                
                
                self.uploadProfileImage(user: editableUser, completion: {downloadImageUrl in
                    print(downloadImageUrl)
                    self.addUser(user: editableUser, imageUrl: downloadImageUrl, finished: {
                       completion(true)
                    })
                })
            } else {
                print(error ?? "error")
                completion(false)
            }
        })
    }
        
    func uploadProfileImage(user: User, completion: @escaping (String) -> ()){
        guard let imageSelected = user.profileImage!.jpegData(compressionQuality: 0.7) else {
            completion("")
            return
        }
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imageRef = storageRef.child("images/profile/" + user.id!)
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"

        imageRef.putData(imageSelected, metadata: metaData) { (metaData, error) in
            if error == nil {
                imageRef.downloadURL { (url, error) in
                    if let imageDownloadUrl = url?.absoluteString {
                        completion(imageDownloadUrl)
                    }
                }
            }
        }
    }
    
    func addUser(user: User, imageUrl: String, finished: @escaping () -> ()){
       
        guard let date = Auth.auth().currentUser?.metadata.creationDate else { return }
        let df = DateFormatter()
        df.dateFormat = "MMMM yyyy"
        
        self.db.collection("users").document(user.id!).setData([
            "firstName": user.firstName!,
            "secondName": user.secondName!,
            "email": user.email!,
            "imageUrl": imageUrl,
            "activeChallenges": [],
            "completedChallenges": [],
            "badgeEarned": [],

            "joinedDate": df.string(from: date)
        ]) { err in
            if err != nil {
                finished()
            } else {
                finished()
            }
        }
    }
    
    func checkEmail(email: String) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
//    func resetEmail(){
//        let emailAddress = Auth.auth().currentUser?.email ?? "Email Address"
//        Auth.auth().sendPasswordReset(withEmail: emailAddress ) { error in
//          // ...
//        }
//    }
    
    // Method for sending mail to reset password
    func sendPasswordReset(withEmail email: String, _ callback: ((Error?) -> ())? = nil){
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            callback?(error)
        }
    }
}
