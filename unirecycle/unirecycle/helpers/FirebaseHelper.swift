//
//  FirebaseHelper.swift
//  unirecycle
//
//  Created by Bob Broersen on 14/04/2021.
//  Copyright © 2021 HvA. All rights reserved.
//

import Foundation

class FirebaseHelper {
    private lazy var viewModel = CategoryViewModel()
    

    init() {
        viewModel.fetchCategories()
    }
}
