//
//  BookListModel.swift
//  NYTBookApp
//
//  Created by wirawan on 5/12/19.
//  Copyright © 2019 wirawan. All rights reserved.
//

import Foundation

protocol BookListModelDelegate : AnyObject {
    func didFetchBooks(success:Bool, books:[Book])
}

open class BookListModel {
    weak var delegate: BookListModelDelegate?
    private let networkLayer: Network

    init(networkLayer:Network) {
        self.networkLayer = networkLayer
    }

    func fetchBookFromCoreData() {
        let bookCoreDataParser = BookCoreDataParser()
        let books = bookCoreDataParser.getBookFromCoreData()
        if let delegate = self.delegate {
            delegate.didFetchBooks(success: true, books: books)
            return
        }
    }

    /**
        AFTER LOAD DATA FROM API STORE TO CORE DATA
     */

    func fetchBookFromAPI() {
        self.networkLayer.executeGETRequest(api: "/lists/2018-12-01/hardcover-fiction.json?api-key=e6KgPoesflp7DH5ZZ3M2l8Oh4OlOSchv", completionBlock: { (data) in
            if let booksData = data {
                let bookParser = BookParser()
                let books = bookParser.parseBooks(data: booksData)
               
                let bookCoreDataParser = BookCoreDataParser()
                bookCoreDataParser.storeBookToCoreData(books: books)

                if let delegate = self.delegate {
                    delegate.didFetchBooks(success: true, books: books)
                    return
                }
            }

            if let delegate = self.delegate {
                delegate.didFetchBooks(success: false, books: [])
                return
            }
        })
    }

    /**
        IF NO DATA ON CORE DATA LOAD FROM API
     */
    open func fetchBooks() {
        let bookCoreDataParser = BookCoreDataParser()
        let books = bookCoreDataParser.getBookFromCoreData()

        if books.count == 0 {
            self.fetchBookFromAPI()
        }
        else {
            self.fetchBookFromCoreData()
        }
    }

    open func refreshTable() {
        let bookCoreDataParser = BookCoreDataParser()
        bookCoreDataParser.deleteAllBookOnCoreData()
    }
}
