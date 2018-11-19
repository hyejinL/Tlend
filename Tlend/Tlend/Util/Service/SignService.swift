//
//  SignService.swift
//  Tlend
//
//  Created by KanghoonOh on 2018. 11. 18..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import Foundation

struct SignService: APIService, DecodingService {
    static let shared = SignService()
    
    func signIn(id: String, pw: String, completion: @escaping (Result<UserIdx>) -> Void) {
        let params = [
            "id": id,
            "pw": pw
        ]
        NetworkService.shared.request(url("user/signin"), method: .post, parameters: params) { result in
            switch result {
            case .success(let data):
                completion(self.decodeJSONData(UserIdx.self, data: data))
            case .error(let err):
                completion(.error(err))
            }
        }
    }
    
    func signUp(id: String, pw: String, nickname: String, completion: @escaping (Result<Void>) -> Void) {
        let params = [
            "id": id,
            "pw": pw,
            "nickname": nickname
        ]
        NetworkService.shared.request(url("user/signup"), method: .post, parameters: params) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .error(let err):
                completion(.error(err))
            }
        }
    }
    
    func getIdols(completion: @escaping (Result<Void>) -> Void) {
        NetworkService.shared.request(url("idol"), method: .get) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .error(let err):
                completion(.error(err))
            }
        }
    }
}
