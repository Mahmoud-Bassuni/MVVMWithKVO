//
//  RepoModel.swift
//  Raye7TaskTests
//
//  Created by Bassuni on 5/31/19.
//  Copyright © 2019 Bassuni. All rights reserved.
//

import XCTest
class RepoModelTest: XCTestCase {

    func test_Successful_Init_Repo_Model() {
        let testSuccessfulJSON: JSON = ["name": "ahmed",
                                        "html_url": "www.google.com",
                                        "description": "big app",
                                        "language" : "Swift",
                                        "createdAt" : "1-1-2000",
                                        "forks_count": 12]
        XCTAssertNotNil(RepositoryElement(json: testSuccessfulJSON))
    }
}

private extension RepositoryElement {
    init?(json: JSON) {
        guard let name = json["name"] as? String,
            let html_url = json["html_url"] as? String,
            let description = json["description"] as? String,
              let language = json["language"] as? String,
              let createdAt = json["createdAt"] as? String,

            let forks_count = json["forks_count"] as? Int else {
                return nil
        }
        self.name = name
        self.htmlURL = html_url
        self.reposCodableModelDescription = description
        self.forksCount = forks_count
        self.language = language
        self.createdAt = createdAt
        self.owner = Owner(avatarURL: "www.imag.png")

    }
}
typealias JSON = Dictionary<String, Any>
