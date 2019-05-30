//
//  Raye7TaskTests.swift
//  Raye7TaskTests
//
//  Created by Bassuni on 5/30/19.
//  Copyright © 2019 Bassuni. All rights reserved.
//

import XCTest
@testable import Raye7Task
class Raye7TaskTests: XCTestCase {
    var service :  NetworkAdapter!
    var viewModel : RepositoriesVM!
    override func setUp() {
        service = NetworkAdapter()
        viewModel = RepositoriesVM(_serviceAdapter: service)
    }
    override func tearDown() {
        viewModel = nil
        service = nil
    }
    func testGetAllRepositories() {
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
