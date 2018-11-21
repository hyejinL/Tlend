//
//  SearchService.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 21..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import Foundation

struct SearchService: APIService, DecodingService {
    static let shared = SearchService()
    
    public func searchSupportGoods(_ type: DetailType, text: String, completion: @escaping (Result<SearchSupportList>) -> Void) {
        let params = [
            "query" : text
        ]
        
        NetworkService.shared.request(url("search/\(type.rawValue)"), parameters: params) { (result) in
            switch result {
            case .success(let data):
                completion(self.decodeJSONData(SearchSupportList.self, data: data))
            case .error(let err):
                completion(.error(err))
            }
        }
    }
    
    public func searchRewardGoods(_ type: DetailType, text: String, completion: @escaping (Result<SearchRewardList>) -> Void) {
        let params = [
            "query" : text
        ]
        
        NetworkService.shared.request(url("search/\(type.rawValue)"), parameters: params) { (result) in
            switch result {
            case .success(let data):
                completion(self.decodeJSONData(SearchRewardList.self, data: data))
            case .error(let err):
                completion(.error(err))
            }
        }
    }
}
