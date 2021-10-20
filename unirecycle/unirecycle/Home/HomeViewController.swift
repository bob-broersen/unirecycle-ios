//
//  HomeViewController1.swift
//  unirecycle
//
//  Created by Bob Broersen on 16/02/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    let handingPlantImage: UIImageView = {
        let image = UIImage(named: images.handingPlantImage)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let checkProgressButton: Button = {
        let button = Button()
        button.setTitle(Strings.Home.checkProgress, for: .normal)
        button.setImage(UIImage(named: images.progress), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 4);
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let progressView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.backgroundColor = Colors.purple
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let progressTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = Strings.Home.progressTitle
        label.font = UIFont(name: "Roboto", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let progressDescription: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.text = Strings.Home.progressDescription
        label.font = UIFont(name: "Roboto", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let latestLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.Home.latestChallenge
        label.font = UIFont(name: "Roboto", size: 20)
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let latestChallengeView: ActiveChallenge = {
        let view = ActiveChallenge()
        view.translatesAutoresizingMaskIntoConstraints = false
        

        return view
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis =  .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let contentView = UIView()

    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Strings.Home.title
        view.backgroundColor = .white
        setUpViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userViewModel?.fetchUser {
            let activeChallenges = userViewModel?.user.activeChallenges!
            if activeChallenges?.count ?? 0 >= 1 {
                if let mostRecent = activeChallenges?.reduce((activeChallenges?[0])!, { $0.startDate.timeIntervalSince1970 > $1.endDate.timeIntervalSince1970  ? $0 : $1 } ) {
                    self.latestChallengeView.setChallenge(challenge: mostRecent)
                    self.latestChallengeView.arrangeViews()
                }
            } else {
                self.latestChallengeView.challenge = nil
                self.latestChallengeView.arrangeViews()
            }
        }
        
   
    }
    
    func setUpViews(){
        setUpScrollView()
        setUpProgressView()
        setUpLatestLabel()
        setUpLatestView()
        setUpStackView()
    }
    
    func setUpScrollView(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    func setUpProgressView(){
        contentView.addSubview(progressView)
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            progressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            progressView.heightAnchor.constraint(equalToConstant: 160),

        ])
        
        progressView.addSubview(progressTitle)
        NSLayoutConstraint.activate([
            progressTitle.topAnchor.constraint(equalTo: progressView.topAnchor, constant: 16),
            progressTitle.leadingAnchor.constraint(equalTo: progressView.leadingAnchor, constant: 16),
            progressTitle.trailingAnchor.constraint(equalTo: progressView.trailingAnchor, constant: -16),

        ])
        
        progressView.addSubview(progressDescription)
        NSLayoutConstraint.activate([
            progressDescription.topAnchor.constraint(equalTo: progressTitle.bottomAnchor, constant: 8),
            progressDescription.leadingAnchor.constraint(equalTo: progressView.leadingAnchor, constant: 16),
            progressDescription.trailingAnchor.constraint(equalTo: progressView.trailingAnchor, constant: -16),
        ])
        
        progressView.addSubview(handingPlantImage)
        NSLayoutConstraint.activate([
            handingPlantImage.bottomAnchor.constraint(equalTo: progressView.bottomAnchor, constant: -8),
            handingPlantImage.trailingAnchor.constraint(equalTo: progressView.trailingAnchor),
        ])
        
        progressView.addSubview(checkProgressButton)
        NSLayoutConstraint.activate([
            checkProgressButton.topAnchor.constraint(equalTo: progressDescription.bottomAnchor, constant: 16),
            checkProgressButton.leadingAnchor.constraint(equalTo: progressView.leadingAnchor, constant: 16),
            checkProgressButton.bottomAnchor.constraint(equalTo: progressView.bottomAnchor, constant: -16),
            checkProgressButton.widthAnchor.constraint(equalToConstant: 190),
            checkProgressButton.heightAnchor.constraint(equalToConstant: 35),

        ])
        
        checkProgressButton.addTarget(self, action: #selector(checkProgressButtonClicked), for: .touchUpInside)

    }
    
    @objc func checkProgressButtonClicked() {
        navigationController?.pushViewController(CheckProgressViewController(), animated: true)
    }
    
    func setUpLatestLabel(){
        scrollView.addSubview(latestLabel)
        NSLayoutConstraint.activate([
            latestLabel.heightAnchor.constraint(equalToConstant: 24),
            latestLabel.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 24),
            latestLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            latestLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),

        ])
    }
    
    func setUpLatestView(){
        contentView.addSubview(latestChallengeView)
        NSLayoutConstraint.activate([
            latestChallengeView.heightAnchor.constraint(equalToConstant: 148),
            latestChallengeView.topAnchor.constraint(equalTo: latestLabel.bottomAnchor, constant: 12),
            latestChallengeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            latestChallengeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    func setUpStackView(){
        let spCollectionView = HomeCollectionViewItem()
        let leaderBoardCollectionView = HomeCollectionViewItem()
        
        spCollectionView.addValues(infoTitle: Strings.Home.popupTitle, infoText: Strings.Home.popupText, title: Strings.Home.sp, collectionViewContent: [
            HomeCollectionViewInfo(title: Strings.Home.thisWeek, value: String(userViewModel?.getCoinsThisWeek() ?? 0), withCoin: true),
            HomeCollectionViewInfo(title: Strings.Home.allTime, value: String(userViewModel?.getCoinsAllTime() ?? 0), withCoin: true),
            HomeCollectionViewInfo(title: Strings.Home.now, value: String(userViewModel?.user.coins ?? 0), withCoin: true),
        ], parent: self)
        
        let rankThisWeek = leaderboardViewModel?.getRankForWeek() ?? "0"
        let rankThisMonth = leaderboardViewModel?.getRankForMonth() ?? "0"

        
        leaderBoardCollectionView.addValues(infoTitle: "", infoText: "", title: Strings.Home.leaderboard, collectionViewContent: [
            HomeCollectionViewInfo(title: Strings.Home.thisWeek, value: rankThisWeek, withCoin: false),
            HomeCollectionViewInfo(title: Strings.Home.allTime, value: rankThisMonth, withCoin: false)
        ], parent: self)

        stackView.addArrangedSubview(spCollectionView)
        stackView.addArrangedSubview(leaderBoardCollectionView)

        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: 192),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            stackView.topAnchor.constraint(equalTo: latestChallengeView.bottomAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
        ])
    }
    

}
