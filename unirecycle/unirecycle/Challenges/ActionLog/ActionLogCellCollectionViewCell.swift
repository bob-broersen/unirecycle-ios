//
//  ActionLogCellCollectionViewCell.swift
//  unirecycle
//
//  Created by Daron on 19/05/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import UIKit

class ActionLogCellCollectionViewCell: UICollectionViewCell {
    static let identifier = "ActionCell"
   
    override var isSelected: Bool {
        didSet {
            // set color according to state
            self.backgroundColor = self.isSelected ? Colors.mildPurple: Colors.lightPurple
        }
    }
    
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
        label.font = UIFont(name: "Roboto-Regular", size: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 3
        self.backgroundColor = UIColor(hexString: "EEF4FF")
        contentView.clipsToBounds = true
        setUpContentView()

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
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
        
        addSubview(myImageView)
        NSLayoutConstraint.activate([
            myImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            myImageView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 25),
            myImageView.widthAnchor.constraint(equalToConstant: 281)
        ])
        
        addSubview(myLabel)
        NSLayoutConstraint.activate([
            myLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            myLabel.heightAnchor.constraint(equalToConstant: 24),
            myLabel.topAnchor.constraint(equalTo: myImageView.bottomAnchor, constant: 25)
        ])
    }
    
    public func configure(mood: Mood) {
        myImageView.image = UIImage(named: mood.imageName)
        myLabel.text = mood.title
    }
}
