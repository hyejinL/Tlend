//
//  Home.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 18..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import Foundation

struct Home: Codable {
    let mybaby: [String]
    let idolName: [IdolName]
    let media: [Media]
    
    enum CodingKeys: String, CodingKey {
        case mybaby
        case idolName = "idol_name"
        case media
    }
}

struct IdolName: Codable {
    let idolName, idolIdx: String
    
    enum CodingKeys: String, CodingKey {
        case idolName = "idol_name"
        case idolIdx = "idol_idx"
    }
}

struct Media: Codable {
    let mediaIdx: Int
    let mediaTitle: String
    let imageKey: String
    
    enum CodingKeys: String, CodingKey {
        case mediaIdx = "media_idx"
        case mediaTitle = "media_title"
        case imageKey = "image_key"
    }
}

