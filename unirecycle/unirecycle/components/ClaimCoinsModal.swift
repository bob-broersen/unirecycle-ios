//
//  ClaimCoinsModal.swift
//  unirecycle
//
//  Created by Daron on 29/05/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import Foundation

//
//  CustomModal.swift
//  unirecycle
//
//  Created by Daron on 24/03/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import UIKit
import RangeSeekSlider
import DropDown
import NVActivityIndicatorView


class ClaimCoinsModal: UIViewController {
    
    
    var activeView: ActiveViewController?
    var coins: Int?
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    var panGesture = UIPanGestureRecognizer()
    var completedChallenge: ActiveChallengeModel?
    func setupModal(coins: Int, completedChallenge: ActiveChallengeModel) {
        self.coins = coins
        self.completedChallenge = completedChallenge
        claimButton.setTitle("GET \(coins) SP", for: .normal)
    }
    
      private let modaltitle: UILabel = {
          let label = UILabel()
        label.text = "Congrats!"
        label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    
      private let subTitle: UILabel = {
          let label = UILabel()
        label.text = "You just finished the challenge"
        label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    private let claimButton: Button = {
        let button = Button()
        button.setTitle("GET .. SP", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeActiveChallenge), for: .touchUpInside)
        return button
    }()
    
    func startAnimation() {
        let loading = NVActivityIndicatorView(frame: .zero, type: .ballPulse, color: .purple, padding: 0)
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
    
    @objc func closeActiveChallenge() {
        let group = DispatchGroup()
        group.enter()
        startAnimation()

        let userCoins = userViewModel?.user.coins
        let newCoins = userCoins! + coins!
        userViewModel?.completeActiveChallenge(coins: newCoins, earnedCoins: coins!, completedChallenge: completedChallenge!)
        group.leave()
        
        group.notify(queue: .main, execute: {
            leaderboardViewModel = LeaderboardViewModel()
            self.activeView?.updateView()
            
        })
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        setUpViews()
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }

    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
    
        
    }
    
    
    func setUpViews() {
        mainLayout()
    }
    
    
    func mainLayout() {
        view.addSubview(modaltitle)
        NSLayoutConstraint.activate([
            modaltitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            modaltitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        view.addSubview(subTitle)
        NSLayoutConstraint.activate([
            subTitle.topAnchor.constraint(equalTo: modaltitle.bottomAnchor, constant: 30),
            subTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
                
        
        view.addSubview(claimButton)
        NSLayoutConstraint.activate([
            claimButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            claimButton.widthAnchor.constraint(equalToConstant: view.frame.width - 60),
            claimButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            claimButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}

