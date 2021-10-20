//
//  HomeCollectionViewItem.swift
//  unirecycle
//
//  Created by Bob Broersen on 20/04/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import UIKit

class HomeCollectionViewItem: UIView {
    var collectionViewContent: [HomeCollectionViewInfo]?
    var parent: UIViewController?
    var popupTitle: String?
    var popupText: String?

    func addValues(infoTitle: String, infoText: String, title: String, collectionViewContent: [HomeCollectionViewInfo], parent: UIViewController) {
        self.collectionViewContent = collectionViewContent
        self.title.text = title
        pageControl.numberOfPages = collectionViewContent.count
        collectionView.dataSource = self
        collectionView.delegate  = self
        self.parent = parent
        
        if !infoTitle.isEmpty{
            popupTitle = infoTitle
            popupText = infoText
            setupInfoButton()
        }
        setupViews()
    }
    
    let infoImage: UIImageView = {
        let image = UIImage(named: images.infoButton)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var title: UILabel = {let label = UILabel()
        label.font = UIFont(name: "RobotoCondensed-Regular", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var containerCollectionView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 4
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 4.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 141), collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(HomeCollectionViewItemCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = Colors.darkPurple
        pageControl.pageIndicatorTintColor = Colors.purple
        pageControl.isUserInteractionEnabled = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        return pageControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        setupTitle()
        setUpContainer()
        setupCollectionView()
        setupPageControl()
    }
    
    func setupInfoButton(){
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openPopup(tapGestureRecognizer:)))
        infoImage.isUserInteractionEnabled = true
        infoImage.addGestureRecognizer(tapGestureRecognizer)
        
        addSubview(infoImage)
        NSLayoutConstraint.activate([
            infoImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            infoImage.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
    
    @objc func openPopup(tapGestureRecognizer: UITapGestureRecognizer) {
        let popupVC = PopUpViewController()
        popupVC.setValues(popupTitle: popupTitle ?? "", popupText: popupText ?? "")
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        parent!.present(popupVC, animated: true, completion: nil)
    }
    
    func setupTitle(){
        addSubview(title)
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            title.topAnchor.constraint(equalTo: topAnchor)

        ])
    }
    
    func setUpContainer(){
        addSubview(containerCollectionView)
        NSLayoutConstraint.activate([
            containerCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containerCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            containerCollectionView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 12),
        ])
    }
    
    func setupCollectionView(){
        containerCollectionView.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: containerCollectionView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: containerCollectionView.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: containerCollectionView.topAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    func setupPageControl(){
        containerCollectionView.addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: containerCollectionView.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: containerCollectionView.bottomAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 40),
            pageControl.widthAnchor.constraint(equalTo: containerCollectionView.widthAnchor),
        ])
    }
    
}

extension HomeCollectionViewItem: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewContent?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCollectionViewItemCell
        cell.setInfo(info: collectionViewContent![indexPath.row])
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
