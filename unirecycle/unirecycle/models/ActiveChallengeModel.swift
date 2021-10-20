//
//  ActiveChallenge.swift
//  unirecycle
//
//  Created by Daron on 13/05/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import Foundation
import Firebase


class ActiveChallengeModel: Challenge {

    var endDate: NSDate
    var startDate: NSDate
    var daysCompleted: [NSDate]
    
    var category: Category
    
    init(id: String, title: String, subtitle: String, endDate: NSDate, startDate: NSDate, imageUrl: String, value: Int, co2: Int, daysCompleted: [NSDate], waste: Int, category: Category) {
        
        self.category = category
        self.endDate = endDate
        self.startDate = startDate
        self.daysCompleted = daysCompleted
        
        super.init(id: id, title: title, subtitle: subtitle, imageUrl: imageUrl, value: value, co2: co2, waste: waste)
    }
}

