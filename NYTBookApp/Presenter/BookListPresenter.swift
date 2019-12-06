//
//  BookListPresenter.swift
//  NYTBookApp
//
//  Created by wirawan on 5/12/19.
//  Copyright © 2019 wirawan. All rights reserved.
//

import Foundation

protocol BookListPresenterDelegate : AnyObject {
    func didFetchBooks(success:Bool)
}

public class BookListPresenter: NSObject {

    weak var delegate: BookListPresenterDelegate?
    private let bookListModel: BookListModel
    private var books: [Book] = []
    private var page = 1
    private let perPage = 3

    init(bookListModel: BookListModel) {
        self.bookListModel = bookListModel
        super.init()
        self.bookListModel.delegate = self
    }

    public func fetchBooks () {
        self.bookListModel.fetchBooks()
    }

    public func refreshBooksByPullToRefresh () {
        self.bookListModel.refreshTable()
    }

    public func booksCount() -> Int {
        let currentTotalData = self.page * self.perPage
        return currentTotalData < self.books.count ? currentTotalData : self.books.count
    }

    public func loadMoreData() {
        self.page = self.page + 1
    }

    public func isLoadMoreEnable() -> Bool {
        let currentTotalData = self.page * self.perPage
        return currentTotalData < self.books.count ? true : false
    }

    func bookName(index:Int) -> String {
        let book = self.books[index]
        if let bookName = book.name {
            return bookName
        }
        return ""
    }

    func bookAuthor(index:Int) -> String {
        let book = self.books[index]
        if let bookAuthor = book.author {
            return bookAuthor
        }
        return ""
    }

    func bookAt(index:Int) -> Book {
        let book = self.books[index]
        return book
    }
}

extension BookListPresenter : BookListModelDelegate {
    func didFetchBooks(success: Bool, books: [Book]) {
        self.books = books
        if let delegate = self.delegate {
            delegate.didFetchBooks(success: success)
            return
        }
    }
}
