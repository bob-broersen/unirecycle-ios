//
//  CompletedChallengeModel.swift
//  unirecycle
//
//  Created by Bob Broersen on 19/05/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import Foundation
import Firebase


class CompletedChallengeModel: Challenge {

    var category: Category
    var endDate: NSDate

    init(id: String, title: String, subtitle: String, imageUrl: String, value: Int, co2: Int, waste: Int, category: Category, endDate: NSDate) {
        
        self.category = category
        self.endDate = endDate
        
        super.init(id: id, title: title, subtitle: subtitle, imageUrl: imageUrl, value: value, co2: co2, waste: waste)
    }
}

