//
//  DataModel.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 18..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import Foundation

struct DataModel<T: Codable>: Codable {
    let message: String
    let data: T
}
