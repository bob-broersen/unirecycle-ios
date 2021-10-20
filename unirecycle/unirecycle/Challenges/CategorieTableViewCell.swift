//
//  CategorieTableViewCell.swift
//  unirecycle
//
//  Created by Bob Broersen on 03/03/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import UIKit

class CategorieTableViewCell: UITableViewCell {
    var challenge: Challenge?
    
    func setChallenge(challenge: Challenge, category: Category){
        self.challenge = challenge
        title.text = challenge.title
        subTitle.text = challenge.subtitle
        guard let imageUrl:URL = URL(string: challenge.imageUrl) else {
            return
        }
        iconView.load(url: imageUrl)
        coinValue.text = "+" + String(challenge.value ?? 0)
        iconView.backgroundColor = UIColor(hexString: category.lightHex)
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
        imageView.backgroundColor = Colors.pink
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
    
    let subTitle: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 2
        title.lineBreakMode = .byWordWrapping
        return title
    }()
    
    private let infoButton: UIButton = {
        let infoButton = UIButton()
        infoButton.setImage(UIImage(named: images.infoButtonIcon), for: .normal)
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        return infoButton
    }()
    
    let coinView: UIView  = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let coinImage: UIImageView = {
        let image = UIImage(named: images.coinIcon)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let coinValue: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Bold", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        setupView()
        setupIconView()
        setUpTitle()
        setUpSubTitle()
        setUpInfoButton()
        setUpCoinView()
    }
    
    func setupView(){
        addSubview(view)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            view.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -18)

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
            title.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            title.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -62)
        ])
    }
    
    func setUpSubTitle() {
        view.addSubview(subTitle)
        NSLayoutConstraint.activate([
            subTitle.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 16),
            subTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4),


        ])
    }
    
    func setUpCoinView() {
        coinView.addSubview(coinValue)
        coinView.addSubview(coinImage)
        
        NSLayoutConstraint.activate([
            coinValue.leadingAnchor.constraint(equalTo: coinView.leadingAnchor, constant: 0),
            coinValue.bottomAnchor.constraint(equalTo: coinView.bottomAnchor, constant: 0),
            coinValue.topAnchor.constraint(equalTo: coinView.topAnchor, constant: 0),
            coinImage.trailingAnchor.constraint(equalTo: coinView.trailingAnchor, constant: 0),
            coinImage.bottomAnchor.constraint(equalTo: coinView.bottomAnchor, constant: 0),
            coinImage.topAnchor.constraint(equalTo: coinView.topAnchor, constant: 0),
        ])
        
        view.addSubview(coinView)
        NSLayoutConstraint.activate([
            coinView.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 6),
            coinView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            coinView.centerYAnchor.constraint(equalTo: title.centerYAnchor),
        ])
    }
    
    func setUpInfoButton(){
        view.addSubview(infoButton)
        NSLayoutConstraint.activate([
            infoButton.leadingAnchor.constraint(equalTo: subTitle.trailingAnchor, constant: 30),
            infoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            infoButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
        ])
    }

}

extension UILabel {

    var actualFontSize: CGFloat {
    //initial label
     let fullSizeLabel = UILabel()
     fullSizeLabel.font = self.font
     fullSizeLabel.text = self.text
     fullSizeLabel.sizeToFit()

     var actualFontSize: CGFloat = self.font.pointSize * (self.bounds.size.width / fullSizeLabel.bounds.size.width);

    //correct, if new font size bigger than initial
     actualFontSize = actualFontSize < self.font.pointSize ? actualFontSize : self.font.pointSize;

     return actualFontSize
    }

}
