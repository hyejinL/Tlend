//
//  IdolService.swift
//  Tlend
//
//  Created by KanghoonOh on 2018. 11. 19..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import Foundation

struct IdolService: APIService, DecodingService {
    
    static let shared = IdolService()

    public func getSupportData(idolIdx: Int, completion: @escaping (Result<IdolSupport>) -> Void) {
        NetworkService.shared.request(url("idol/\(idolIdx)/support")) { (result) in
            switch result {
            case .success(let data):
                completion(self.decodeJSONData(IdolSupport.self, data: data))
            case .error(let err):
                completion(.error(err))
            }
        }
    }
    
    public func getRewardData(idolIdx: Int, completion: @escaping (Result<IdolReward>) -> Void) {
        NetworkService.shared.request(url("idol/\(idolIdx)/reward")) { (result) in
            switch result {
            case .success(let data):
                completion(self.decodeJSONData(IdolReward.self, data: data))
            case .error(let err):
                completion(.error(err))
            }
        }
    }
}
