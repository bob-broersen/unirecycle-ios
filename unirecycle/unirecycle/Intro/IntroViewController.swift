//
//  IntroViewController.swift
//  unirecycle
//
//  Created by Bob Broersen on 02/02/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {
    private let pages = Strings.Intro.collectionViewPages
    
    private let createButton: Button = {
        let button = Button()
        button.setTitle(Strings.Intro.registerButtonTitle, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(openRegisterVC), for: .touchUpInside)
        return button
    }()
    
    private let signInButton: Button = {
        let button = Button()
        button.backgroundColor = .white
        button.setTitle(Strings.Intro.signInButtonTitle, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(openLoginVC), for: .touchUpInside)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 347), collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = Colors.purple
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(IntroCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = pages.count
        pageControl.currentPageIndicatorTintColor = Colors.blue
        pageControl.pageIndicatorTintColor = .white
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.purple
        collectionView.dataSource = self
        collectionView.delegate  = self
        setupViews()
    }
    
    @objc func openRegisterVC(){
        let registerVC = RegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    @objc func openLoginVC(){
        let loginVC = LoginViewController()
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func setupViews(){
        setupCollectionView()
        setupPageControl()
        setupAccountButton()
    }
    
    func setupCollectionView(){
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 131),
            collectionView.widthAnchor.constraint(equalToConstant: view.frame.width),
        ])
    }
    
    func setupPageControl(){
        view.addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            pageControl.widthAnchor.constraint(equalToConstant: 60),
            pageControl.heightAnchor.constraint(equalToConstant: 9)
        ])
    }
    
    func setupAccountButton(){
        view.addSubview(signInButton)
        
        view.addSubview(createButton)
        NSLayoutConstraint.activate([
            createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createButton.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 72),
            createButton.widthAnchor.constraint(equalToConstant: 303),
            createButton.heightAnchor.constraint(equalToConstant: 49)
        ])
        
        NSLayoutConstraint.activate([
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.topAnchor.constraint(equalTo: createButton.bottomAnchor, constant: 20),
            signInButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:-62),
            signInButton.widthAnchor.constraint(equalToConstant: 303),
            signInButton.heightAnchor.constraint(equalToConstant: 49)
        ])
    }
}

extension IntroViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! IntroCollectionViewCell
        cell.setPage(page: pages[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / scrollView.frame.width)
    }
    
}
