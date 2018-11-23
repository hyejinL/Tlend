//
//  DetailService.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 19..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import Foundation
import SwiftyJSON

enum DetailType: String {
    case reward
    case support
    
    var text: String {
        switch self {
        case .support:
            return "서포트"
        case .reward:
            return "배송"
        }
    }
}

enum DetailInfoType {
    case `default`
    case detail
}

struct DetailService: APIService, DecodingService {
    static let shared = DetailService()
    
    public func getSupportDetail(_ starIdx: Int,
                                 detailIdx: Int,
                                 completion: @escaping (Result<Detail<SupportCommon, SupportDefault>>) -> Void) {
        let URL = url("idol/\(starIdx)/support/\(detailIdx)")
        
        NetworkService.shared.request(URL) { (result) in
            switch result {
            case .success(let data):
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                completion(self.decodeJSONData(Detail<SupportCommon, SupportDefault>.self,
                                               dateFormatter: formatter, data: data))
            case .error(let err):
                completion(.error(err))
            }
        }
        
    }
    
    public func getRewardDetail(_ starIdx: Int,
                                 detailIdx: Int,
                                 completion: @escaping (Result<Detail<RewardCommon, RewardDefault>>) -> Void) {
        let URL = url("idol/\(starIdx)/reward/\(detailIdx)")
        
        NetworkService.shared.request(URL) { (result) in
            switch result {
            case .success(let data):
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                completion(self.decodeJSONData(Detail<RewardCommon, RewardDefault>.self,
                                               dateFormatter: formatter, data: data))
            case .error(let err):
                completion(.error(err))
            }
        }
        
    }
    
    public func fundingStart(_ type: DetailType,
                             itemIdx: Int,
                             price: Int,
                             completion: @escaping (Result<String>) -> Void) {
        let params = [
            "itemPrice" : price
        ]
        
        NetworkService.shared.request(url("\(type.rawValue)/\(itemIdx)/fund"),
                                      method: .post, parameters: params) { (result) in
                                        switch result {
                                        case .success(let data):
                                            
                                            completion(.success(JSON(data)["message"].string ?? ""))
                                        case .error(let err):
                                            completion(.error(err))
                                        }
        }
    }
}
