//
//  Detail.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 19..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import Foundation

struct Detail<Common: Codable, Default: Codable>: Codable {
    let common: Common
    let itemDetail: ItemImage
    let itemDefault: Default
    
    enum CodingKeys: String, CodingKey {
        case common
        case itemDetail = "item_detail"
        case itemDefault = "item_default"
    }
}

protocol CommonType {
    var itemImages: [ItemImage] { set get }
    var title: String { set get }
    var lowPrice: Int { set get }
    var currentMoney: Int? { set get }
    var dDay: Int { set get }
    var percent: Int { set get }
    var schedule: Date { set get }
}

struct SupportCommon: Codable, CommonType {
    var itemImages: [ItemImage]
    var title: String
    var lowPrice: Int
    var currentMoney: Int?
    var dDay: Int
    var percent: Int
    var schedule: Date
    
    enum CodingKeys: String, CodingKey {
        case itemImages = "item_images"
        case title = "support_title"
        case lowPrice
        case currentMoney = "support_currentMoney"
        case dDay = "D_day"
        case percent, schedule
    }
}

struct RewardCommon: Codable, CommonType {
    var itemImages: [ItemImage]
    var title: String
    var lowPrice: Int
    var currentMoney: Int?
    var dDay: Int
    var percent: Int
    var schedule: Date
    
    enum CodingKeys: String, CodingKey {
        case itemImages = "item_images"
        case title = "reward_title"
        case lowPrice
        case currentMoney = "reward_currentMoney"
        case dDay = "D_day"
        case percent, schedule
    }
}

struct ItemImage: Codable {
    let imageKey: String
    
    enum CodingKeys: String, CodingKey {
        case imageKey = "image_key"
    }
}

protocol ItemDefault {
    var title: String { get set }
//    var description: String? { get set }
    var currentMoney: Int? { get set }
    var goalMoney: Int? { get set }
    var finishDate: Date? { get set }
    var startDate: Date? { get set }
    var schedule: Date { get set }
//    var dDay: Int { get set }
//    var percent: Int { get set }
    var optionName: String { get set }
//    var lowPrice: Int { get set }
    
}

protocol SupportDefaultType: ItemDefault {}

protocol RewardDefaultType: ItemDefault {
    var description: String? { get set }
    var shipping: Int? { get set }
}

struct SupportDefault: Codable, SupportDefaultType {
    
    var title: String
    var currentMoney: Int?
    var goalMoney: Int?
    var finishDate: Date?
    var startDate: Date?
    var schedule: Date
    var optionName: String
    
    enum CodingKeys: String, CodingKey {
        case title = "support_title"
        case currentMoney = "support_currentMoney"
        case goalMoney = "support_goalMoney"
        case finishDate = "support_finishDate"
        case startDate = "support_startDate"
        case schedule = "support_schedule"
        case optionName = "option_name"
    }
}

struct RewardDefault: Codable, RewardDefaultType {
    
    var title: String
    var description: String?
    var currentMoney: Int?
    var goalMoney: Int?
    var finishDate: Date?
    var startDate: Date?
    var shipping: Int?
    var schedule: Date
    var optionName: String
    
    enum CodingKeys: String, CodingKey {
        case title = "reward_title"
        case description = "reward_description"
        case currentMoney = "reward_currentMoney"
        case goalMoney = "reward_goalMoney"
        case finishDate = "reward_finishDate"
        case startDate = "reward_startDate"
        case shipping = "reward_shipping"
        case schedule = "reward_schedule"
        case optionName = "option_name"
    }
}
