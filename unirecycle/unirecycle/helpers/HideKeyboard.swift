//
//  HideKeyboard.swift
//  unirecycle
//
//  Created by Bob Broersen on 17/02/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
func dismissKeyboard() {
       let tap: UITapGestureRecognizer = UITapGestureRecognizer( target:     self, action:    #selector(UIViewController.dismissKeyboardTouchOutside))
       tap.cancelsTouchesInView = false
       view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboardTouchOutside() {
       view.endEditing(true)
    }
}
