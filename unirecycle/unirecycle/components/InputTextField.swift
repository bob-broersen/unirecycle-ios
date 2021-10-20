//
//  InputTextField.swift
//  unirecycle
//
//  Created by Bob Broersen on 03/02/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import Foundation
import UIKit

enum imagePosition{
    case right
    case left
}

class InputTextField: UITextField {
    let bottomLine = CALayer()
    var padding = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)

    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = .white
        font = UIFont(name: "Roboto-Regular", size: 14)
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height + 10, width: self.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.white.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func overrideLineColor(color: CGColor){
        bottomLine.backgroundColor = color
    }
    
    func paddingLeft(){
        padding.right = 5
        padding.left = 35
    }
    
    func paddingRight(){
        padding.right = 0
        padding.left = 5
    }
    
    func addImage(image: UIImage, imagePosition: imagePosition){
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        switch imagePosition {
        case .left:
            leftViewMode = .always
            leftView = imageView
        case .right:
            rightViewMode = .always
            rightView = imageView
        }
    }
    
    // Provides left padding for images
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += 10
        textRect.origin.y -= 5
        return textRect
    }
    
    // Provides right padding for images
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x -= 10
        textRect.origin.y -= 5
        return textRect
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    
    
}
