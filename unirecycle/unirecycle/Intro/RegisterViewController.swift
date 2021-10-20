//
//  RegisterViewController.swift
//  unirecycle
//
//  Created by Bob Broersen on 03/02/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController {
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.additionalSafeAreaInsets = UIEdgeInsets(top: 400, left: 0, bottom: 0, right: 0);
//        navigationController?.viewSafeAreaInsetsDidChange()
//    }
    
    let emailField: InputTextField = {
        let emailField = InputTextField(frame: CGRect(x: 0, y: 0, width: 311, height: 10))
        emailField.attributedPlaceholder = NSAttributedString(string: Strings.Intro.emailPlaceholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        emailField.textColor = .black
        emailField.overrideLineColor(color: Colors.gray.cgColor)
        emailField.paddingRight()
        emailField.autocapitalizationType = .none
        emailField.addTarget(self, action: #selector(fieldChanged), for: .editingChanged)
        emailField.translatesAutoresizingMaskIntoConstraints = false
        return emailField
    }()
    
    let passwordField: InputTextField = {
        let passwordField = InputTextField(frame: CGRect(x: 0, y: 0, width: 311, height: 10))
        passwordField.attributedPlaceholder = NSAttributedString(string: Strings.Intro.passwordPlaceholder, attributes: [NSAttributedString.Key.foregroundColor:  UIColor.black])
        passwordField.textColor = .black
        passwordField.overrideLineColor(color: Colors.gray.cgColor)
        passwordField.isSecureTextEntry = true
        var passwordIcon = UIImage(named: images.passwordShowIcon)!
        let imageView = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.setImage(passwordIcon, for: .normal)
        imageView.addTarget(self, action: #selector(changeSecureEntry), for: .touchUpInside)
        passwordField.rightViewMode = .always
        passwordField.rightView = imageView
        passwordField.paddingRight()
        passwordField.addTarget(self, action: #selector(fieldChanged), for: .editingChanged)
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        return passwordField
    }()
    
    let passwordRequirmentItem: UIView = {
        let passwordRequirmentItem = UIView()
        var label = UILabel()
        passwordRequirmentItem.addSubview(label)
        return passwordRequirmentItem
    }()
    
    let stackView : UIStackView = {
        let stackview = UIStackView(frame: CGRect(x: 0, y: 0, width: 311, height: 170))
        stackview.axis = .vertical
        stackview.distribution = .fillEqually
        stackview.alignment = .leading
        for requirment in Strings.Intro.passwordRequirments{
            var requirmentItem = PasswordRequirmentItem()
            requirmentItem.label.text = requirment.text
            requirmentItem.widthAnchor.constraint(equalToConstant: stackview.frame.width - 39).isActive = true
            stackview.addArrangedSubview(requirmentItem)
        }
        for requirment in Strings.Intro.emailRequirments{
            var requirmentItem = PasswordRequirmentItem()
            requirmentItem.label.text = requirment.text
            requirmentItem.widthAnchor.constraint(equalToConstant: stackview.frame.width - 39).isActive = true
            stackview.addArrangedSubview(requirmentItem)
        }
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    @objc func changeSecureEntry(){
        passwordField.isSecureTextEntry = !passwordField.isSecureTextEntry
    }
    
    let passwordRequirmentsView: UIView = {
        let passwordRequirmentsView = UIView(frame: CGRect(x: 0, y: 0, width: 311, height: 170))
        passwordRequirmentsView.backgroundColor = Colors.purple
        passwordRequirmentsView.layer.cornerRadius = 10
        passwordRequirmentsView.translatesAutoresizingMaskIntoConstraints = false
        return passwordRequirmentsView
    }()

    private let signUpButton: Button = {
        let button = Button(frame: CGRect(x: 0, y: 0, width: 343, height: 48))
        button.setTitle(Strings.Intro.signUp, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(signUpClicked), for: .touchUpInside)
        return button
    }()
    
    @objc func signUpClicked(){
        if checkRequirments(){
            let viewController = RegisterDetailsViewController()
            let userBuilder = UserProfileBuilder()
            userBuilder.addEmail(email: emailField.text!).addPassword(password: passwordField.text!)
            viewController.userBuilder = userBuilder
            navigationController?.pushViewController(viewController, animated: true)
        } else {
            return
        }
    }
    
    func checkRequirments() -> Bool {
        for requirment in Strings.Intro.emailRequirments{
            if !checkRegex(regex: requirment.regex, text: emailField.text ?? ""){
                return false
            }
        }
        for requirment in Strings.Intro.passwordRequirments{
            if !checkRegex(regex: requirment.regex, text: passwordField.text ?? ""){
                return false
            }
        }
        return true
    }
    
    @objc func fieldChanged(){
        for i in 0..<stackView.arrangedSubviews.count{
            let requirmentItem = stackView.arrangedSubviews[i] as! PasswordRequirmentItem
            let passwordRequirments = Strings.Intro.passwordRequirments
            let emailRequirments = Strings.Intro.emailRequirments

            
            let regexText = requirmentItem.label.text
            var regex = ""
            var text = ""
            if let emailRequirment = emailRequirments.first(where: {$0.text == regexText}) {
                regex = emailRequirment.regex
                text = emailField.text ?? ""
            } else if let passwordRequirment = passwordRequirments.first(where: {$0.text == regexText}) {
                regex = passwordRequirment.regex
                text = passwordField.text ?? ""
            }

            if checkRegex(regex: regex, text: text ) {
                requirmentItem.imageView.image = UIImage(named: images.passwordOkIcon)
            } else {
                requirmentItem.imageView.image = UIImage(named: images.passwordFalseIcon)
            }
        }
    }
    
    func checkRegex(regex: String, text: String) -> Bool{
        let check = NSPredicate(format: "SELF MATCHES %@", regex)
        return check.evaluate(with: text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.dismissKeyboard()

        title = Strings.Intro.registerViewControllerTitle
        setUpViews()
    }
    
    func setUpViews(){
        setUpEmailField()
        setUpPasswordField()
        setUpPasswordRequirmentsView()
        setUpSignUpButton()
        setUpStackView()
    }
    
    func setUpEmailField(){
        view.addSubview(emailField)
        NSLayoutConstraint.activate([
            emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 84),
            emailField.widthAnchor.constraint(equalToConstant: emailField.frame.width)
        ])
    }
        
    func setUpPasswordField(){
        view.addSubview(passwordField)
        NSLayoutConstraint.activate([
            passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 84),
            passwordField.widthAnchor.constraint(equalToConstant: passwordField.frame.width)
        ])
    }
    
    func setUpPasswordRequirmentsView(){
        view.addSubview(passwordRequirmentsView)
        NSLayoutConstraint.activate([
            passwordRequirmentsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordRequirmentsView.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 27),
            passwordRequirmentsView.widthAnchor.constraint(equalToConstant: passwordRequirmentsView.frame.width),
            passwordRequirmentsView.heightAnchor.constraint(equalToConstant: passwordRequirmentsView.frame.height)
        ])
    }
    
    func setUpStackView(){
        fieldChanged()
        passwordRequirmentsView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: passwordRequirmentsView.leadingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: passwordRequirmentsView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: passwordRequirmentsView.bottomAnchor),
            stackView.widthAnchor.constraint(equalToConstant: passwordRequirmentsView.frame.width),
        ])
    }
    
    func setUpSignUpButton() {
        view.addSubview(signUpButton)
        NSLayoutConstraint.activate([
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: passwordRequirmentsView.bottomAnchor, constant: 85),
            signUpButton.widthAnchor.constraint(equalToConstant: signUpButton.frame.width),
            signUpButton.heightAnchor.constraint(equalToConstant: signUpButton.frame.height)
        ])
    }

}
