//
//  swift_ui_mvvmTests.swift
//  swift-ui-mvvmTests
//
//  Created by jhseo on 2020/02/06.
//  Copyright © 2020 jhseo. All rights reserved.
//

import XCTest
import Combine
@testable import swift_ui_mvvm

class swift_ui_mvvmTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testAPIService() {
        let expectation = XCTestExpectation(description: "Request Test")

        let cancellable = APIService.searchBook(searchText: "Swift", startIndex: 0, maxResults: 20)
            .sink(receiveValue: { books in
                XCTAssert(books?.items.count == 20)
                expectation.fulfill()
        })
        wait(for: [expectation], timeout: 2)
    }
}
