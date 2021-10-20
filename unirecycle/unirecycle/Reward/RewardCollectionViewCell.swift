//
//  RewardCollectionViewCell.swift
//  unirecycle
//
//  Created by Daron on 19/03/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import UIKit

class RewardCollectionViewCell: UICollectionViewCell {
    static let identifier = "CustomCollectionViewCell"
    
    private let brandLogoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "benjerry")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let bottomSection: UIView = {
        let bottomBar = UIView()
        bottomBar.translatesAutoresizingMaskIntoConstraints = false
        return bottomBar
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
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "500 "
        label.textAlignment = .right
        return label
    }()
    
    
    private let rewardTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Bold", size: 20)
        label.textAlignment = .center
        label.text = "rewards"
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let brandLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.textAlignment = .center
        label.text = "brand"
        label.textColor = Colors.purple
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
        addSubview(brandLogoImage)
        NSLayoutConstraint.activate([
            brandLogoImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            brandLogoImage.topAnchor.constraint(equalTo: topAnchor),
            brandLogoImage.heightAnchor.constraint(equalToConstant: contentView.frame.height - contentView.frame.height / 3),
            brandLogoImage.widthAnchor.constraint(equalToConstant: contentView.frame.width)
        ])
        
       
        
        addSubview(bottomSection)
        NSLayoutConstraint.activate([
            bottomSection.topAnchor.constraint(equalTo: brandLogoImage.bottomAnchor, constant: 0),
            bottomSection.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            bottomSection.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomSection.rightAnchor.constraint(equalTo: rightAnchor),
            bottomSection.leftAnchor.constraint(equalTo: leftAnchor)
        ])
        
        bottomSection.addSubview(toSpendLabel)
        NSLayoutConstraint.activate([
            toSpendLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -9),
            toSpendLabel.rightAnchor.constraint(equalTo: bottomSection.rightAnchor, constant: -30),
            
        ])

        bottomSection.addSubview(rewardIcon)
        NSLayoutConstraint.activate([
            rewardIcon.bottomAnchor.constraint(equalTo: bottomSection.bottomAnchor, constant: -10),
            rewardIcon.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            rewardIcon.heightAnchor.constraint(equalToConstant: 14),
            rewardIcon.widthAnchor.constraint(equalToConstant: 14)
        ])
        
        bottomSection.addSubview(rewardTitle)
        NSLayoutConstraint.activate([
            rewardTitle.widthAnchor.constraint(equalToConstant: contentView.frame.width - 20),
            rewardTitle.leftAnchor.constraint(equalTo: bottomSection.leftAnchor, constant: 10),
            rewardTitle.topAnchor.constraint(equalTo: bottomSection.topAnchor, constant: 0)
        ])
        
        bottomSection.addSubview(brandLabel)
        NSLayoutConstraint.activate([
            brandLabel.leftAnchor.constraint(equalTo: bottomSection.leftAnchor, constant: 10),
            brandLabel.heightAnchor.constraint(equalToConstant: 13),
            brandLabel.topAnchor.constraint(equalTo: rewardTitle.bottomAnchor, constant: 0),
            brandLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
        
    }
    
    public func configure(reward: Reward) {
        guard let imageUrl:URL = URL(string: reward.imageUrl) else {
            return
        }
        brandLogoImage.load(url: imageUrl)
        rewardTitle.text = reward.title
        toSpendLabel.text = String(reward.price)
        brandLabel.text = reward.brandName
    }
}
