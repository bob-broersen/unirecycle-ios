//
//  Label.swift
//  unirecycle
//
//  Created by Emre Efe on 18/04/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import Foundation
import UIKit

class Label: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Label {
    func setSize(size: CGFloat){
        font = UIFont(name: "Roboto-Regular", size: size)
    }
}
