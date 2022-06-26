//
//  FetchImageTests.swift
//  GDCTests
//
//  Created by Mac on 18/06/22.
//  Copyright © 2022 Mac. All rights reserved.
//

import XCTest
@testable import GDC
class FetchImageTests: XCTestCase {
    let sut = FetchImageVC()
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIncreaseButton() {
        sut.loadViewIfNeeded()
        sut.count = 0
        XCTAssertEqual(sut.count, 0)
        sut.increaseBtn.sendActions(for: .touchUpInside)
//        sut.increaseCount.sendActions(for: .touchUpInside)
        XCTAssertEqual(sut.count, 1)
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
