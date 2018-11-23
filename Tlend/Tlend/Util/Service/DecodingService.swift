//
//  DecodingService.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 18..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import Foundation
import SwiftyJSON

public typealias DateFormat = JSONDecoder.DateDecodingStrategy

protocol DecodingService {}

extension DecodingService {
    func decodeJSONData<T: Codable>(_ type: T.Type,
                                    dateFormatter: DateFormatter? = nil,
                                    dateDecodingStrategy: JSONDecoder.DateDecodingStrategy? = nil,
                                    data: Data) -> Result<T> {
        let decoder = JSONDecoder()
        do {
            if let dateFormat = dateFormatter {
                decoder.dateDecodingStrategy = .formatted(dateFormat)
            } else if let dateFormat = dateDecodingStrategy {
                decoder.dateDecodingStrategy = dateFormat
            }
            
            let decodeData = try decoder.decode(DataModel<T>.self, from: data)
            return .success(decodeData.data)
        } catch let err {
            if let message = JSON(data)["message"].string {
                return .error(ErrorMessage.errorMessage(message))
            }
            return .error(err)
        }
    }
}
