//
//  Detail.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 19..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import Foundation

struct Detail<DetailData: Codable>: Codable {
    let itemImages: [ItemImage]
    let itemDetail: [DetailData]
    
    enum CodingKeys: String, CodingKey {
        case itemImages = "item_images"
        case itemDetail = "item_detail"
    }
}

struct ItemImage: Codable {
    let imageKey: String
    
    enum CodingKeys: String, CodingKey {
        case imageKey = "image_key"
    }
}

struct SupportDetail: Codable {
    let supportTitle: String
    let supportDescription: String?
    let supportCurrentMoney: Int
    let supportGoalMoney: Int?
    let supportFinishDate, supportStartDate: Date?
    let supportSchedule: String
    let dDay, percent: Int
    let optionName: String
    let lowPrice: Int
    
    enum CodingKeys: String, CodingKey {
        case supportTitle = "support_title"
        case supportDescription = "support_description"
        case supportCurrentMoney = "support_currentMoney"
        case supportGoalMoney = "support_goalMoney"
        case supportFinishDate = "support_finishDate"
        case supportStartDate = "support_startDate"
        case supportSchedule = "support_schedule"
        case dDay = "D_day"
        case percent
        case optionName = "option_name"
        case lowPrice
    }
}

struct RewardDetail: Codable {
    let rewardTitle: String
    let rewardDescription: String?
    let rewardCurrentMoney: Int
    let rewardGoalMoney: Int?
    let rewardFinishDate, rewardStartDate: Date?
    let rewardShipping: Int?
    let rewardSchedule: Date
    let dDay, percent: Int
    let optionName: String?
    let lowPrice: Int
    
    enum CodingKeys: String, CodingKey {
        case rewardTitle = "reward_title"
        case rewardDescription = "reward_description"
        case rewardCurrentMoney = "reward_currentMoney"
        case rewardGoalMoney = "reward_goalMoney"
        case rewardFinishDate = "reward_finishDate"
        case rewardStartDate = "reward_startDate"
        case rewardShipping = "reward_shipping"
        case rewardSchedule = "reward_schedule"
        case dDay = "D_day"
        case percent
        case optionName = "option_name"
        case lowPrice
    }
}
