//
//  MoyaCacheable.swift
//  Raye7Task
//
//  Created by Bassuni on 5/29/19.
//  Copyright © 2019 Bassuni. All rights reserved.
//

import Foundation
protocol MoyaCacheable {
    typealias MoyaCacheablePolicy = URLRequest.CachePolicy
    var cachePolicy: MoyaCacheablePolicy { get }
}
