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

struct Support: Codable, Item {
    var idolID: Int
    var index: Int
    var title: String
    var userNickname: String
    var imageKey: String
    var dDay: Int
    var percent: Int
    
    enum CodingKeys: String, CodingKey {
        case idolID = "idol_idx"
        case index = "support_idx"
        case title = "support_title"
        case userNickname = "user_nickname"
        case imageKey = "image_key"
        case dDay = "D_day"
        case percent
    }
}
