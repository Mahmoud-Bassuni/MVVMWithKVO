//
//  RepositoryService.swift
//  Raye7Task
//
//  Created by Bassuni on 5/28/19.
//  Copyright © 2019 Bassuni. All rights reserved.
//

import Foundation
import Moya
struct NetworkAdapter {
    // MoyaCacheablePlugin for cache data for n time and when expire it will fetch from server
    static let provider = MoyaProvider<RepositoryEnum>(plugins: [MoyaCacheablePlugin()])
    static func request(target: RepositoryEnum, success successCallback: @escaping (Response) -> Void, error errorCallback: @escaping (Swift.Error) -> Void, failure failureCallback: @escaping (MoyaError) -> Void) {

        provider.request(target) { (result) in
            switch result {
            case .success(let response):
                if response.statusCode >= 200 && response.statusCode <= 300 {
                    successCallback(response)
                } else {
                    let error = NSError(domain:"https://api.github.com", code:0, userInfo:[NSLocalizedDescriptionKey: "Parsing Error"])
                    errorCallback(error)
                }
            case .failure(let error):
                failureCallback(error)
            }
        }
    }
}
