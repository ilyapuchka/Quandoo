//
//  PostTests.swift
//  QuandooTests
//
//  Created by Ilya Puchka on 12/10/2017.
//  Copyright © 2017 Ilya Puchka. All rights reserved.
//

import XCTest
import Rswift
@testable import Quandoo

class PostTests: XCTestCase {
    
    func testThatItCanDecodePost() throws {
        let data = try Data(resource: R.file.postJson)
        let post = try JSONDecoder().decode(Post.self, from: data)
        XCTAssertEqual(post.userId, 5)
        XCTAssertEqual(post.id, 41)
        XCTAssertEqual(post.title, "non est facere")
        XCTAssertEqual(post.body, "molestias id nostrum\nexcepturi molestiae dolore omnis repellendus quaerat saepe\nconsectetur iste quaerat tenetur asperiores accusamus ex ut\nnam quidem est ducimus sunt debitis saepe")
    }
    
}
