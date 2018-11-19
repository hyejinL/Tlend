//
//  DetailService.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 19..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import Foundation

enum DetailType: String {
    case reward
    case support
    
    var dataType: Codable.Type {
        switch self {
        case .support:
            return SupportDetail.self
        case .reward:
            return RewardDetail.self
        }
    }
}

enum DetailInfoType: String {
    case Default = "default"
    case Detail = "detail"
}

struct DetailService: APIService, DecodingService {
    static let shared = DetailService()
    
    public func getSupportDetail(_ starIdx: Int,
                                 detailIdx: Int,
                                 info type: DetailInfoType,
                                 completion: @escaping (Result<SupportDetail>) -> Void) {
        let URL = url("idol/\(starIdx)/support/\(detailIdx)")
        let params = [
            "option" : type.rawValue
        ]
        
        NetworkService.shared.request(URL, parameters: params) { (result) in
            switch result {
            case .success(let data):
                completion(self.decodeJSONData(SupportDetail.self, dateDecodingStrategy: .iso8601, data: data))
            case .error(let err):
                completion(.error(err))
            }
        }
        
    }
    
    public func getRewardDetail(_ starIdx: Int,
                                 detailIdx: Int,
                                 info type: DetailInfoType,
                                 completion: @escaping (Result<RewardDetail>) -> Void) {
        let URL = url("idol/\(starIdx)/support/\(detailIdx)")
        let params = [
            "option" : type.rawValue
        ]
        
        NetworkService.shared.request(URL, parameters: params) { (result) in
            switch result {
            case .success(let data):
                completion(self.decodeJSONData(RewardDetail.self, dateDecodingStrategy: .iso8601, data: data))
            case .error(let err):
                completion(.error(err))
            }
        }
        
    }
}
