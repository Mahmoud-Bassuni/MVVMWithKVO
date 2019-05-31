//
//  RepositoriesVMTest.swift
//  Raye7TaskTests
//
//  Created by Bassuni on 5/31/19.
//  Copyright © 2019 Bassuni. All rights reserved.
//

import XCTest
@testable import Raye7Task
class RepositoriesVMTest: XCTestCase {
    var repositoriesVM :  RepositoriesVM!
    var service :  NetworkAdapter!
    override func setUp() {
        service = NetworkAdapter()
    }
    override func tearDown() {
        repositoriesVM = nil
        service = nil
    }
    func test_fetch_data_from_ViewModel_to_bind_it_in_tableview()
    {
        repositoriesVM = RepositoriesVM(_serviceAdapter: service)
        repositoriesVM.delegate = self
    }
}
extension RepositoriesVMTest : RepositoryVMDelegate
{
    // call back after fetch data
    func dataBind() {
        guard  (repositoriesVM.Repositories.first != nil) else {
            XCTFail()
            return
        }
    }
    func showLoading() {
    }

    func hideLoading() {
    }

    func showAlert(messgae: String) {
        print(messgae)
    }
}
