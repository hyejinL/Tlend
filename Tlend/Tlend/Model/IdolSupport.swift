//
//  IdolSupport.swift
//  Tlend
//
//  Created by KanghoonOh on 2018. 11. 19..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import Foundation

struct IdolSupport: Codable {
    let banner: Banner
    let support: [Support]
}

struct Support: Codable {
    let supportIdx: Int
    let supportTitle: String
    let userNickname: String
    let imageKey: String
    let dDay: Int
    let percent: Int
    
    enum CodingKeys: String, CodingKey {
        case supportIdx = "support_idx"
        case supportTitle = "support_title"
        case userNickname = "user_nickname"
        case imageKey = "image_key"
        case dDay = "D_day"
        case percent
    }
}
