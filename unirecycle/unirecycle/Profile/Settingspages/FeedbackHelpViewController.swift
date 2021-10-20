//
//  FeedbackHelpViewController.swift
//  unirecycle
//
//  Created by mark on 16/05/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import Foundation
import UIKit

class FeedbackHelpViewController: UIViewController{
    
    let feedbackLabel: UILabel = {
        let titlePage = UILabel(frame: CGRect(x: 0, y: 0, width: 273, height: 10))
        titlePage.text = "What do you think of our app? Let us know at:"
        titlePage.font = UIFont(name: "Roboto-Bold", size: 16)
        return titlePage
    }()
    
    let feedbackText: UILabel = {
        let titlePage = UILabel(frame: CGRect(x: 0, y: 0, width: 273, height: 10))
        titlePage.text = "https://apps.apple.com/app/unirecycle/"
        titlePage.font = UIFont(name: "Roboto", size: 14)
        return titlePage
    }()
    
    let faqLabel: UILabel = {
        let titlePage = UILabel(frame: CGRect(x: 0, y: 0, width: 273, height: 10))
        titlePage.text = "Frequently asked questions"
        titlePage.font = UIFont(name: "Roboto-Bold", size: 16)
        return titlePage
    }()
    
    let changePwLabel: UILabel = {
        let titlePage = UILabel(frame: CGRect(x: 0, y: 0, width: 273, height: 10))
        titlePage.text = "Q: How can I change my password?"
        titlePage.font = UIFont(name: "Roboto", size: 14)
        return titlePage
    }()
    
    let changePwText: UILabel = {
        let titlePage = UILabel(frame: CGRect(x: 0, y: 0, width: 273, height: 40))
        titlePage.text = "1. Go to settings \n2. Under Profile and Security tap on Change password \n3. An email will be send to your inbox"
        titlePage.font = UIFont(name: "Roboto", size: 14)
        titlePage.numberOfLines = 3
        return titlePage
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feedback & help"
        view.backgroundColor = Colors.white
        
        setupViews()
    }
    
    func setupViews()  {
        applyProperties(label: feedbackLabel)
        applyProperties(label: feedbackText)
        applyProperties(label: faqLabel)
        applyProperties(label: changePwLabel)
        applyProperties(label: changePwText)

        setupFeedbackLabel()
        setupFeedbackText()
        setupFaqLabel()
        setupChangePwLabel()
        setupChangePwText()
    }
    
    func applyProperties(label: UILabel){
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.black
    }
    func setupFeedbackLabel(){
        view.addSubview(feedbackLabel)
        NSLayoutConstraint.activate([
            feedbackLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            feedbackLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
        ])
    }
    
    func setupFeedbackText(){
        view.addSubview(feedbackText)
        NSLayoutConstraint.activate([
            feedbackText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            feedbackText.topAnchor.constraint(equalTo: feedbackLabel.bottomAnchor, constant: 10),
        ])
    }
    
    func setupFaqLabel(){
        view.addSubview(faqLabel)
        NSLayoutConstraint.activate([
            faqLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            faqLabel.topAnchor.constraint(equalTo: feedbackText.bottomAnchor, constant: 20),
        ])
    }
    
    func setupChangePwLabel(){
        view.addSubview(changePwLabel)
        NSLayoutConstraint.activate([
            changePwLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            changePwLabel.topAnchor.constraint(equalTo: faqLabel.bottomAnchor, constant: 15),
        ])
    }
    
    func setupChangePwText(){
        view.addSubview(changePwText)
        NSLayoutConstraint.activate([
            changePwText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            changePwText.topAnchor.constraint(equalTo: changePwLabel.bottomAnchor, constant: 10),
        ])
    }
}
