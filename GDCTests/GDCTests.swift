//
//  GDCTests.swift
//  GDCTests
//
//  Created by Mac on 14/06/22.
//  Copyright © 2022 Mac. All rights reserved.
//

import XCTest
@testable import GDC

class GDCTests: XCTestCase {
let networkManager = MockNetworkManager()
let config = Configuration(url: URL(string: "https://google.com")!)
    
    func testFetchSingleImageApiWithError()  {
        
        networkManager.shouldReturnError = true
        networkManager.fetchSingleImage(config: config, completion: {
            (data, error) in
            XCTAssertNotNil(error)
            return nil
        })
    }
    
    func testFetchSingleImageApiWithSuccessResponse()  {
        let expectation = self.expectation(description: "fetch single image")
        networkManager.fetchSingleImage(config: config, completion: {(data, error) in
            guard let data = data else {
                XCTFail()
                return nil }
            XCTAssert(data.count > 0, "array count is not greater than ")
            expectation.fulfill()
            return nil
        })
        
        self.wait(for: [expectation], timeout: 10.0)
    }
}
