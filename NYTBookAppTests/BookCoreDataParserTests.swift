//
//  BookCoreDataParserTests.swift
//  NYTBookAppTests
//
//  Created by wirawan on 6/12/19.
//  Copyright © 2019 wirawan. All rights reserved.
//

import XCTest
@testable import NYTBookApp

class BookCoreDataParserTests: XCTestCase {
    var bookCoreDataParser = BookCoreDataParser()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        bookCoreDataParser.deleteAllBookOnCoreData()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBookCoreDataCRUD() {
        let books = bookCoreDataParser.getBookFromCoreData()
        assert(books.count == 0, "No book store at core data")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
