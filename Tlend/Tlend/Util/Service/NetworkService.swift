//
//  NetworkService.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 18..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import Foundation
import Alamofire

struct NetworkService: APIService, DecodingService {
    static let shared = NetworkService()
    
    let manager: SessionManager
    
    init() {
        var headers = Alamofire.SessionManager.defaultHTTPHeaders
        
        headers["Content-Type"] = "application/json"
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = headers
        manager = Alamofire.SessionManager(configuration: configuration)
        manager.adapter = AuthAdapter()
    }
    
    public func request(_ url: String,
                        method: HTTPMethod = .get,
                        parameters: Parameters? = nil,
                        headers: HTTPHeaders? = nil,
                        completion: @escaping (Result<Data>) -> Void) {
        var request: Alamofire.DataRequest?
        if method == .get && parameters != nil {
            request = self.connectGetPrametersRequest(url, parameters: parameters, headers: headers)
        } else {
            request = self.connectRequest(url, method: method, parameters: parameters, headers: headers)
        }
        
        request?.responseData { res in
            switch res.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let err):
                completion(.error(err))
            }
        }
    }
    
    private func connectGetPrametersRequest(_ url: String,
                                           parameters: Parameters? = nil,
                                           headers: HTTPHeaders? = nil) -> Alamofire.DataRequest {
        return manager.request(url, method: .get, parameters: parameters, headers: headers)
    }
    
    private func connectRequest(_ url: String,
                               method: HTTPMethod,
                               parameters: Parameters? = nil,
                               headers: HTTPHeaders? = nil) -> Alamofire.DataRequest {
        return manager.request(url, method: method, parameters: parameters,
                                 encoding: JSONEncoding.default, headers: headers)
    }
    
//    func setUser(completion: @escaping (Result<User>) -> ()) {
//        self.request("") { (result) in
//            switch result {
//            case .success(let data):
//                completion(self.decodeJSONData(User.self, data: data))
//            case .error(let err):
//                completion(.error(err))
//            }
//        }
//    }
}
