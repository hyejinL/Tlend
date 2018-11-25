//
//  IdolReward.swift
//  Tlend
//
//  Created by KanghoonOh on 2018. 11. 19..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import Foundation

struct IdolReward: Codable {
    let banner: RewardBanner
    let reward: [Reward]
}

struct RewardBanner: Codable {
    let rewardBannerIdx: Int
    let bannerImage: String
    
    enum CodingKeys: String, CodingKey {
        case rewardBannerIdx = "reward_banner_idx"
        case bannerImage
    }
}

struct Reward: Codable, Item {
    var idolID: Int
    var index: Int
    var title, userNickname: String
    var imageKey: String
    var dDay, percent: Int
    
    enum CodingKeys: String, CodingKey {
        case idolID = "idol_idx"
        case index = "reward_idx"
        case title = "reward_title"
        case userNickname = "user_nickname"
        case imageKey = "image_key"
        case dDay = "D_day"
        case percent
    }
}
