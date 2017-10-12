//
//  APIUserRepositoryTests.swift
//  QuandooTests
//
//  Created by Ilya Puchka on 12/10/2017.
//  Copyright © 2017 Ilya Puchka. All rights reserved.
//

import XCTest
import Rswift
@testable import Quandoo

class APIUserRepositoryTests: XCTestCase {
    
    func testThatItCanGetUsers() throws {
        let networkSession = FileNetworkSession()
        let data = try Data(resource: R.file.userJson)
        let user = try JSONDecoder().decode(User.self, from: data)
        networkSession.responses = [.usersRequest(): [user]]
        
        let sut = APIUserRepository(networkSession: networkSession)
        
        let expectUsers = expectation(description: "Received users")
        sut.getUsers { (users, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(users)
            XCTAssertEqual(users?.count, 1)
            
            expectUsers.fulfill()
        }

        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
}
