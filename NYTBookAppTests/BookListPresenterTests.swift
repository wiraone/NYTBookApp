//
//  BookListPresenterTests.swift
//  NYTBookAppTests
//
//  Created by wirawan on 5/12/19.
//  Copyright © 2019 wirawan. All rights reserved.
//

import XCTest
@testable import NYTBookApp

class BookListModelMock: BookListModel {

    private var mockedBooks: [Book] = []

    convenience init(mockedBooks:[Book]) {
        self.init(networkLayer: Network())
        self.mockedBooks = mockedBooks
    }

    override func fetchBooks() {
        if let delegate = self.delegate {
            delegate.didFetchBooks(success: false, books: self.mockedBooks)
            return
        }
    }
}

class BookListPresenterTests: XCTestCase {
    var bookCoreDataParser = BookCoreDataParser()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
         bookCoreDataParser.deleteAllBookOnCoreData()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadingBook() {
        let book = Book()
        book.name = "LOOK ALIVE TWENTY-FIVE"
        book.author = "Janet Evanovich"
        book.publisher = "Eidos"
        book.rank = 1
        book.desc = "Book number one"
        book.imageURL = "https://s1.nyt.com/du/books/images/9780399179235.jpg"

        let bookListModelMock = BookListModelMock(mockedBooks: [book])
        let bookListPresenter = BookListPresenter(bookListModel: bookListModelMock)
        bookListPresenter.fetchBooks()

        XCTAssertTrue(bookListPresenter.bookName(index: 0) == "LOOK ALIVE TWENTY-FIVE", "failed to fetch first book name")
    }
}
