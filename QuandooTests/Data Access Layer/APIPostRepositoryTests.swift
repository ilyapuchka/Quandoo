//
//  APIPostRepositoryTests.swift
//  QuandooTests
//
//  Created by Ilya Puchka on 12/10/2017.
//  Copyright © 2017 Ilya Puchka. All rights reserved.
//

import XCTest
import Rswift
@testable import Quandoo

class APIPostRepositoryTests: XCTestCase {
    
    func testThatItCanGetPostsByUserId() throws {
        let networkSession = FileNetworkSession()
        let data = try Data(resource: R.file.postJson)
        let post = try JSONDecoder().decode(Post.self, from: data)
        networkSession.responses = [.postsRequest(userId: 1): [post]]
        
        let sut = APIPostRepository(networkSession: networkSession)
        
        let expectPosts = expectation(description: "Received posts")
        sut.getPosts(withUserId: 1) { (posts, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(posts)
            XCTAssertEqual(posts?.count, 1)
            
            expectPosts.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
        
        let expectNoPosts = expectation(description: "Received no posts")
        sut.getPosts(withUserId: 0) { (posts, error) in
            XCTAssertNil(posts)
            expectNoPosts.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)

    }
    
}
