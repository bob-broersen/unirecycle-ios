//
//  PersonCell.swift
//  unirecycle
//
//  Created by Emre Efe on 10/03/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import UIKit

class PersonCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setUpViews()
    }
    
    func setUpViews(){
        addSubview(uiView)
        uiView.addSubview(personRankLabel)
        uiView.addSubview(personImageView)
        uiView.addSubview(personNameLabel)
        uiView.addSubview(amountOfCoinsLabel)
        uiView.addSubview(coinImage)
        setupConstraints()
    }
    
    let uiView: UIView = {
        let uiView = UIView(frame: CGRect(x: 0, y: 0, width: 343, height: 72))
        uiView.layer.cornerRadius = 4
        uiView.layer.shadowColor = UIColor.black.cgColor
        uiView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        uiView.layer.shadowOpacity = 0.2
        uiView.layer.shadowRadius = 4.0
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    let personRankLabel: Label = {
        var label = Label()
        label.setSize(size: 20)
        return label
    }()
    
    let personNameLabel: Label = {
        var label = Label()
        label.setSize(size: 20)
        return label
    }()
    
    let amountOfCoinsLabel: Label = {
        var label = Label()
        label.setSize(size: 16)
        return label
    }()
    
    let personImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let coinImage: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(person: LeaderboardPerson){
        personRankLabel.text = String(person.rank)
        personImageView.image = person.image
        personNameLabel.text = person.title
        amountOfCoinsLabel.text = String(person.coins)
        coinImage.image = UIImage(named: "Sustainable-coin")
        if person.myself == true {
            uiView.backgroundColor = Colors.myselfColor
        } else {
            uiView.backgroundColor = .white
        }
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            
            uiView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            uiView.heightAnchor.constraint(equalToConstant: 70),
            uiView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            uiView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),

            personRankLabel.topAnchor.constraint(equalTo: uiView.topAnchor, constant: 20),
            personRankLabel.leftAnchor.constraint(equalTo: uiView.leftAnchor, constant: 12),
            
            personImageView.centerYAnchor.constraint(equalTo: uiView.centerYAnchor),
            personImageView.leftAnchor.constraint(equalTo: personRankLabel.rightAnchor, constant: 9),
            personImageView.heightAnchor.constraint(equalToConstant: 56),
            personImageView.widthAnchor.constraint(equalToConstant: 56),
            
            personNameLabel.centerYAnchor.constraint(equalTo: uiView.centerYAnchor),
            personNameLabel.leftAnchor.constraint(equalTo: personImageView.rightAnchor, constant: 20),
            personNameLabel.heightAnchor.constraint(equalToConstant: 80),
        
            coinImage.centerYAnchor.constraint(equalTo: uiView.centerYAnchor),
            coinImage.rightAnchor.constraint(equalTo: uiView.rightAnchor, constant: -10),
            coinImage.heightAnchor.constraint(equalToConstant: 14),
            coinImage.widthAnchor.constraint(equalToConstant: 14),
            
            amountOfCoinsLabel.centerYAnchor.constraint(equalTo: uiView.centerYAnchor),
            amountOfCoinsLabel.rightAnchor.constraint(equalTo: coinImage.leftAnchor, constant: -3),
            
            ])
        
    }
}
