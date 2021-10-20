//
//  Button.swift
//  unirecycle
//
//  Created by Bob Broersen on 09/02/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import Foundation
import UIKit

class Button: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.blue
        layer.cornerRadius = 8
        titleLabel?.font = UIFont(name: "Roboto-Regular", size: 14)
        setTitleColor(.black, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
