//
//  ProfileViewController.swift
//  unirecycle
//
//  Created by mark on 10/02/2021.
//  Copyright © 2021 HvA. All rights reserved.
//


import Foundation
import UIKit
import Firebase
import FirebaseStorage

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var imagePicker = UIImagePickerController()
    var userData = Account()
    var badgeData = [Badge]()
    var userImage = UIImage()
    var userVM = ProfileViewModel()
    var badgeVM = BadgeViewModel()
    

    let profilePicture: UIButton = {
        let image = UIImage(named: images.profileImagePlaceholder)
        let profilePicture = UIButton(frame: CGRect(x: 0, y: 0, width: 115, height: 115))
        profilePicture.addTarget(self, action: #selector(pickProfileImage), for: .touchUpInside)
        profilePicture.layer.cornerRadius = profilePicture.frame.height/2
        profilePicture.clipsToBounds = true
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        return profilePicture
    }()
    
    var fullNameLabel: UILabel = {
        let fullNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 273, height: 10))
        fullNameLabel.text = ""
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        fullNameLabel.textColor = Colors.black
        fullNameLabel.font = UIFont(name: "Roboto", size: 24)
        fullNameLabel.textAlignment = .center
        return fullNameLabel
    }()
    
    let dateJoined: UILabel = {
        let dateJoined = UILabel(frame: CGRect(x: 0, y: 0, width: 273, height: 10))
        dateJoined.text = "🗓 Joined"
        dateJoined.textColor = Colors.black
        dateJoined.translatesAutoresizingMaskIntoConstraints = false
        dateJoined.font = UIFont(name: "Roboto", size: 12)
        dateJoined.textAlignment = .center
        return dateJoined
    }()
    
    private let userStatisticsStackview: UIStackView = {
        let userStatistics = UIStackView()
        userStatistics.distribution = .fillEqually
        userStatistics.axis = .horizontal
        userStatistics.spacing = 35
        userStatistics.translatesAutoresizingMaskIntoConstraints = false
        return userStatistics
    }()
    
    private let userSavedUIView: UIView = {
        let userSavedUIView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        userSavedUIView.backgroundColor = .white
        userSavedUIView.translatesAutoresizingMaskIntoConstraints = false
        return userSavedUIView
    }()
    
    private let userDoneUIView: UIView = {
        let userDoneUIView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        userDoneUIView.backgroundColor = .white
        userDoneUIView.translatesAutoresizingMaskIntoConstraints = false
        return userDoneUIView
    }()
    
    private let userStreakUIView: UIView = {
        let userStreakUIView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        userStreakUIView.backgroundColor = .white
        userStreakUIView.translatesAutoresizingMaskIntoConstraints = false
        return userStreakUIView
    }()
    
    private let userSavedStackView: UIStackView = {
        let userSavedStackView = UIStackView()
        return userSavedStackView
    }()
    
    private let userDoneStackView: UIStackView = {
        let userDoneStackView = UIStackView()
        return userDoneStackView
    }()
    
    private let userStreakStackView: UIStackView = {
        let userStatistics = UIStackView()
        return userStatistics
    }()
    
    
    private let badgeText: UIStackView = {
        let badgeText = UIStackView()
        badgeText.translatesAutoresizingMaskIntoConstraints = false
        badgeText.distribution = .fillEqually
        badgeText.spacing = 210
        badgeText.clipsToBounds = true
        return badgeText
    }()
    
    private let badgeUIView: UIView = {
        let badgeUIView = UIView(frame: CGRect(x: 50, y: 50, width: 343, height: 77))
        return badgeUIView
    }()
    
    private let badgeStackView: UIStackView = {
        let badge = UIStackView()
        badge.translatesAutoresizingMaskIntoConstraints = false
        badge.distribution = .fillEqually
        badge.alignment = .center
        badge.spacing = 20
        return badge
    }()
    
    private let inviteUIView: UIView = {
        let inviteUIView = UIView(frame: CGRect(x: 50, y: 50, width: 343, height: 77))
        return inviteUIView
    }()
    
    
    private let inviteStackView: UIStackView = {
        let isv = UIStackView()
        isv.distribution = .fillProportionally
        isv.alignment = .center
        isv.spacing = 20
        isv.translatesAutoresizingMaskIntoConstraints = false
        return isv
    }()
    
    let inviteLabel: UILabel = {
        let inviteLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 203, height: 48))
        inviteLabel.text = "Everything is better with friends! Invite them."
        inviteLabel.numberOfLines = 0
        inviteLabel.translatesAutoresizingMaskIntoConstraints = false
        inviteLabel.textColor = Colors.black
        inviteLabel.font = UIFont(name: "Roboto", size: 16)
        return inviteLabel
    }()
    
    let inviteBtn: UIButton = {
        let inviteBtn = UIButton()
        inviteBtn.backgroundColor = Colors.blue
        inviteBtn.layer.cornerRadius = 4
        inviteBtn.setTitle("INVITE", for: .normal)
        inviteBtn.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 14)
        inviteBtn.setTitleColor(.black, for: .normal)
        inviteBtn.translatesAutoresizingMaskIntoConstraints = false
