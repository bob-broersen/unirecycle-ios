//
//  IntroCollectionViewCell.swift
//  unirecycle
//
//  Created by Bob Broersen on 02/02/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import Foundation
import UIKit

class IntroCollectionViewCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode =  .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.textAlignment = .center;
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpContentView()
        backgroundColor = Colors.purple
        contentView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpContentView(){
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            imageView.widthAnchor.constraint(equalToConstant: 281)
        ])

        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 24),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20)
        ])

        addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 40),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 255),
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

    }
    
    func setPage(page: Page){
        imageView.image = UIImage(named: page.imageName)
        titleLabel.text = page.title
        descriptionLabel.text = page.description
    }
}
