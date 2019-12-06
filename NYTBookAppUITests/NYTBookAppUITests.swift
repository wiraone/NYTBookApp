//
//  NYTBookAppUITests.swift
//  NYTBookAppUITests
//
//  Created by wirawan on 3/12/19.
//  Copyright © 2019 wirawan. All rights reserved.
//

import XCTest
import Swifter

class NYTBookAppUITests: XCTestCase {

    let app = XCUIApplication()
    let dynamicStubs = HTTPDynamicStubs()

    override func setUp() {
        continueAfterFailure = false
        dynamicStubs.setUp()
        app.launchEnvironment = ["BASEURL" : "http://localhost:8080", "isUITest":"true"]
        continueAfterFailure = false
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        dynamicStubs.tearDown()
    }

    func testShowingBookNameAndAuthorName() {
        dynamicStubs.setupStub(url: "/lists/2018-12-01/hardcover-fiction.json?api-key=e6KgPoesflp7DH5ZZ3M2l8Oh4OlOSchv", filename: "book", method: .GET)
        app.launch()

        let tablesQuery = app.tables

        // Assert on first book
        XCTAssertTrue(tablesQuery.cells.staticTexts["LOOK ALIVE TWENTY-FIVE"].exists, "Failure: did not show the first book name.")
        XCTAssertTrue(tablesQuery.cells.staticTexts["Janet Evanovich"].exists, "Failure: did not show the first book author.")

        tablesQuery.cells.element(boundBy: 0).tap();

        // Assert on first book
        XCTAssertTrue(tablesQuery.cells.staticTexts["LOOK ALIVE TWENTY-FIVE"].exists, "Failure: did not show the first book name.")
        XCTAssertTrue(tablesQuery.cells.staticTexts["Janet Evanovich"].exists, "Failure: did not show the first book author.")
    }
}
