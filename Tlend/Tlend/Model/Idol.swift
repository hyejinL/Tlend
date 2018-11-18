//
//  Idol.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 19..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import Foundation

struct Idol: Codable {
    let idolIdx: Int
    let idolName: String
    let idolCompany: String?
    let imageKey: String?
    let groupTitleImg: String?
    
    enum CodingKeys: String, CodingKey {
        case idolIdx = "idol_idx"
        case idolName = "idol_name"
        case imageKey = "image_key"
        case idolCompany = "idol_company"
        case groupTitleImg = "group_titleImg"
    }
}

struct IdolMember: Codable {
    let memberName: String
    let memberIdx: Int
    let memberImgKey: String
    
    enum CodingKeys: String, CodingKey {
        case memberName = "member_name"
        case memberIdx = "member_idx"
        case memberImgKey = "member_imgKey"
    }
}
