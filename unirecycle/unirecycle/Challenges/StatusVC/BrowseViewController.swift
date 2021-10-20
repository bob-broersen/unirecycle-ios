//
//  BrowseViewController.swift
//  unirecycle
//
//  Created by Daron on 05/03/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import UIKit

class BrowseViewController: UIViewController {
    
    lazy var categories = [Category]()
    var parentSegment: UIViewController?
    
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: view.frame.size.width/2.3, height: view.frame.size.width/2.3)
        layout.minimumLineSpacing = 25
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.register(ChallengeCollectionViewCell.self, forCellWithReuseIdentifier: ChallengeCollectionViewCell.identifier)
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.categories = categoryViewModel!.categories
        self.collectionView.reloadData()
        collectionView.delegate = self
        collectionView.dataSource = self
        setUpViews()
        let challengeCategorie = ChallengeCategorie()
        challengeCategorie.setCategory(category: categories[0])
        challengeCategorie.hidesBottomBarWhenPushed = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    
    func setUpViews() {
        setupLayout()
    }
    
    func setupLayout() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            collectionView.widthAnchor.constraint(equalToConstant: view.frame.width),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

extension BrowseViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChallengeCollectionViewCell.identifier, for: indexPath) as! ChallengeCollectionViewCell
            cell.configure(category: self.categories[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let challengeCategorie = ChallengeCategorie()
        challengeCategorie.setCategory(category: categories[indexPath.row])
        challengeCategorie.hidesBottomBarWhenPushed = true
        parentSegment?.navigationController?.pushViewController(challengeCategorie, animated: true)
    }
}
