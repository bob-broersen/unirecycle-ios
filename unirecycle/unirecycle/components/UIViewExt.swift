//
//  UIViewExt.swift
//  unirecycle
//
//  Created by Emre Efe on 10/03/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import UIKit

extension UIView {
    
    func pin(to superView: UIView){
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
    }
    
    func pinToTop(to superView: UIView, currentView: UIView, top topView: UIView){
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currentView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 10),
            currentView.leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            currentView.trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            currentView.bottomAnchor.constraint(equalTo: superView.bottomAnchor),
        ])
    }
}
