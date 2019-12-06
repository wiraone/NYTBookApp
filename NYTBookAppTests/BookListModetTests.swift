//
//  BookListModetTests.swift
//  NYTBookAppTests
//
//  Created by wirawan on 6/12/19.
//  Copyright © 2019 wirawan. All rights reserved.
//

import XCTest
@testable import NYTBookApp

class BookListModelDelegateMock: NSObject, BookListModelDelegate {
    public var books:[Book] = []
    func didFetchBooks(success: Bool, books: [Book]) {
        self.books = books;
    }
}

class BookListModelTests: XCTestCase {
    var bookCoreDataParser = BookCoreDataParser()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
         bookCoreDataParser.deleteAllBookOnCoreData()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchingBookFromNetworkLayer() {
        let book: [[String: Any]] = [["title": "LOOK ALIVE TWENTY-FIVE", "author": "Janet Evanovich", "publisher": "Eidos", "rank": 1, "description": "Book number one", "book_image": "https://s1.nyt.com/du/books/images/9780399179235.jpg"]]
        let mockedBookData: [String: Any] = ["books": book]
        let networkLayerMock = NetworkLayerMock(mockedData:  ["results" : mockedBookData])
        let booklistModel = BookListModel(networkLayer: networkLayerMock)
        let bookListModelDelegateMock = BookListModelDelegateMock()
        booklistModel.delegate = bookListModelDelegateMock
        booklistModel.fetchBookFromAPI()

        XCTAssertTrue(bookListModelDelegateMock.books.count == 1, "Failed to return the expected count of book")

        let firstBook = bookListModelDelegateMock.books[0]

        // Asserting on books values
        XCTAssertTrue(firstBook.name == "LOOK ALIVE TWENTY-FIVE", "failed to parse first book name")
        XCTAssertTrue(firstBook.author == "Janet Evanovich", "failed to parse first book author")
    }

}
