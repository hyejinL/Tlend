//
//  DecodingService.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 18..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import Foundation

public typealias DateFormat = JSONDecoder.DateDecodingStrategy

protocol DecodingService {}

extension DecodingService {
    func decodeJSONData<T: Codable>(_ type: T.Type,
                                    dateFormatter: DateFormat? = nil,
                                    data: Data) -> Result<T> {
        let decoder = JSONDecoder()
        do {
            if let dateFormat = dateFormatter {
                decoder.dateDecodingStrategy = dateFormat
            }
            
            let decodeData = try decoder.decode(DataModel<T>.self, from: data)
            return .success(decodeData.data)
        } catch let err {
            return .error(err)
        }
    }
}
