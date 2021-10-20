//
//  RegisterDetailsViewController.swift
//  unirecycle
//
//  Created by Bob Broersen on 10/02/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import Foundation
import UIKit

class RegisterDetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var userBuilder: UserProfileBuilder?
    var imagePicker = UIImagePickerController()
    

    let profileImage: UIButton = {
        let image = UIImage(named: images.profileImagePlaceholder)
        let profileImage = UIButton(frame: CGRect(x: 0, y: 0, width: 149, height: 149))
        profileImage.setImage(image, for: .normal)
        profileImage.addTarget(self, action: #selector(pickProfileImage), for: .touchUpInside)
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        return profileImage
    }()
    
    let firstNameField: InputTextField = {
        let firstNameField = InputTextField(frame: CGRect(x: 0, y: 0, width: 311, height: 18))
        firstNameField.attributedPlaceholder = NSAttributedString(string: Strings.Intro.firstNamePlaceholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        firstNameField.textColor = .black
        firstNameField.overrideLineColor(color: Colors.gray.cgColor)
        firstNameField.paddingRight()
        firstNameField.autocapitalizationType = .none
        firstNameField.translatesAutoresizingMaskIntoConstraints = false
        return firstNameField
    }()
    
    let secondNameField: InputTextField = {
        let secondNameField = InputTextField(frame: CGRect(x: 0, y: 0, width: 311, height: 18))
        secondNameField.attributedPlaceholder = NSAttributedString(string: Strings.Intro.secondNamePlaceholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        secondNameField.textColor = .black
        secondNameField.overrideLineColor(color: Colors.gray.cgColor)
        secondNameField.paddingRight()
        secondNameField.translatesAutoresizingMaskIntoConstraints = false
        return secondNameField
    }()
    
    let completeRegistrationButton: Button = {
        let button = Button(frame: CGRect(x: 0, y: 0, width: 343, height: 58))
        button.setTitle(Strings.Intro.completeRegistrationButtonTitle, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(completeClicked), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Strings.Intro.registerDetailsViewControllerTitle
        view.backgroundColor = .white
        self.dismissKeyboard()
        setUpViews()
    }
    
    @objc func pickProfileImage(){
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        profileImage.setImage(image, for: .normal)
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    @objc func completeClicked(){
        if (firstNameField.text != nil) && (secondNameField.text != nil) {
            userBuilder?.addFirstName(firstname: firstNameField.text!).addSecondName(secondName: secondNameField.text!).addProfileImage(profileImage: profileImage.image(for: .normal)!)
            FirebasAuthHelper().register(user: (userBuilder?.build())!, completion: { succes in
                if succes{
                    userViewModel = UserViewModel()
                    leaderboardViewModel = LeaderboardViewModel()

                    userViewModel?.fetchUser {
                        let viewController = NavigationBarHome()
                        viewController.modalPresentationStyle = .fullScreen
                        self.present(viewController, animated: true, completion: nil)
                    }
                } else {
                    print("something went wrong")
                }
            })
        }
    }
    
    func setUpViews(){
        setUpProfileImage()
        setUpFirstNameField()
        setUpSecondNameField()
        setUpCompleteButton()
    }
    
    func setUpProfileImage(){
        view.addSubview(profileImage)
        NSLayoutConstraint.activate([
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 93),
            profileImage.widthAnchor.constraint(equalToConstant: profileImage.frame.width),
            profileImage.heightAnchor.constraint(equalToConstant: profileImage.frame.height),

        ])
    }
    
    func setUpFirstNameField(){
        view.addSubview(firstNameField)
        NSLayoutConstraint.activate([
            firstNameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstNameField.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 55),
            firstNameField.widthAnchor.constraint(equalToConstant: firstNameField.frame.width),
            firstNameField.heightAnchor.constraint(equalToConstant: firstNameField.frame.height)

        ])
    }
    
    func setUpSecondNameField(){
        view.addSubview(secondNameField)
        NSLayoutConstraint.activate([
            secondNameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondNameField.topAnchor.constraint(equalTo: firstNameField.bottomAnchor, constant: 85),
            secondNameField.widthAnchor.constraint(equalToConstant: secondNameField.frame.width),
            secondNameField.heightAnchor.constraint(equalToConstant: secondNameField.frame.height)

        ])
    }
    
    func setUpCompleteButton(){
        view.addSubview(completeRegistrationButton)
        NSLayoutConstraint.activate([
            completeRegistrationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            completeRegistrationButton.topAnchor.constraint(equalTo: secondNameField.bottomAnchor, constant: 93),
            completeRegistrationButton.widthAnchor.constraint(equalToConstant: completeRegistrationButton.frame.width),
            completeRegistrationButton.heightAnchor.constraint(equalToConstant: completeRegistrationButton.frame.height)

        ])
    }
}
