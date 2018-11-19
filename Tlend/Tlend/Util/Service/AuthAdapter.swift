//
//  AuthAdapter.swift
//  Tlend
//
//  Created by KanghoonOh on 2018. 11. 18..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import Foundation
import Alamofire

class AuthAdapter: RequestAdapter {
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.setValue(AuthService.shared.currentToken ?? "",
                            forHTTPHeaderField: "user_idx")
        return urlRequest
    }
}
