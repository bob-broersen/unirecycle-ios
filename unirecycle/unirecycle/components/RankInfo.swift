//
//  RankInfo.swift
//  unirecycle
//
//  Created by Emre Efe on 20/04/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import Foundation
import UIKit

class RankInfo: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .vertical
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RankInfo {
    func setAttributes(){
        let name = UILabel()
        let amountOfCoins = UILabel()
        let coins = UIImageView()
        
        name.text = "name"
        amountOfCoins.text = "amount"
        coins.image = UIImage(named: "Sustainable-coin")
        backgroundColor = .black
        
        addArrangedSubview(amountOfCoins)
        addSubview(coins)
        addArrangedSubview(name)

        
        NSLayoutConstraint.activate([
            coins.leftAnchor.constraint(equalTo: amountOfCoins.rightAnchor),
    ])
        
    }
}
