//
//  AddressTests.swift
//  QuandooTests
//
//  Created by Ilya Puchka on 12/10/2017.
//  Copyright © 2017 Ilya Puchka. All rights reserved.
//

import XCTest
import Rswift
@testable import Quandoo

class AddressTests: XCTestCase {
    
    func testThatItCanDecodeAddress() throws {
        let data = try Data(resource: R.file.addressJson)
        let address = try JSONDecoder().decode(Address.self, from: data)
        XCTAssertEqual(address.street, "Kulas Light")
        XCTAssertEqual(address.suite, "Apt. 556")
        XCTAssertEqual(address.city, "Gwenborough")
        XCTAssertEqual(address.zipcode, "92998-3874")
    }
    
}
