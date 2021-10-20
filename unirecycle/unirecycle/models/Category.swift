//
//  Category.swift
//  unirecycle
//
//  Created by Daron on 12/03/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import UIKit

class Category {

    var id: String = UUID().uuidString
    var name: String
    var imageUrl: String
    var darkHex: String
    var lightHex: String
    var challenges: [Challenge]
    
    init(name: String, imageUrl: String, challenges: [Challenge], darkHex: String, lightHex: String) {
        self.name = name
        self.imageUrl = imageUrl
        self.challenges = challenges
        self.darkHex = darkHex
        self.lightHex = lightHex
    }
}
