//
//  Circle.swift
//  unirecycle
//
//  Created by Emre Efe on 20/04/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import Foundation
import UIKit

class Circle: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAttributes(rect: CGRect, color: UIColor){
        frame = rect
        layer.borderWidth = 4
        layer.borderColor = color.cgColor
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
    }
}

