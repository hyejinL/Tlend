//
//  HomeService.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 18..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import Foundation

struct HomeService: APIService, DecodingService {
    static let shared = HomeService()
    
    public func getHomeData(completion: @escaping (Result<Home>) -> Void) {
        let params = [
            "user_idx" : "10"
        ]
        
        NetworkService.shared.request(url("home"), headers: params) { (result) in
            switch result {
            case .success(let data):
                completion(self.decodeJSONData(Home.self, data: data))
            case .error(let err):
                completion(.error(err))
            }
        }
    }
}
