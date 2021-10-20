//
//  BadgeViewController.swift
//  unirecycle
//
//  Created by mark on 15/03/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage

class BadgeViewController: UIViewController {
    
    struct Cells{
        static let badgeCell = "BadgeCell"
    }
    
    var userData = Account()
    var badgeData = [Badge]()
    var badgeVM = BadgeViewModel()
    
    var userImage = UIImage()
    var tableView = UITableView()
    
    
    let profilePicture: UIButton =  {
        let image = UIImage(named: images.profileImagePlaceholder)
        let profilePicture = UIButton(frame: CGRect(x: 0, y: 0, width: 115, height: 115))
        profilePicture.adjustsImageWhenHighlighted = false
        profilePicture.setImage(image, for: .normal)
        profilePicture.layer.cornerRadius = profilePicture.frame.height/2
        profilePicture.clipsToBounds = true
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        return profilePicture
    }()
    
    let fullNameLabel: UILabel = {
        let fullNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 273, height: 10))
        fullNameLabel.text = "John Doe"
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        fullNameLabel.textColor = Colors.black
        fullNameLabel.font = UIFont(name: "Roboto", size: 24)
        fullNameLabel.textAlignment = .center
        return fullNameLabel
    }()
    
    let dateJoined: UILabel = {
        let dateJoined = UILabel(frame: CGRect(x: 0, y: 0, width: 273, height: 10))
        dateJoined.text = "Joined"
        dateJoined.textColor = Colors.black
        dateJoined.translatesAutoresizingMaskIntoConstraints = false
        dateJoined.font = UIFont(name: "Roboto", size: 12)
        dateJoined.textAlignment = .center
        return dateJoined
    }()
    
    let badgeLabel: UILabel = {
        let badgeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 68, height: 24))
        badgeLabel.text = "Badges"
        badgeLabel.textColor = Colors.black
        badgeLabel.translatesAutoresizingMaskIntoConstraints = false
        badgeLabel.font = UIFont(name: "Roboto-Bold", size: 20)
        badgeLabel.textAlignment = .left
        return badgeLabel
    }()
    
    let badgeShowLabel: UILabel = {
        let badgeShowLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 273, height: 10))
        badgeShowLabel.text = "No badges to show yet."
        badgeShowLabel.translatesAutoresizingMaskIntoConstraints = false
        badgeShowLabel.textColor = Colors.black
        badgeShowLabel.font = UIFont(name: "Roboto-Bold", size: 24)
        badgeShowLabel.textAlignment = .center
        badgeShowLabel.numberOfLines = 10
        return badgeShowLabel
    }()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        userViewModel?.fetchUser {
            self.userData = userViewModel!.user
            
            self.userImage = self.userData.profileImage!
            
            self.profilePicture.setImage(self.userImage, for: .normal)
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Badges"
        view.backgroundColor = Colors.white
        
        loadUserData()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupViews()
    }
    
    
    func setupViews(){
        setupProfilePicture()
        setupFullNameLabel()
        setupDateJoined()
        setupBadgeLabel()
        configureTableView()
        
        if badgeData.count == 0{
            setupBadgeShowLabel()
        }
        
    }
    
    // Loading user data from firestore
    func loadUserData(){
        
        let fullName = userData.firstName! + " " + userData.secondName!
        
        //        userImage = userData.profileImage!
        //
        //        profilePicture.setImage(userImage, for: .normal)
        
        fullNameLabel.text = fullName
        
        dateJoined.text = "🗓 Joined " + userData.joinedDate!
        
    }
    
    
    func setupProfilePicture(){
        view.addSubview(profilePicture)
        NSLayoutConstraint.activate([
            profilePicture.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profilePicture.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            profilePicture.widthAnchor.constraint(equalToConstant: profilePicture.frame.width),
            profilePicture.heightAnchor.constraint(equalToConstant: profilePicture.frame.height),
        ])
    }
    
    func setupFullNameLabel(){
        view.addSubview(fullNameLabel)
        NSLayoutConstraint.activate([
            fullNameLabel.topAnchor.constraint(equalTo: profilePicture.bottomAnchor, constant: 10),
            fullNameLabel.widthAnchor.constraint(equalToConstant: fullNameLabel.frame.width)
        ])
        fullNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    func setupDateJoined(){
        view.addSubview(dateJoined)
        NSLayoutConstraint.activate([
            dateJoined.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateJoined.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 0),
            dateJoined.widthAnchor.constraint(equalToConstant: dateJoined.frame.width)
        ])
        dateJoined.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupBadgeLabel(){
        view.addSubview(badgeLabel)
        NSLayoutConstraint.activate([
            badgeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            badgeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            badgeLabel.topAnchor.constraint(equalTo: dateJoined.bottomAnchor, constant: 10),
            badgeLabel.widthAnchor.constraint(equalToConstant: badgeLabel.frame.width)
        ])
        dateJoined.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    
    func setupBadgeShowLabel(){
        view.addSubview(badgeShowLabel)
        NSLayoutConstraint.activate([
            badgeShowLabel.topAnchor.constraint(equalTo: badgeLabel.bottomAnchor, constant: 25),
            badgeShowLabel.widthAnchor.constraint(equalToConstant: badgeShowLabel.frame.width)
        ])
        badgeShowLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    
    
    func configureTableView(){
        view.addSubview(tableView)
        //        setTableViewDelegates()
        tableView.separatorStyle = .none
        //        tableView.backgroundColor = .green
        tableView.register(BadgeTableViewCell.self, forCellReuseIdentifier: Cells.badgeCell)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: badgeLabel.bottomAnchor, constant: 15),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.widthAnchor.constraint(equalToConstant: view.frame.width),
            //        tableView.pinToTop(to: view, currentView: tableView, top: seperator)
        ])
    }
}

extension BadgeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return badgeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.badgeCell) as! BadgeTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.setBadge(badge: badgeData[indexPath.row])
        return cell
    }
    
}

