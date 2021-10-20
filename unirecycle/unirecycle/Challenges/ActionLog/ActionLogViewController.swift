//
//  ActionLogViewController.swift
//  unirecycle
//
//  Created by Daron on 19/05/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import UIKit

class ActionLogViewController: UIViewController {
    
    var activeChallenge: ActiveChallengeModel?
    
    func setActiveChallenge(activeChallenge: ActiveChallengeModel) {
        self.activeChallenge = activeChallenge
        titleLabel.text = "\(Strings.ActionLog.title) \(activeChallenge.subtitle)?"
    }
    
    
  
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = UIFont(name: "Roboto-Regular", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let experienceTextField: UITextView = {
        let textField = UITextView()
        textField.text = Strings.ActionLog.textField
        textField.textColor = .lightGray
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.size.width/3.5, height: view.frame.size.width/3)
        layout.minimumLineSpacing = 25
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.register(ActionLogCellCollectionViewCell.self, forCellWithReuseIdentifier: ActionLogCellCollectionViewCell.identifier)
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    private let actionButton: Button = {
        let button = Button()
        button.setTitle(Strings.ActionLog.logButton, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(logAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        experienceTextField.delegate = self
    
        setup()
    }
    
 
    
    @objc func logAction() {
        let date = NSDate()
        let calendar = NSCalendar.current
        let currentDay = calendar.dateComponents([.day], from: date as Date)
        let lastElement = (activeChallenge?.daysCompleted.last ?? NSDate()) as NSDate
        let lastDay = calendar.dateComponents([.day], from: lastElement as Date)

            userViewModel?.updateDaysComplete(challengeId: activeChallenge!.id)
            ActiveViewController().updateView()
        
            navigationController?.popToRootViewController(animated: true)
    }
  
    
    func setup(){
        
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 27),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10)
            
        ])
        
        view.addSubview(experienceTextField)
        NSLayoutConstraint.activate([
            experienceTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            experienceTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            experienceTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            experienceTextField.heightAnchor.constraint(equalToConstant: view.frame.height / 3)
        ])
        
        
        view.addSubview(actionButton)
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            actionButton.widthAnchor.constraint(equalToConstant: view.frame.width - 30),
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: experienceTextField.bottomAnchor,constant: 30),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.bottomAnchor.constraint(equalTo: actionButton.topAnchor),
            collectionView.widthAnchor.constraint(equalToConstant: view.frame.width - 30),
        ])
    }
    
}

extension ActionLogViewController: UITextViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = Strings.ActionLog.textField
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActionLogCellCollectionViewCell.identifier, for: indexPath) as! ActionLogCellCollectionViewCell
        cell.configure(mood: Strings.ActionLog.moodButtons[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return (collectionView.indexPathsForSelectedItems?.count ?? 0) < 2
    }
   
}
