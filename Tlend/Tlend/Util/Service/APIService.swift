//
//  APIService.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 18..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import Foundation

// MAKR: - network result type
enum Result<T> {
    case success(T)
    case error(Error)
}

//enum ErrorMessage: String, Error {
//    case connetionError = "connection is failed"
//    case parameterEncodeError = "parameter encode failed"
//    case noResultError = "there is no result"
//}

enum ErrorMessage: Error {
    case connetionError
    case parameterEncodeError
    case errorMessage(String)
}

// MAKR: - APIService : protocol for api
let baseURL: String = "https://tlend.apps.dev.clayon.io/"

protocol APIService {}

extension APIService {
    func url(_ path: String) -> String {
        return baseURL + path
    }
}
