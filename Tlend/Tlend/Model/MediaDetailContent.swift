//
//  MediaDetail.swift
//  Tlend
//
//  Created by KanghoonOh on 2018. 11. 19..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import Foundation

struct MediaDetailContent: Codable {
    let media: DetailMedia
    let itemList: [TlendItem]
}

struct TlendItem: Codable {
    let supportIdx: Int?
    let supportTitle: String?
    let userNickname: String
    let imageKey: String
    let rewardIdx: Int?
    let rewardTitle: String?
    
    enum CodingKeys: String, CodingKey {
        case supportIdx = "support_idx"
        case supportTitle = "support_title"
        case userNickname = "user_nickname"
        case imageKey = "image_key"
        case rewardIdx = "reward_idx"
        case rewardTitle = "reward_title"
    }
}

struct DetailMedia: Codable {
    let mediaIdx: Int
    let detailImage: String
    let videoKey: String
    
    enum CodingKeys: String, CodingKey {
        case mediaIdx = "media_idx"
        case detailImage = "detail_image"
        case videoKey = "video_key"
    }
}
