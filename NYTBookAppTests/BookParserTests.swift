//
//  BookParserTests.swift
//  NYTBookAppTests
//
//  Created by wirawan on 6/12/19.
//  Copyright © 2019 wirawan. All rights reserved.
//

import XCTest
@testable import NYTBookApp

class BookParserTests: XCTestCase {
    var bookCoreDataParser = BookCoreDataParser()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
         bookCoreDataParser.deleteAllBookOnCoreData()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testParsingArrayOfBooks() {
        let testBundle = Bundle(for: type(of: self))
        let filePath = testBundle.path(forResource: "book", ofType: "json")
        let fileUrl = URL(fileURLWithPath: filePath!)
        let data = try! Data(contentsOf: fileUrl, options: .uncached)

        let bookParser = BookParser()
        let books = bookParser.parseBooks(data: data)

        XCTAssertTrue(books.count == 15, "Failed to return the expected count of books")

        let firstBook = books[0]

        // Asserting on books values
        XCTAssertTrue(firstBook.name == "LOOK ALIVE TWENTY-FIVE", "failed to parse first book name")
    }

    func testParsingEmptyArrayOfBooks() {
        let dat = try? JSONSerialization.data(withJSONObject: [], options: .prettyPrinted)

        let bookParser = BookParser()
        var books:[Book] = []
        if let data = dat {
            books = bookParser.parseBooks(data: data)
        }

        XCTAssertTrue(books.count == 0, "Failed to return the expected count of books")
    }
}
