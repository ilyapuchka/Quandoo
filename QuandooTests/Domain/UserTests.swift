//
//  UserTests.swift
//  QuandooTests
//
//  Created by Ilya Puchka on 12/10/2017.
//  Copyright © 2017 Ilya Puchka. All rights reserved.
//

import XCTest
import Rswift
@testable import Quandoo

class UserTests: XCTestCase {
    
    func testThatItCanDecodeUser() throws {
        let data = try Data(resource: R.file.userJson)
        let user = try JSONDecoder().decode(User.self, from: data)
        XCTAssertEqual(user.id, 1)
        XCTAssertEqual(user.name, "Leanne Graham")
        XCTAssertEqual(user.username, "Bret")
        XCTAssertEqual(user.email, "Sincere@april.biz")
        XCTAssertEqual(user.address.street, "Kulas Light")
        XCTAssertEqual(user.address.suite, "Apt. 556")
        XCTAssertEqual(user.address.city, "Gwenborough")
        XCTAssertEqual(user.address.zipcode, "92998-3874")
    }
    
}
