//
//  BadgeTableViewCell.swift
//  unirecycle
//
//  Created by mark on 04/05/2021.
//  Copyright © 2021 HvA. All rights reserved.
//


import UIKit

class BadgeTableViewCell: UITableViewCell {
    var badge: Badge?
    
    func setBadge(badge: Badge){
        
        let imageUrl = badge.imageUrl ?? ""
        
        let imageLink = URL(string: imageUrl)
       
       let imageData = try? Data(contentsOf: imageLink!)
                           
        let imageBadge = UIImage(data: imageData!) as UIImage?
        
        title.text = badge.title
        subTitle.text = badge.description
        iconView.image = imageBadge
    }
        
    private let view: UIView = {
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
    
    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: images.chefImage)
        imageView.layer.cornerRadius = 4
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let title: UILabel = {
        let title = UILabel()
        title.font = UIFont(name: "Roboto-Bold", size: 20)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.adjustsFontSizeToFitWidth = true
        title.minimumScaleFactor = 0.5
        title.numberOfLines = 1
        return title
    }()
    
    private let subTitle: UILabel = {
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.numberOfLines = 2
        description.lineBreakMode = .byWordWrapping
        return description
    }()


    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        contentView.backgroundColor = .red
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        setupView()
        setupIconView()
        setUpTitle()
        setUpDescription()
    }
    
    func setupView(){
        addSubview(view)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            view.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)

        ])
    }
    
    func setupIconView(){
        view.addSubview(iconView)
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            iconView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            iconView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            iconView.widthAnchor.constraint(equalToConstant: 68),

        ])
    }
    
    func setUpTitle() {
        view.addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            title.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -62)
        ])
    }
    
    func setUpDescription() {
        view.addSubview(subTitle)
        NSLayoutConstraint.activate([
            subTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
//            subTitle.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            subTitle.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 16),
            subTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)

        ])
    }
}
    
