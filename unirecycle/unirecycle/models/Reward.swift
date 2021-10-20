//
//  Reward.swift
//  unirecycle
//
//  Created by Bob Broersen on 02/03/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import Foundation

class Reward {
    var id: String = UUID().uuidString
    var brandName: String
    var imageUrl: String
    var price: Int
    var productDescription: String
    var title: String
    var type: String
    var category: String
    
    init( brandName: String, imageUrl: String, price: Int, productDescription: String, title: String, category: String, type: String) {
        self.brandName = brandName
        self.imageUrl = imageUrl
        self.price = price
        self.productDescription = productDescription
        self.title = title
        self.category = category
        self.type = type
    }
}
