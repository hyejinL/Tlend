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

struct Reward: Codable {
    let rewardIdx: Int
    let rewardTitle, userNickname: String
    let imageKey: String
    let dDay, percent: Int
    
    enum CodingKeys: String, CodingKey {
        case rewardIdx = "reward_idx"
        case rewardTitle = "reward_title"
        case userNickname = "user_nickname"
        case imageKey = "image_key"
        case dDay = "D_day"
        case percent
    }
}
