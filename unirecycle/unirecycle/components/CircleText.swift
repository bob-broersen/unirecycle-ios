//
//  CircleText.swift
//  unirecycle
//
//  Created by Emre Efe on 28/04/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import Foundation
import UIKit

class CircleText: UIView {
    let nameLabel = UILabel()
    let amountLabel = UILabel()
    let coins = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.textColor = Colors.amountColor
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        coins.translatesAutoresizingMaskIntoConstraints = false
        
        coins.image = UIImage(named: "big-coin")
        
        addSubview(amountLabel)
        addSubview(coins)
        addSubview(nameLabel)
        
        coins.leftAnchor.constraint(equalTo: amountLabel.rightAnchor, constant: 5).isActive = true
        coins.centerYAnchor.constraint(equalTo: amountLabel.centerYAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        leftAnchor.constraint(equalTo: amountLabel.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: coins.rightAnchor).isActive = true
        bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        topAnchor.constraint(equalTo:amountLabel.topAnchor).isActive = true
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    func setAttributes(name: String, amount: String){
        amountLabel.text = amount
        nameLabel.text = name
    }
    
    func setFont(size: Int, difference: Int) {
        let amountLabelFont = UIFont(name: "Roboto-Regular", size: CGFloat(size))
        let nameLabelFont = UIFont(name: "Roboto-Regular", size: CGFloat(size - difference))
        amountLabel.font = amountLabelFont
        nameLabel.font = nameLabelFont
    }
    
    func setFirstPlaceFont(size: Int, difference: Int) {
        let amountLabelFont = UIFont(name: "Roboto-Regular", size: CGFloat(size))
        let nameLabelFont = UIFont(name: "Roboto-Bold", size: CGFloat(size - difference))
        amountLabel.font = amountLabelFont
        nameLabel.font = nameLabelFont
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
