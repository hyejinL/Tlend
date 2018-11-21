//
//  Search.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 21..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import Foundation


protocol Item {
    var index: Int { set get }
    var title: String { set get }
    var userNickname: String { set get }
    var imageKey: String { set get }
    var dDay: Int { set get }
    var percent: Int { set get }
}

struct SearchSupportList: Codable {
    var itemList: [Support]
    
    enum CodingKeys: String, CodingKey {
        case itemList = "supportItemList"
    }
}

struct SearchRewardList: Codable {
    var itemList: [Reward]
    
    enum CodingKeys: String, CodingKey {
        case itemList = "rewardItemList"
    }
}
