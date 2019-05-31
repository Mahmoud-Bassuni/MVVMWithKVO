//
//  RepositoryEnum.swift
//  Raye7Task
//
//  Created by Bassuni on 5/28/19.
//  Copyright © 2019 Bassuni. All rights reserved.
//

import Foundation
import Moya

enum RepositoryEnum
{
    case getAllRepositories(page: Int)
}
extension RepositoryEnum : TargetType{
    var baseURL: URL {
        return URL(string: baseUrl)!
    }
    var path: String {
        switch self{
        case .getAllRepositories : return getRepositoriesURL
        }
    }
    var method: Moya.Method {
        switch self {
        case .getAllRepositories : return .get
        }
    }
    var sampleData: Data {
        return Data()
    }
    var task: Task {
        switch self {
        case let .getAllRepositories(page):
            return .requestParameters(parameters:  ["page": page , "per_page" :20], encoding: URLEncoding.queryString)
        }
    }
    var headers: [String : String]?{
        return ["Content-Type" : "application/json"]
    }
}
// confirm cache
extension RepositoryEnum: MoyaCacheable {
    var cachePolicy: MoyaCacheablePolicy {
    return .returnCacheDataElseLoad
    }
}
final class MoyaCacheablePlugin: PluginType {
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        if let moyaCachableProtocol = target as? MoyaCacheable {
            var cachableRequest = request
            cachableRequest.cachePolicy = moyaCachableProtocol.cachePolicy
            return cachableRequest
        }
        return request
    }
}
