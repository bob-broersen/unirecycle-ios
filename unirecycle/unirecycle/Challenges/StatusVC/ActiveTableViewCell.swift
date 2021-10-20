//
//  ActiveTableViewCell.swift
//  unirecycle
//
//  Created by Daron on 13/05/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import UIKit

class ActiveTableViewCell: UITableViewCell {
    
    static let identifier = "ActiveTableView"

    var parent: UIViewController?

    
    func setChallenge(activeChallenge: ActiveChallengeModel){
        latestChallengeView.setChallenge(challenge: activeChallenge)
    }
    
        let latestChallengeView: ActiveChallenge = {
            let view = ActiveChallenge()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
  

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLatestView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpLatestView(){
   
        
        contentView.addSubview(latestChallengeView)
        NSLayoutConstraint.activate([
            latestChallengeView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            latestChallengeView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            latestChallengeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            latestChallengeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

        ])
    }
        
}
