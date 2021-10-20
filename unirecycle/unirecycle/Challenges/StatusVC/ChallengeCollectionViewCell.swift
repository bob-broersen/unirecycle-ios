//
//  ChallengeCollectionViewCell.swift
//  unirecycle
//
//  Created by Daron on 15/02/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import UIKit

class ChallengeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
   
  
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    
    private let myLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Bold", size: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 4
        contentView.backgroundColor = .white
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 5
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        contentView.layer.masksToBounds = true
        contentView.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpContentView(){
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
        
        addSubview(myLabel)
        NSLayoutConstraint.activate([
            myLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            myLabel.heightAnchor.constraint(equalToConstant: 24),
            myLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 25)
        ])
        
        addSubview(myImageView)
        NSLayoutConstraint.activate([
            myImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            myImageView.topAnchor.constraint(equalTo: myLabel.bottomAnchor, constant: 25),
            myImageView.widthAnchor.constraint(equalToConstant: 281)
        ])
    }
    
    public func configure(category: Category) {
        guard let imageUrl:URL = URL(string: category.imageUrl) else {
            return
        }
        myImageView.load(url: imageUrl)
        myLabel.text = category.name
    }
}
