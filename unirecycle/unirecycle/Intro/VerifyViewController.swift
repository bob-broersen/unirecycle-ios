//
//  VerifyViewController.swift
//  unirecycle
//
//  Created by Bob Broersen on 15/02/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import UIKit

class VerifyViewController: UIViewController {
    
    let verificationIcon: UIImageView = {
        let image = UIImage(named: images.verifactionIcon)!
        let verificationIcon = UIImageView(image: image)
        verificationIcon.contentMode = .scaleAspectFit
        verificationIcon.translatesAutoresizingMaskIntoConstraints = false
        return verificationIcon
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 24)
        label.textColor = .black
        label.text = Strings.Intro.verifactionTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 16)
        label.textColor = .black
        label.text = Strings.Intro.verifactionSubTitle
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let openMailButton: Button = {
        let button = Button(frame: CGRect(x: 0, y: 0, width: 343, height: 58))
        button.setTitle(Strings.Intro.openMailTitle, for: .normal)
        button.addTarget(self, action: #selector(openMailApp), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func openMailApp(){
        let mailURL = URL(string: "message://")!
        if UIApplication.shared.canOpenURL(mailURL) {
            UIApplication.shared.open(mailURL, options: [:], completionHandler: nil)
         }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Verification"
        view.backgroundColor = .white
        setUpViews()
    }
    
    func setUpViews(){
        setUpVerifactionIcon()
        setUpTitle()
        setUpSubTitle()
        setUpMailButton()
    }
    
    func setUpVerifactionIcon(){
        view.addSubview(verificationIcon)
        NSLayoutConstraint.activate([
            verificationIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verificationIcon.topAnchor.constraint(equalTo: view.topAnchor, constant: 139)
        ])
    }
    
    func setUpTitle(){
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: verificationIcon.bottomAnchor, constant: 36),
            titleLabel.widthAnchor.constraint(equalToConstant: 173),
            titleLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func setUpSubTitle(){
        view.addSubview(subTitleLabel)
        NSLayoutConstraint.activate([
            subTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            subTitleLabel.widthAnchor.constraint(equalToConstant: 267),
            subTitleLabel.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    func setUpMailButton(){
        view.addSubview(openMailButton)
        NSLayoutConstraint.activate([
            openMailButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            openMailButton.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 139),
            openMailButton.widthAnchor.constraint(equalToConstant: openMailButton.frame.width),
            openMailButton.heightAnchor.constraint(equalToConstant: openMailButton.frame.height)
        ])
    }

}
