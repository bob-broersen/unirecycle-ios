    //
    //  SettingsAppViewController.swift
    //  unirecycle
    //
    //  Created by mark on 09/03/2021.
    //  Copyright © 2021 HvA. All rights reserved.
    //
    
    import SwiftUI
    import UIKit
    import Firebase
    
    
    struct Section {
        let title: String
        let options: [SettingsOptionType]
    }
    
    enum SettingsOptionType{
        case staticCell(model: SettingsOption)
        case switchCell(model: SettingsSwitchOption)
        case feedbackCell(model: SettingsFeedbackOption)
        case pencilCell(model: SettingsPencilOption)
    }
    
    struct SettingsSwitchOption{
        let title: String
        let handler: (() -> Void)
        var isOn: Bool
    }
    
    struct SettingsFeedbackOption{
        let title: String
        let handler: (() -> Void)
    }
    
    struct SettingsPencilOption{
        let title: String
        let handler: (() -> Void)
    }
    
    struct SettingsOption{
        let title: String
        let handler: (() -> Void)
    }
    
    struct SettingsDropOption{
        let title: String
        let handler: (() -> Void)
    }
    
    class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
        var userData = Account()
        var profileVM = ProfileViewModel()
        var models = [Section]()
        
        private let tableView: UITableView = {
            let table = UITableView(frame: .zero, style: .grouped)
            
            // Standard TableViewCell
            table.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
            
            // Switch TableViewCell
            table.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.identifier)
            
            // Feedback TableViewCell
            table.register(FeedbackTableViewCell.self, forCellReuseIdentifier: FeedbackTableViewCell.identifier)
            
            // Pencil TableViewCell
            table.register(PencilTableViewCell.self, forCellReuseIdentifier: PencilTableViewCell.identifier)
            return table
        }()
        
        override func viewDidLoad(){
            super.viewDidLoad()
            
//            self.navigationItem.hidesBackButton = true
//            let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.bordered, target: self, action: "back:")
//                    self.navigationItem.leftBarButtonItem = newBackButton
            
            
            configure()
            title = "Settings"
            view.addSubview(tableView)
            
            tableView.backgroundColor = UIColor.white
            tableView.delegate = self
            tableView.dataSource = self
            tableView.frame = view.bounds
            tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 150.0, right: 0.0)
            tableView.separatorStyle = .none
            
            setupViews()
        }
        
        
        func setupViews(){
            //            setupTableView()
            
        }
        
        func applyShadow(cell: UITableViewCell){
            cell.layer.borderColor = UIColor.gray.cgColor
            
            //Round Corners
            cell.layer.cornerRadius = 4
            
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOpacity = 0.2
            cell.layer.shadowOffset = .zero
            cell.layer.shadowRadius = 3
            cell.backgroundColor = .white
            cell.layer.borderWidth = 0
        }
        
        func configure() {
            
            let fullName = userData.firstName! + " " + userData.secondName!
            let emailAddress = Auth.auth().currentUser?.email ?? "Email Address"
            
            
            models.append(Section(title: "", options: [
                .feedbackCell(model:SettingsFeedbackOption(title: "Feedback & help")
                {
                    let feedbackhelpVC = FeedbackHelpViewController()
                    self.navigationController?.pushViewController(feedbackhelpVC, animated: true)
                }),
                
                
                
            ]))
            
            models.append(Section(title: "Profile and security", options: [
                .pencilCell(model:SettingsPencilOption(title: fullName){
                    
                }),
                
                .pencilCell(model:SettingsPencilOption(title: emailAddress){
                    
                }),
                
                .staticCell(model:SettingsOption(title: "Change Password"){
                    FirebasAuthHelper().sendPasswordReset(withEmail: emailAddress)
                    self.emailPopup()
                }),
                
                .staticCell(model:SettingsOption(title: "Update personal data"){
                    self.updateUserData()
                }),
            ]))
            models.append(Section(title: "Notifications", options: [
                .switchCell(model:SettingsSwitchOption(title: "Reminder messages", handler: {
                    
                }, isOn: true)),
                
                .switchCell(model:SettingsSwitchOption(title: "Feedback messages", handler: {
                    
                }, isOn: true)),
                
                .staticCell(model:SettingsOption(title: "Remind me:"){
                    
                }),
                
            ]))
            models.append(Section(title: "Sounds", options: [
                .switchCell(model:SettingsSwitchOption(title: "Sound effects", handler: {
                    
                }, isOn: true))
            ]))
            
            models.append(Section(title: "", options: [
                .feedbackCell(model:SettingsFeedbackOption(title: "Log out")
                {
                    self.signOutUser()
                }),
                
            ]))
            
        }
        
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            let section = models[section]
            return section.title
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return models.count
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return models[section].options.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let model = models[indexPath.section].options[indexPath.row]
            
            switch model.self{
            
            // Standard cell
            case .staticCell(let model):
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: SettingsTableViewCell.identifier,
                    for: indexPath
                ) as? SettingsTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(with: model)
                
                applyShadow(cell: cell)
                
                return cell
                
            // Switch cell
            case.switchCell(let model):
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: SwitchTableViewCell.identifier,
                    for: indexPath
                ) as? SwitchTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(with: model)
                
                applyShadow(cell: cell)
                
                
                return cell
                
            // Feedback cell
            case.feedbackCell(let model):
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: FeedbackTableViewCell.identifier,
                    for: indexPath
                ) as? FeedbackTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(with: model)
                
                applyShadow(cell: cell)
                
                return cell
                
                
            // Pencil cell
            case.pencilCell(let model):
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: PencilTableViewCell.identifier,
                    for: indexPath
                ) as? PencilTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(with: model)
                
                applyShadow(cell: cell)
                
                return cell
                
            }
            
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            self.tableView.deselectRow(at: indexPath, animated: true)
            
            let type = models[indexPath.section].options[indexPath.row]
            switch type.self{
            case .staticCell(let model):
                model.handler()
                
            case .switchCell(let model):
                model.handler()
                
            case .feedbackCell(let model):
                model.handler()
                
            case .pencilCell(let model):
                model.handler()
                
            }
        }
        
        
        
        // Header font and color
        func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
        {
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "Roboto", size: 20)!
            header.textLabel?.textColor = UIColor.black
            header.textLabel?.text = header.textLabel?.text?.capitalized
        }
        
        
        func signOutUser(){
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
            
            let navVC = IntroNavigationController(rootViewController: IntroViewController())
            
            
            self.navigationItem.hidesBackButton = true
            
            UIApplication.shared.windows.first?.rootViewController = navVC
            navigationController?.popToRootViewController(animated: true)
            
        }
        
        func hideKeyboard() {
            tableView.endEditing(true)
        }
        
        // Update user username and email
        func updateUserData(){
            let indexPath = IndexPath(row: 0, section: 1)
            let indexPathTwo = IndexPath(row: 1, section: 1)
            let usernameCell = self.tableView.cellForRow(at: indexPath) as! PencilTableViewCell
            let emailCell = self.tableView.cellForRow(at: indexPathTwo) as! PencilTableViewCell
            
            let emailValue = emailCell.label.text
            let usernameValue = usernameCell.label.text
            
            let splittedStringsArray = usernameCell.label.text?.split(separator: " ", maxSplits: 1).map(String.init)
            
            
            if  emailValue != nil && (usernameValue?.isEmpty == false)  && (emailValue?.matches("^[A-Za-z0-9._%+-]+(@hva|@ad\\.hva)\\.nl$") == true){
                profileVM.updateUserData(fullname: splittedStringsArray! as Array, email: emailValue!)
                self.updateDataPopup()
            }
            else if (emailValue?.matches("^[A-Za-z0-9._%+-]+(@hva|@ad\\.hva)\\.nl$") == false){
                incorrectMailPopup()
            }else{
                incorrectFieldPopup()
            }
        }
        
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            print("textfield tag \(textField.tag)")
        }
        
        
        @objc func incorrectFieldPopup(){
            
            let alertController = UIAlertController(title: "Full name or email is incorrect", message: "Please check the input fields and try again", preferredStyle: .alert)
            
            alertFunc(alertController: alertController)
        }
        
        @objc func emailPopup(){
            
            let alertController = UIAlertController(title: "Reset mail has been send", message: "Please check your inbox", preferredStyle: .alert)
            
            alertFunc(alertController: alertController)
        }
        
        
        @objc func updateDataPopup(){
            
            let alertController = UIAlertController(title: "Personal data has been changed", message: "", preferredStyle: .alert)
            
            alertFunc(alertController: alertController)
        }
        
        @objc func incorrectMailPopup(){
            
            let alertController = UIAlertController(title: "Email must contain @hva.nl", message: "", preferredStyle: .alert)
            
            alertFunc(alertController: alertController)
        }
        
        func alertFunc(alertController: UIAlertController){
            present(alertController, animated: true) {
                
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
                
                alertController.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
            }
        }
        
        @objc func dismissAlertController(){
            
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    extension String {
        func matches(_ regex: String) -> Bool {
            return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
        }
    }
    
    
    
