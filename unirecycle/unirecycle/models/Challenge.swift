////
////  Challenge.swift
////  unirecycle
////
////  Created by Bob Broersen on 02/03/2021.
////  Copyright © 2021 HvA. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//protocol Challenge{
//    
//    var title: String { get set }
//    var description: String { get set }
//    var points: Int { get set }
//    var categoryType: Category { get set }
//    var startDate: Date { get set }
//    var endDate: Date { get set }
//    
//    
//    func getPoints() -> Int
//    
//    func getCategoryType() -> Category
//    
//}
//

import Foundation

class Challenge {
    var id: String
    var title: String
    var subtitle: String
    var imageUrl: String
    var value: Int
    var co2: Int
    var waste: Int
    
    init(id: String, title: String, subtitle: String, imageUrl: String, value: Int, co2: Int, waste: Int) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.imageUrl = imageUrl
        self.value = value
        self.co2 = co2
        self.waste = waste
    }
}
