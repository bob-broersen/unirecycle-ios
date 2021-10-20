//
//  LoginViewController.swift
//  unirecycle
//
//  Created by Bob Broersen on 03/02/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class LoginViewController: UIViewController {
    let logo: UIImageView = {
        let logoImage = UIImage(named: images.logo)!
        let logo = UIImageView(image: logoImage)
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto", size: 12)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    let usernameField: InputTextField = {
        let userNameField = InputTextField(frame: CGRect(x: 0, y: 0, width: 273, height: 10))
        userNameField.attributedPlaceholder = NSAttributedString(string: Strings.Intro.emailPlaceholder
            ,
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        userNameField.translatesAutoresizingMaskIntoConstraints = false
        var emailIcon = UIImage(named: images.loginEmailIcon)!
        userNameField.addImage(image: emailIcon, imagePosition: .left)
        userNameField.paddingLeft()
        return userNameField
    }()
    
    let passwordField: InputTextField = {
        let passwordField = InputTextField(frame: CGRect(x: 0, y: 0, width: 273, height: 10))
        passwordField.attributedPlaceholder = NSAttributedString(string: Strings.Intro.passwordPlaceholder,
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.isSecureTextEntry = true
        var passwordIcon = UIImage(named: images.loginPasswordIcon)!
        passwordField.addImage(image: passwordIcon, imagePosition: .left)
        passwordField.paddingLeft()
        return passwordField
    }()
    
    private let signInButton: Button = {
        let button = Button()
        button.setTitle(Strings.Intro.logIn, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.purple
        self.dismissKeyboard()
        setupViews()
    }
    
    @objc func signIn(){
        startAnimation()

        hideErrorView()
        FirebasAuthHelper().login(email: usernameField.text!, password: passwordField.text!, completion: {error in
            if error == nil{
                userViewModel = UserViewModel()
                leaderboardViewModel = LeaderboardViewModel()
                userViewModel?.fetchUser {
                    let viewController = NavigationBarHome()
                    viewController.modalPresentationStyle = .fullScreen
                    self.present(viewController, animated: true, completion: nil)
                }
            } else {
                self.errorLabel.text = error
                self.showErrorView()
            }
        })
    }
    
    func setupViews(){
//        usernameField.text = "daronozdemir@hva.nl"
//        passwordField.text = "Admin123"
        usernameField.text = "x5@hva.nl"
        passwordField.text = "Test1234"
//        usernameField.text = "ryno.haakmat@hva.nl"
//        passwordField.text = "Admin123"

        setupLogo()
        setupUsernameField()
        setupPasswordField()
        setupSignInButton()
        setupErrorView()
    }
    
    func startAnimation() {
        let loading = NVActivityIndicatorView(frame: .zero, type: .ballPulse, color: .white, padding: 0)
        loading.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loading)
        view.bringSubviewToFront(loading)
        
        NSLayoutConstraint.activate([
            loading.widthAnchor.constraint(equalToConstant: 40),
            loading.heightAnchor.constraint(equalToConstant: 40),
            loading.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loading.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        loading.startAnimating()
    }
    
    func hideErrorView(){
        UIView.transition(with: errorLabel, duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.errorLabel.isHidden = true
                      })
    }
    
    func showErrorView(){
        UIView.transition(with: errorLabel, duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.errorLabel.isHidden = false
                      })
    }
    
    func setupErrorView(){
        errorLabel.isHidden = true
        
        view.addSubview(errorLabel)
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 8),
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.widthAnchor.constraint(equalTo: signInButton.widthAnchor),
        ])
    }
    
    func setupLogo(){
        view.addSubview(logo)
        NSLayoutConstraint.activate([
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.topAnchor.constraint(equalTo: view.topAnchor, constant: 107),
            logo.heightAnchor.constraint(equalToConstant: 152)
        ])
    }
    
    func setupUsernameField(){
        view.addSubview(usernameField)
        NSLayoutConstraint.activate([
            usernameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameField.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 68),
            usernameField.widthAnchor.constraint(equalToConstant: usernameField.frame.width)
        ])
    }
    
    func setupPasswordField(){
        view.addSubview(passwordField)
        NSLayoutConstraint.activate([
            passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 57),
            passwordField.widthAnchor.constraint(equalToConstant: passwordField.frame.width)
        ])
    }
    
    func setupSignInButton() {
        view.addSubview(signInButton)
        NSLayoutConstraint.activate([
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 62),
            signInButton.widthAnchor.constraint(equalToConstant: 303),
            signInButton.heightAnchor.constraint(equalToConstant: 49)
        ])
    }
}
