//
//  ContentService.swift
//  Tlend
//
//  Created by KanghoonOh on 2018. 11. 19..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import Foundation

struct ContentService: APIService, DecodingService {
    
    static let shared = ContentService()

    public func getMedia(mediaID: Int, completion: @escaping (Result<MediaDetailContent>) -> Void) {
        NetworkService.shared.request(url("media/\(mediaID)")) { (result) in
            switch result {
            case .success(let data):
                completion(self.decodeJSONData(MediaDetailContent.self, data: data))
            case .error(let err):
                completion(.error(err))
            }
        }
    }
}
