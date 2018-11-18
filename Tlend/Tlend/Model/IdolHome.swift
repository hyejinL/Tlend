//
//  IdolHome.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 19..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import Foundation

struct IdolHome: Codable {
    let idolGroup: Idol
    let idolMember: [IdolMember]
    let media: [Media]
    
    enum CodingKeys: String, CodingKey {
        case idolGroup = "idol_group"
        case idolMember = "idol_member"
        case media
    }
}
