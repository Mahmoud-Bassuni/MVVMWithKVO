//
//  Raye7TaskTests.swift
//  Raye7TaskTests
//
//  Created by Bassuni on 5/30/19.
//  Copyright © 2019 Bassuni. All rights reserved.
//

import XCTest
@testable import Raye7Task
class RepositoriesServiceTests: XCTestCase {
    var service :  NetworkAdapter!
    override func setUp() {
        service = NetworkAdapter()
    }
    override func tearDown() {
        service = nil
    }
    func test_Fetch_Repositories_Data() {
        service.request(target: .getAllRepositories(page: 1), success: { Response in
            do
            {
                let decoder = JSONDecoder()
                let getData = try! decoder.decode(RepositoriesCodableModel.self,from: Response.data)
                XCTAssertNotNil(getData)
            }
        }, error: { error in }, failure: { error in })
    }
}
