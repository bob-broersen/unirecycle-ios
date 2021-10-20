//
//  CommunityViewController.swift
//  unirecycle
//
//  Created by mark on 10/05/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage

class CommunityViewController: UIViewController {
    
    var currentUser: User?
    var imagePicker = UIImagePickerController()
    var userBuilder: UserProfileBuilder?
    var userData = Account()
    var userImage = UIImage()
    var userVM = ProfileViewModel()
    
    
    let initiativeLabel: UILabel = {
        let initiativeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 68, height: 24))
        initiativeLabel.text = "Initiatives we love"
        labelStyling(label: initiativeLabel)
        return initiativeLabel
    }()
    
    let internshipLabel: UILabel = {
        let internshipLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 68, height: 24))
        internshipLabel.text = "Find your next internship"
        labelStyling(label: internshipLabel)
        return internshipLabel
    }()
    
    private let initiativesStackView: UIStackView = {
        let initiativesStackView = UIStackView()
        initiativesStackView.distribution = .fillEqually
        initiativesStackView.axis = .horizontal
        initiativesStackView.spacing = 20
        initiativesStackView.translatesAutoresizingMaskIntoConstraints = false
        return initiativesStackView
    }()
    
    private let hvaResetUIView: UIView = {
        let hvaResetUIView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 140))
        return hvaResetUIView
    }()
    
    private let uvaGreenOfficeUIView: UIView = {
        let uvaGreenOfficeUIView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 140))
        return uvaGreenOfficeUIView
    }()
    
    private let enjoyTodayUIView: UIView = {
        let enjoyTodayUIView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 140))
        return enjoyTodayUIView
    }()
    
    private let hvaResetStackView: UIStackView = {
        let hvaResetStackView = UIStackView()
        return hvaResetStackView
    }()
    
    private let uvaGreenOfficeStackView: UIStackView = {
        let uvaGreenOfficeStackView = UIStackView()
        return uvaGreenOfficeStackView
    }()
    
    private let enjoyTodayStackView: UIStackView = {
        let enjoyTodayStackView = UIStackView()
        return enjoyTodayStackView
    }()
    
    private let sdgOnstageUIView: UIView = {
        let sdgOnstageUIView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 140))
        return sdgOnstageUIView
    }()
    
    private let sdgOnstageStackView: UIStackView = {
        let sdgOnstageStackView = UIStackView()
        sdgOnstageStackView.axis = .vertical
        sdgOnstageStackView.alignment = .center
        sdgOnstageStackView.distribution = .fillProportionally
        sdgOnstageStackView.spacing = 15
        sdgOnstageStackView.translatesAutoresizingMaskIntoConstraints = false
        return sdgOnstageStackView
    }()
    
    private let internshipStackView: UIStackView = {
        let internshipStackView = UIStackView()
        internshipStackView.distribution = .fillEqually
        internshipStackView.axis = .horizontal
        internshipStackView.spacing = 20
        internshipStackView.translatesAutoresizingMaskIntoConstraints = false
        return internshipStackView
    }()
    
    private let fillUIView: UIView = {
        let fillUIView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 140))
        fillUIView.backgroundColor = .white
        fillUIView.translatesAutoresizingMaskIntoConstraints = false
        return fillUIView
    }()
    
    private let fillUIViewTwo: UIView = {
        let fillUIViewTwo = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 140))
        fillUIViewTwo.backgroundColor = .white
        fillUIViewTwo.translatesAutoresizingMaskIntoConstraints = false
        return fillUIViewTwo
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Community"
        view.backgroundColor = Colors.white
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "profile_icon_top.png"),
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(rightHandAction))
        
        self.navigationItem.rightBarButtonItem?.tintColor = Colors.white;
        
        setupViews()
    }
    
   
    
    func setupViews(){
        uiviewStyling(uiView: hvaResetUIView)
        uiviewStyling(uiView: uvaGreenOfficeUIView)
        uiviewStyling(uiView: enjoyTodayUIView)
        uiviewStyling(uiView: sdgOnstageUIView)
        
        stackviewStyling(stackview: hvaResetStackView)
        stackviewStyling(stackview: uvaGreenOfficeStackView)
        stackviewStyling(stackview: enjoyTodayStackView)

        
        setupCommunityViews()
        setupInternView()
    }
    
    static func labelStyling(label: UILabel){
        label.textColor = Colors.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto", size: 20)
        label.textAlignment = .left
    }
    
    
    func uiviewStyling(uiView: UIView){
        uiView.layer.shadowColor = UIColor.black.cgColor
        uiView.layer.shadowOpacity = 0.2
        uiView.layer.shadowOffset = .zero
        uiView.layer.shadowRadius = 3
        uiView.backgroundColor = .white
        uiView.layer.borderWidth = 0
        uiView.layer.borderColor = UIColor.gray.cgColor
        uiView.backgroundColor = .white
        uiView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func stackviewStyling(stackview: UIStackView){
        stackview.axis = .vertical
        stackview.alignment = .center
        stackview.distribution = .fillProportionally
        stackview.spacing = 15
        stackview.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func applyTapGesture(uiView: UIView){
        uiView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(btnUrl(_sender:)))
        uiView.addGestureRecognizer(tap)
    }
    
    
    func setupCommunityViews(){
        // add 3 items to each vertical stack view
        
        // Saved stackview
        
        let ivSaved = UIImageView(image: #imageLiteral(resourceName: "hva_reset"))
        let ulSavedValue = UILabel()
        
        ulSavedValue.font = UIFont(name: "Roboto", size: 15)
        
        ulSavedValue.numberOfLines = 2
        ulSavedValue.text = "HvA \nRe-Set"
        
        
        hvaResetStackView.addArrangedSubview(ulSavedValue)
        hvaResetStackView.addArrangedSubview(ivSaved)
        
        
        // Done stackview
        
        let ivDone = UIImageView(image: #imageLiteral(resourceName: "green_office"))
        let ulDoneValue = UILabel()
        
        ulDoneValue.numberOfLines = 2
        ulDoneValue.text = "UvA Green \nOffice"
        
        ulDoneValue.font = UIFont(name: "Roboto", size: 15)
        
        uvaGreenOfficeStackView.addArrangedSubview(ulDoneValue)
        uvaGreenOfficeStackView.addArrangedSubview(ivDone)
        
        
        // Streak stackview
        
        let ivStreak = UIImageView(image: #imageLiteral(resourceName: "enjoy_today"))
        let ulStreakValue = UILabel()
        
        ulStreakValue.numberOfLines = 2
        ulStreakValue.text = "Enjoy \nToday"
        ulStreakValue.font = UIFont(name: "Roboto", size: 15)
        
        
        enjoyTodayStackView.addArrangedSubview(ulStreakValue)
        enjoyTodayStackView.addArrangedSubview(ivStreak)
        
        
        // add each vertical stack view as a subview of "UI" views
        hvaResetUIView.addSubview(hvaResetStackView)
        uvaGreenOfficeUIView.addSubview(uvaGreenOfficeStackView)
        enjoyTodayUIView.addSubview(enjoyTodayStackView)
        
        
        // constrain the stack views to the "UI" views
        //  with 15-pts "padding" on Top / Leading / Trailing
        NSLayoutConstraint.activate([
            
            hvaResetStackView.topAnchor.constraint(equalTo: hvaResetUIView.topAnchor, constant: 20.0),
            hvaResetStackView.leadingAnchor.constraint(equalTo: hvaResetUIView.leadingAnchor, constant: 10.0),
            hvaResetStackView.trailingAnchor.constraint(equalTo: hvaResetUIView.trailingAnchor, constant: -10.0),
            hvaResetStackView.bottomAnchor.constraint(equalTo: hvaResetUIView.bottomAnchor, constant: -20.0),
            
            uvaGreenOfficeStackView.topAnchor.constraint(equalTo: uvaGreenOfficeUIView.topAnchor, constant: 20.0),
            uvaGreenOfficeStackView.leadingAnchor.constraint(equalTo: uvaGreenOfficeUIView.leadingAnchor, constant: 10.0),
            uvaGreenOfficeStackView.trailingAnchor.constraint(equalTo: uvaGreenOfficeUIView.trailingAnchor, constant: -10.0),
            uvaGreenOfficeStackView.bottomAnchor.constraint(equalTo: uvaGreenOfficeUIView.bottomAnchor, constant: -20.0),
            
            enjoyTodayStackView.topAnchor.constraint(equalTo: enjoyTodayUIView.topAnchor, constant: 20.0),
            enjoyTodayStackView.leadingAnchor.constraint(equalTo: enjoyTodayUIView.leadingAnchor, constant: 10.0),
            enjoyTodayStackView.trailingAnchor.constraint(equalTo: enjoyTodayUIView.trailingAnchor, constant: -10.0),
            enjoyTodayStackView.bottomAnchor.constraint(equalTo: enjoyTodayUIView.bottomAnchor, constant: -20.0)
        ])
        
        applyTapGesture(uiView: hvaResetUIView)
        applyTapGesture(uiView: uvaGreenOfficeUIView)
        applyTapGesture(uiView: enjoyTodayUIView)
        
        
        // add the three "UI" views to the horizontal stack view
        initiativesStackView.addArrangedSubview(hvaResetUIView)
        initiativesStackView.addArrangedSubview(uvaGreenOfficeUIView)
        initiativesStackView.addArrangedSubview(enjoyTodayUIView)
        
        // add the "above label" to the view
        view.addSubview(initiativeLabel)
        
        // add horizontal stack view to the view
        view.addSubview(initiativesStackView)
        
        // let's respect the safe area
        let g = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            // label 40-pts from top
            initiativeLabel.topAnchor.constraint(equalTo:view.topAnchor, constant: 15.0),
            // label centered horizontally
            initiativeLabel.centerXAnchor.constraint(equalTo: g.centerXAnchor),
            
            // stack view 10-pts below label
            initiativesStackView.topAnchor.constraint(equalTo: initiativeLabel.bottomAnchor, constant: 10.0),
            
            // allow the arranged subviews to determine the width?
            // if yes, center the horizontal stack view
            initiativesStackView.centerXAnchor.constraint(equalTo: g.centerXAnchor),
            
            // let's make the "above label" the same width as the
            //  resulting width of the horizontal stack view
            initiativeLabel.widthAnchor.constraint(equalTo: initiativesStackView.widthAnchor)
            
            
        ])
    }
    
    func setupInternView(){
        
        // add 3 items to each vertical stack view
        
        // Saved stackview
        
        let ivSdg = UIImageView(image: #imageLiteral(resourceName: "sdg_onstage"))
        let ulSdg = UILabel()
        
        ulSdg.font = UIFont(name: "Roboto", size: 15)
        
        ulSdg.numberOfLines = 2
        ulSdg.text = "SDG \nOnStage"
        
        sdgOnstageStackView.addArrangedSubview(ulSdg)
        sdgOnstageStackView.addArrangedSubview(ivSdg)

        
        sdgOnstageUIView.addSubview(sdgOnstageStackView)
        
        
        NSLayoutConstraint.activate([
            
            sdgOnstageStackView.topAnchor.constraint(equalTo: sdgOnstageUIView.topAnchor, constant: 20.0),
            sdgOnstageStackView.leadingAnchor.constraint(equalTo: sdgOnstageUIView.leadingAnchor, constant: 20.0),
            sdgOnstageStackView.trailingAnchor.constraint(equalTo: sdgOnstageUIView.trailingAnchor, constant: -20.0),
            sdgOnstageStackView.bottomAnchor.constraint(equalTo: sdgOnstageUIView.bottomAnchor, constant: -20.0)
            
        ])
        
        sdgOnstageUIView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(btnUrl(_sender:)))
        sdgOnstageUIView.addGestureRecognizer(tap)
        
        
        // add the three "UI" views to the horizontal stack view
        internshipStackView.addArrangedSubview(sdgOnstageUIView)
        internshipStackView.addArrangedSubview(fillUIView)
        internshipStackView.addArrangedSubview(fillUIViewTwo)
        
        // add the "above label" to the view
        view.addSubview(internshipLabel)
        view.addSubview(internshipStackView)
        let g = view.safeAreaLayoutGuide
        
        
        // let's respect the safe area
        
        NSLayoutConstraint.activate([
            
            // label 40-pts from top
            internshipLabel.topAnchor.constraint(equalTo:initiativesStackView.bottomAnchor, constant: 15.0),
            // label centered horizontally
            internshipLabel.centerXAnchor.constraint(equalTo: g.centerXAnchor),
            
            // stack view 10-pts below label
            internshipStackView.topAnchor.constraint(equalTo: internshipLabel.bottomAnchor, constant: 10.0),
            
            // allow the arranged subviews to determine the width?
            // if yes, center the horizontal stack view
            internshipStackView.centerXAnchor.constraint(equalTo: g.centerXAnchor),
            
            // let's make the "above label" the same width as the
            //  resulting width of the horizontal stack view
            internshipLabel.widthAnchor.constraint(equalTo: internshipStackView.widthAnchor)
            
            
        ])
    }
    
    @objc
    func rightHandAction() {
        userViewModel?.fetchUser {
            let profileVC = ProfileViewController()
            self.userData = userViewModel!.user
            profileVC.userData = self.userData
            profileVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(profileVC, animated: true)
        }
    }
    
    @objc func btnUrl(_sender: UITapGestureRecognizer){
        
        if _sender.view == hvaResetUIView{
            UIApplication.shared.open(URL(string:"https://www.hvaduurzaam.nl/")! as URL, options: [:], completionHandler: nil )
        }
        else if _sender.view == uvaGreenOfficeUIView{
            UIApplication.shared.open(URL(string:"https://www.uvagreenoffice.nl/")! as URL, options: [:], completionHandler: nil )
        }
        else if _sender.view == enjoyTodayUIView{
            UIApplication.shared.open(URL(string:"https://enjoytoday.amsterdam/")! as URL, options: [:], completionHandler: nil )
        }
        else if _sender.view == sdgOnstageUIView{
            UIApplication.shared.open(URL(string:"https://www.sdgsonstage.nl/")! as URL, options: [:], completionHandler: nil )
        } else{
            print("No sender found")
        }
    }
}
