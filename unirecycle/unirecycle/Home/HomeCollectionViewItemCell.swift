//
//  HomeCollectionViewItemCell.swift
//  unirecycle
//
//  Created by Bob Broersen on 05/05/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import UIKit

struct HomeCollectionViewInfo {
    var title: String
    var value: String
    var withCoin: Bool
}

class HomeCollectionViewItemCell: UICollectionViewCell {
    var info: HomeCollectionViewInfo?
    
    func setInfo(info: HomeCollectionViewInfo){
        self.info = info
        title.text = info.title
        value.text = info.value
        setupViews()

    }
    
    var title: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto", size: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var value: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-bold", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 7
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    var coinImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: images.coinBig)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        setupTitle()
        setupValue()

    }
    
    func setupTitle(){
        contentView.addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            title.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    func setupValue(){
        stackView.addArrangedSubview(value)
        if (info!.withCoin) {
            stackView.addArrangedSubview(coinImage)
        }
        
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 27),
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)

        ])
    }

}
