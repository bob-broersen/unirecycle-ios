//
//  Badge.swift
//  unirecycle
//
//  Created by Bob Broersen on 02/03/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import Foundation
import UIKit

class Badge: Codable{
    var title: String?
    var description: String?
    var imageUrl: String?
    
    init(title: String, description: String, imageUrl: String) {
        self.title = title
        self.description = description
        self.imageUrl = imageUrl
    }
    
}