//        inviteBtn.addTarget(self, action: #selector(), for: .touchUpInside)
        return inviteBtn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        
        title = "Profile"
        view.backgroundColor = Colors.white
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSString(string: "\u{2699}\u{0000FE0E}") as String,
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(rightHandAction))
        
        self.navigationItem.rightBarButtonItem?.tintColor = Colors.white;
        
    
        
        
        setupViews()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        userViewModel?.fetchUser {
            self.userData = userViewModel!.user
            
            let fullName = self.userData.firstName! + " " + self.userData.secondName!
            self.fullNameLabel.text = fullName

        }
        
        userImage = userData.profileImage!

        profilePicture.setImage(userImage, for: .normal)
        


        dateJoined.text = "🗓 Joined " + userData.joinedDate!

    }
    
    func innerStackView(stackview: UIStackView){
        stackview.axis = .vertical
        stackview.alignment = .center
        stackview.distribution = .fillProportionally
        stackview.spacing = 12
        stackview.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func applyShadow(uiview: UIView){
        uiview.layer.shadowColor = UIColor.black.cgColor
        uiview.layer.shadowOpacity = 0.2
        uiview.layer.shadowOffset = .zero
        uiview.layer.shadowRadius = 3
        uiview.backgroundColor = .white
        uiview.translatesAutoresizingMaskIntoConstraints = false
        uiview.layer.borderWidth = 0
        uiview.layer.borderColor = UIColor.gray.cgColor
    }

    
    
    func setupViews(){
        innerStackView(stackview: userSavedStackView)
        innerStackView(stackview: userDoneStackView)
        innerStackView(stackview: userStreakStackView)
        
        applyShadow(uiview: badgeUIView)
        applyShadow(uiview: inviteUIView)

        setupProfilePicture()
        setupFullNameLabel()
        setupUserStats()
        setupBadgeText()
        setupBadgeView()
        setupBadges()
        setupInviteView()
        setupInviteBtn()
        setupInviteStackView()
    }
    
    
    func setupUserStats(){
        // add 3 items to each vertical stack view
        
        // Saved stackview
        
        let ivSaved = UIImageView(image: #imageLiteral(resourceName: "Ellipse euro"))
        let ulSavedValue = UILabel()
        let ulSavedLabel = UILabel()
        
        ulSavedValue.font = UIFont(name: "Roboto", size: 20)
        ulSavedLabel.font = UIFont(name: "Roboto", size: 12)
        ulSavedLabel.textColor = .gray
        
        ulSavedValue.text = "20€"
        ulSavedLabel.text = "Saved"
        
        userSavedStackView.addArrangedSubview(ivSaved)
        userSavedStackView.addArrangedSubview(ulSavedValue)
        userSavedStackView.addArrangedSubview(ulSavedLabel)
        
        
        // Done stackview
        
        let ivDone = UIImageView(image: #imageLiteral(resourceName: "Ellipse trophy"))
        let ulDoneValue = UILabel()
        let ulDoneLabel = UILabel()
        
        ulDoneValue.text = String(userViewModel!.user.completedChallenges?.count ?? 0)
        ulDoneLabel.text = "Challenges Done"
        
        ulDoneValue.font = UIFont(name: "Roboto", size: 20)
        ulDoneLabel.font = UIFont(name: "Roboto", size: 12)
        ulDoneLabel.textColor = .gray
        
        userDoneStackView.addArrangedSubview(ivDone)
        userDoneStackView.addArrangedSubview(ulDoneValue)
        userDoneStackView.addArrangedSubview(ulDoneLabel)
        
        
        // Streak stackview
        
        let ivStreak = UIImageView(image: #imageLiteral(resourceName: "Ellipse streak"))
        let ulStreakValue = UILabel()
        let ulStreakLabel = UILabel()
        
        ulStreakValue.font = UIFont(name: "Roboto", size: 20)
        ulStreakLabel.font = UIFont(name: "Roboto", size: 12)
        ulStreakLabel.textColor = .gray
        
        
        ulStreakValue.text = "3"
        ulStreakLabel.text = "Week Streak"
        
        userStreakStackView.addArrangedSubview(ivStreak)
        userStreakStackView.addArrangedSubview(ulStreakValue)
        userStreakStackView.addArrangedSubview(ulStreakLabel)
        
        
        // add each vertical stack view as a subview of "UI" views
        userSavedUIView.addSubview(userSavedStackView)
        userDoneUIView.addSubview(userDoneStackView)
        userStreakUIView.addSubview(userStreakStackView)
        
        
        // constrain the stack views to the "UI" views
        //  with 15-pts "padding" on Top / Leading / Trailing
        NSLayoutConstraint.activate([
            
            userSavedStackView.topAnchor.constraint(equalTo: userSavedUIView.topAnchor, constant: 0.0),
            userSavedStackView.leadingAnchor.constraint(equalTo: userSavedUIView.leadingAnchor, constant: 5.0),
            userSavedStackView.trailingAnchor.constraint(equalTo: userSavedUIView.trailingAnchor, constant: -5.0),
            userSavedStackView.bottomAnchor.constraint(equalTo: userSavedUIView.bottomAnchor, constant: 2.0),
            
            userDoneStackView.topAnchor.constraint(equalTo: userDoneUIView.topAnchor, constant: 0.0),
            userDoneStackView.leadingAnchor.constraint(equalTo: userDoneUIView.leadingAnchor, constant: 5.0),
            userDoneStackView.trailingAnchor.constraint(equalTo: userDoneUIView.trailingAnchor, constant: 0.0),
            userDoneStackView.bottomAnchor.constraint(equalTo: userDoneUIView.bottomAnchor, constant: 2.0),
            
            userStreakStackView.topAnchor.constraint(equalTo: userStreakUIView.topAnchor, constant: 0.0),
            userStreakStackView.leadingAnchor.constraint(equalTo: userStreakUIView.leadingAnchor, constant: 5.0),
            userStreakStackView.trailingAnchor.constraint(equalTo: userStreakUIView.trailingAnchor, constant: -5.0),
            userStreakStackView.bottomAnchor.constraint(equalTo: userStreakUIView.bottomAnchor, constant: 2.0)
        ])
        
        // add the three "UI" views to the horizontal stack view
        userStatisticsStackview.addArrangedSubview(userSavedUIView)
        userStatisticsStackview.addArrangedSubview(userDoneUIView)
        userStatisticsStackview.addArrangedSubview(userStreakUIView)
        
        // add the "above label" to the view
        view.addSubview(dateJoined)
        
        // add horizontal stack view to the view
        view.addSubview(userStatisticsStackview)
        
        // let's respect the safe area
        let g = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            // label 40-pts from top
            dateJoined.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 8.0),
            // label centered horizontally
            dateJoined.centerXAnchor.constraint(equalTo: g.centerXAnchor),
            
            // stack view 10-pts below label
            userStatisticsStackview.topAnchor.constraint(equalTo: dateJoined.bottomAnchor, constant: 15.0),
            
            // allow the arranged subviews to determine the width?
            // if yes, center the horizontal stack view
            userStatisticsStackview.centerXAnchor.constraint(equalTo: g.centerXAnchor),
            
            // let's make the "above label" the same width as the
            //  resulting width of the horizontal stack view
            dateJoined.widthAnchor.constraint(equalTo: userStatisticsStackview.widthAnchor),
            
     ])
        
    }
    
    @objc func pickProfileImage(){
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        profilePicture.setImage(image, for: .normal)
        dismiss(animated: true)
        uploadImage(imageOk: image)
        
        userViewModel?.fetchUser {
            self.userData = userViewModel!.user
        }
        
    }
    

    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
     func uploadImage(imageOk : UIImage){
        userData = userVM.user
        let imageRecieved = imageOk
      
        userVM.upload(profileImage: imageOk)
        
    
        }
    
    @objc
    func rightHandAction() {
        userViewModel?.fetchUser {
            self.userData = userViewModel!.user
            let settingsVC = SettingsViewController()
            settingsVC.userData = self.userData
            self.navigationController?.pushViewController(settingsVC, animated: true)
        }
    }
    
    @objc
    func badgeClicked() {
        let badgeVC = BadgeViewController()
               
        userViewModel?.fetchUser {
            self.userData = userViewModel!.user
        }
        
        self.badgeData = badgeVM.badge
        
        // if there badges available, set data
        if self.badgeData.count > 0{
            badgeVC.badgeData = self.badgeData
        }
        
        
        badgeVC.userData = self.userData
        navigationController?.pushViewController(badgeVC, animated: true)
    }
    
    func setupProfilePicture(){
        view.addSubview(profilePicture)
        NSLayoutConstraint.activate([
            profilePicture.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profilePicture.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            profilePicture.widthAnchor.constraint(equalToConstant: profilePicture.frame.width),
            profilePicture.heightAnchor.constraint(equalToConstant: profilePicture.frame.height),
        ])
    }
    
    func setupFullNameLabel(){
        view.addSubview(fullNameLabel)
        NSLayoutConstraint.activate([
            fullNameLabel.topAnchor.constraint(equalTo: profilePicture.bottomAnchor, constant: 15),
            fullNameLabel.widthAnchor.constraint(equalToConstant: fullNameLabel.frame.width)
        ])
        fullNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    
    func setupBadgeText(){
        view.addSubview(badgeText)
        NSLayoutConstraint.activate([
            badgeText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            badgeText.topAnchor.constraint(equalTo: userStatisticsStackview.bottomAnchor, constant: 15),
            
        ])
        
        let ulBadge = UILabel()
        let ulSeeAll = UILabel()
        
        
        ulBadge.font = UIFont(name: "Roboto", size: 20)
        ulSeeAll.font = UIFont(name: "Roboto", size: 14)
        ulSeeAll.textColor = Colors.purple
        
        
        
        ulBadge.text = "Badges"
        ulSeeAll.text = "See all >"
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(badgeClicked))
        ulSeeAll.isUserInteractionEnabled = true
        ulSeeAll.addGestureRecognizer(tap)
        
        badgeText.addArrangedSubview(ulBadge)
        badgeText.addArrangedSubview(ulSeeAll)
        
        ulBadge.contentMode = .scaleAspectFill
        ulSeeAll.contentMode = .scaleAspectFill
        
        ulBadge.clipsToBounds = true
        ulSeeAll.clipsToBounds = true
    }
    
    
    func setupBadgeView(){
        view.addSubview(badgeUIView)
        badgeUIView.addSubview(badgeStackView)
        NSLayoutConstraint.activate([
            badgeUIView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            badgeUIView.topAnchor.constraint(equalTo: badgeText.bottomAnchor, constant: 10),
            badgeUIView.heightAnchor.constraint(equalToConstant: 80),
            badgeUIView.widthAnchor.constraint(equalToConstant: 343),
        ])
    }
    
    func setupBadges(){
        view.addSubview(badgeStackView)
        NSLayoutConstraint.activate([
            badgeStackView.leadingAnchor.constraint(equalTo: badgeUIView.leadingAnchor, constant: 15),
            badgeStackView.trailingAnchor.constraint(equalTo: badgeUIView.trailingAnchor, constant: -15),
            badgeStackView.topAnchor.constraint(equalTo: badgeUIView.topAnchor),
            badgeStackView.bottomAnchor.constraint(equalTo: badgeUIView.bottomAnchor),
        ])
        
        
        let ivCart = UIImageView(image: #imageLiteral(resourceName: "Ellipse cart"))
        let ivBox = UIImageView(image: #imageLiteral(resourceName: "Ellipse box"))
        let ivCutlery = UIImageView(image: #imageLiteral(resourceName: "Ellipse cutlery"))
        let ivHill = UIImageView(image: #imageLiteral(resourceName: "Ellipse hill"))
        let ivCutleryCrossed = UIImageView(image: #imageLiteral(resourceName: "Ellipse cutlery cross"))
        
        
        badgeStackView.addArrangedSubview(ivCart)
        badgeStackView.addArrangedSubview(ivBox)
        badgeStackView.addArrangedSubview(ivCutlery)
        badgeStackView.addArrangedSubview(ivHill)
        badgeStackView.addArrangedSubview(ivCutleryCrossed)
        
        
    }
    
    func setupInviteView(){
        view.addSubview(inviteUIView)
        inviteUIView.addSubview(inviteStackView)
        NSLayoutConstraint.activate([
            inviteUIView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inviteUIView.topAnchor.constraint(equalTo: badgeUIView.bottomAnchor, constant: 20),
            inviteUIView.heightAnchor.constraint(equalToConstant: 80),
            inviteUIView.widthAnchor.constraint(equalToConstant: 343),
        ])
    }
    
    func setupInviteBtn(){
        view.addSubview(inviteBtn)
        NSLayoutConstraint.activate([
            inviteBtn.widthAnchor.constraint(equalToConstant: 100),
            inviteBtn.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
    func setupInviteStackView(){
        view.addSubview(inviteStackView)
        //        inviteStackView.addSubview(inviteLabel)
        //        inviteStackView.addSubview(inviteBtn)
        
        NSLayoutConstraint.activate([
            inviteStackView.leadingAnchor.constraint(equalTo: inviteUIView.leadingAnchor, constant: 15),
            inviteStackView.trailingAnchor.constraint(equalTo: inviteUIView.trailingAnchor, constant: -15),
            inviteStackView.topAnchor.constraint(equalTo: inviteUIView.topAnchor),
            inviteStackView.bottomAnchor.constraint(equalTo: inviteUIView.bottomAnchor),
        ])
        
        inviteStackView.addArrangedSubview(inviteLabel)
        inviteStackView.addArrangedSubview(inviteBtn)
    }
    
}


