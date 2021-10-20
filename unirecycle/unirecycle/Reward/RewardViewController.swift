//
//  RewardViewController.swift
//  unirecycle
//
//  Created by Daron on 19/03/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import UIKit


class RewardViewController: UIViewController {
    
    var rewards = [Reward]()
    var parentSegment: UIViewController?
    let slideVC = CustomModal()
    lazy var user = Account() 
    
    
    let topBar: UIView = {
        let topBar = UIView()
        topBar.translatesAutoresizingMaskIntoConstraints = false
        topBar.backgroundColor = .white
        topBar.layer.shadowColor = UIColor.lightGray.cgColor
        topBar.layer.shadowOpacity = 0.5
        topBar.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        topBar.layer.shadowRadius = 3
        topBar.layer.masksToBounds = false
        topBar.layer.zPosition = 1
        return topBar
    }()
    
    let filterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Colors.blue
        button.setTitle(Strings.Reward.filterButton, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "filterIcon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showModal), for: .touchUpInside)
        button.layer.cornerRadius = 20
        return button
    }()
    
    let rewardIcon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "Sustainable-coin")
        image.layer.zPosition = 1
        return image
    }()
    
    let toSpendLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Bold", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "To spend: 135 "
        label.layer.zPosition = 1
        label.textAlignment = .right
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: view.frame.size.width/2.3, height: view.frame.size.width/2.3)
        layout.minimumLineSpacing = 25
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.register(RewardCollectionViewCell.self, forCellWithReuseIdentifier: RewardCollectionViewCell.identifier)
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Strings.Reward.title
        self.rewards = rewardViewModel!.rewards
        updatePrice()
        collectionView.delegate = self
        parentSegment = self
        collectionView.dataSource = self
        setUpViews()
        
//        if (userViewModel?.user.challenge)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updatePrice()
        toSpendLabel.text = "To spend \(String(self.user.coins ?? 0))"
    }
    
    func updatePrice() {
        self.user = userViewModel!.user
    }
    
    //TODO fix update collection view with new rewards array
    public func updateRewards() {
        self.rewards.removeAll()
        self.rewards = rewardViewModel!.filteredArray
        collectionView.reloadData()
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func showModal() {
        slideVC.rewardController = self
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        self.present(slideVC, animated: true, completion: nil)
    }
    
    func setUpViews() {
        setupLayout()
        view.bringSubviewToFront(filterButton)
    }

    
    func setupLayout() {
        view.addSubview(topBar)
        NSLayoutConstraint.activate([
            topBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            topBar.heightAnchor.constraint(equalToConstant: 40),
            topBar.widthAnchor.constraint(equalToConstant: view.frame.width),
        ])
        
        view.addSubview(filterButton)
        NSLayoutConstraint.activate([
            filterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            filterButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15),
            filterButton.widthAnchor.constraint(equalToConstant: 100),
            filterButton.heightAnchor.constraint(equalToConstant: 40),
            
        ])
        
        view.addSubview(toSpendLabel)
        NSLayoutConstraint.activate([
            toSpendLabel.topAnchor.constraint(equalTo: topBar.topAnchor, constant: 0),
            toSpendLabel.bottomAnchor.constraint(equalTo: topBar.bottomAnchor),
            toSpendLabel.rightAnchor.constraint(equalTo: topBar.rightAnchor, constant: -30),
        ])
        
        view.addSubview(rewardIcon)
        NSLayoutConstraint.activate([
            rewardIcon.topAnchor.constraint(equalTo: topBar.topAnchor, constant: 12),
            rewardIcon.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            rewardIcon.heightAnchor.constraint(equalToConstant: 14),
            rewardIcon.widthAnchor.constraint(equalToConstant: 14)
        ])
        
        
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.topAnchor.constraint(equalTo: topBar.bottomAnchor, constant: 0),
            collectionView.widthAnchor.constraint(equalToConstant: view.frame.width),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

extension RewardViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RewardCollectionViewCell.identifier, for: indexPath) as! RewardCollectionViewCell
        cell.configure(reward: self.rewards[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rewards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let rewardClaimViewController = RewardClaimViewController()
        rewardClaimViewController.configure(reward: rewards[indexPath.row])
        rewardClaimViewController.hidesBottomBarWhenPushed = true
        parentSegment?.navigationController?.pushViewController(rewardClaimViewController, animated: true)
    }
}

extension RewardViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
