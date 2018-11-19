//
//  UserIdx.swift
//  Tlend
//
//  Created by KanghoonOh on 2018. 11. 18..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import Foundation

struct UserIdx: Codable {
    var userIDX: Int
    
    enum CodingKeys: String, CodingKey {
        case userIDX = "user_idx"
    }
}
