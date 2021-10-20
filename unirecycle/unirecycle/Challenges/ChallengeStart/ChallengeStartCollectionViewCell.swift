//
//  ChallengeStartCollectionViewCell.swift
//  unirecycle
//
//  Created by Ryno on 10/03/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import UIKit

class ChallengeStartCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
        
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
     let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
     
     let titleValue: UILabel = {
        let title = UILabel()
        title.font = UIFont(name: "Roboto-Regular", size: 15)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.adjustsFontSizeToFitWidth = true
        title.minimumScaleFactor = 0.5
        title.numberOfLines = 1
        title.text = ""
        title.textAlignment = .center
        return title
    }()
    
    let subTitle: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 1
        title.lineBreakMode = .byWordWrapping
        title.font = UIFont(name: "Roboto-Regular", size: 12)
        title.text = ""
        title.textColor = .gray
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 4
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
            stackView.heightAnchor.constraint(equalToConstant: 40),
            stackView.widthAnchor.constraint(equalToConstant: 150),
        ])
        
        addSubview(myImageView)
        NSLayoutConstraint.activate([
            myImageView.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 0),
            myImageView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 0),
            myImageView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 0),
        ])
                
        addSubview(titleValue)
        NSLayoutConstraint.activate([
            titleValue.leftAnchor.constraint(equalTo: myImageView.rightAnchor, constant: 10),
            titleValue.topAnchor.constraint(equalTo: stackView.topAnchor, constant: (stackView.frame.height / 2))
        ])
        
        addSubview(subTitle)
        NSLayoutConstraint.activate([
            subTitle.leftAnchor.constraint(equalTo: myImageView.rightAnchor, constant: 10),
            subTitle.topAnchor.constraint(equalTo: titleValue.bottomAnchor, constant: 0)
        ])
    }
    
//    public func configure(category: ChallengeStart){
//        myImageView.image = UIImage(named: category.imageName)
//        title.text = category.title
//        subTitle.text = category.subTitle
//    }
    
    public func configure(challenge: Challenge) {
        titleValue.text = challenge.title
        subTitle.text =  String(challenge.subtitle)
        
        print(challenge.title, challenge.subtitle)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleValue.text = nil
        myImageView.image = nil
    }
}
