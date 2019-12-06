//
//  NYTBookAppTests.swift
//  NYTBookAppTests
//
//  Created by wirawan on 3/12/19.
//  Copyright © 2019 wirawan. All rights reserved.
//

import XCTest
@testable import NYTBookApp

class ViewControllerMock: NSObject, BookListPresenterDelegate {
    var didFetchBook = false;

    func didFetchBooks(success: Bool) {
        didFetchBook = success
    }
}


class BookListIntegrationTests: XCTestCase {
    var bookCoreDataParser = BookCoreDataParser()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
         bookCoreDataParser.deleteAllBookOnCoreData()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testShowingBookNameAndAuthorName() {
        let book: [[String: Any]] = [["title": "LOOK ALIVE TWENTY-FIVE", "author": "Janet Evanovich", "publisher": "Eidos", "rank": 1, "description": "Book number one", "book_image": "https://s1.nyt.com/du/books/images/9780399179235.jpg"]]
        let mockedBookData: [String: Any] = ["books": book]
        let networkLayer = NetworkLayerMock(mockedData:  ["results" : mockedBookData])
        let bookListModel = BookListModel(networkLayer: networkLayer)
        let bookListPresenter = BookListPresenter(bookListModel: bookListModel)
        let viewControllerMock = ViewControllerMock()
        bookListPresenter.delegate = viewControllerMock
        bookListPresenter.fetchBooks()

        XCTAssertTrue(viewControllerMock.didFetchBook, "Success in fetching books")
        XCTAssertTrue(bookListPresenter.bookName(index:0) == "LOOK ALIVE TWENTY-FIVE", "First book name is not as expected")
        XCTAssertTrue(bookListPresenter.bookAuthor(index:0) == "Janet Evanovich", "First book author is not as expected")
     }

}
