//
//  RewardClaimViewController.swift
//  unirecycle
//
//  Created by Daron on 25/03/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import UIKit

class RewardClaimViewController: UIViewController {
    var reward: Reward?
    
    let alert = UIAlertController(title: "Are you sure you want this reward?", message: nil, preferredStyle: .alert)
    let notEnoughAlert = UIAlertController(title: "You do not have enough SP", message: "By finishing challenges you earn SP", preferredStyle: .alert)
    
    private let brandLogoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let brandLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.textAlignment = .center
        label.textColor = Colors.purple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rewardTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 16)
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let productDescriptionText: UITextView = {
        let text = UITextView()
        text.font = UIFont(name: "Roboto-Regular", size: 13)
        text.textAlignment = .left
        text.isEditable = false
        text.textColor = .black
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let claimButton: Button = {
        let button = Button()
        button.setTitle(Strings.Reward.claimButton, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(claimReward), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Reward"
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { action in self.updateSP(coins: self.reward!.price) }))
        notEnoughAlert.addAction(UIAlertAction(title: "OKE", style: .default, handler: nil ))
        alert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: nil))
        
        setUpContentView()
    }
    
    @objc func claimReward() {
        if ((userViewModel?.user.coins)! >= reward!.price) {
            self.present(alert, animated: true)
        }else {
            self.present(notEnoughAlert, animated: true)
        }
    }
    
    func updateSP(coins: Int) {
        let rewardVC = RewardViewController()

        var newTotalCoins: Int = 0
        newTotalCoins = (userViewModel?.user.coins)! - self.reward!.price
        userViewModel?.user.coins = newTotalCoins
        userViewModel?.updateUserCoins(coins: newTotalCoins)
        rewardVC.updatePrice()
        navigationController?.popViewController(animated: true)
    }
    
    
    private func setUpContentView(){
        view.addSubview(brandLogoImage)
        NSLayoutConstraint.activate([
            brandLogoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            brandLogoImage.topAnchor.constraint(equalTo: view.topAnchor),
            brandLogoImage.heightAnchor.constraint(equalToConstant: view.frame.height - view.frame.height / 1.8),
            brandLogoImage.widthAnchor.constraint(equalToConstant: view.frame.width)
        ])
        
        
        
        view.addSubview(brandLabel)
        NSLayoutConstraint.activate([
            brandLabel.topAnchor.constraint(equalTo: brandLogoImage.bottomAnchor, constant: 15),
            brandLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
        ])
        
        view.addSubview(rewardTitle)
        NSLayoutConstraint.activate([
            rewardTitle.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: 5),
            rewardTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            
        ])
        
        view.addSubview(productDescriptionText)
        NSLayoutConstraint.activate([
            productDescriptionText.topAnchor.constraint(equalTo: rewardTitle.bottomAnchor, constant: 15),
            productDescriptionText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            productDescriptionText.widthAnchor.constraint(equalToConstant: view.frame.width - 30),
            productDescriptionText.heightAnchor.constraint(equalToConstant: 100),
            
        ])
        
        view.addSubview(claimButton)
        NSLayoutConstraint.activate([
            claimButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            claimButton.widthAnchor.constraint(equalToConstant: view.frame.width - 30),
            claimButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            claimButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    public func configure(reward: Reward) {
        guard let imageUrl:URL = URL(string: reward.imageUrl) else {
            return
        }
        self.reward = reward
        brandLogoImage.load(url: imageUrl)
        rewardTitle.text = reward.title
        claimButton.setTitle("CLAIM FOR \(String(reward.price)) SP", for: .normal)
        brandLabel.text = reward.brandName
        productDescriptionText.text = reward.productDescription
    }
}
