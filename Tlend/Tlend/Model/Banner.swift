//
//  Banner.swift
//  Tlend
//
//  Created by KanghoonOh on 2018. 11. 19..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import Foundation

struct Banner: Codable {
    let supportBannerIdx: Int
    let bannerImage: String
    
    enum CodingKeys: String, CodingKey {
        case supportBannerIdx = "support_banner_idx"
        case bannerImage
    }
}
