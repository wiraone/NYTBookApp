//
//  BookDetailPresenter.swift
//  NYTBookApp
//
//  Created by wirawan on 6/12/19.
//  Copyright © 2019 wirawan. All rights reserved.
//

import Foundation

public class BookDetailPresenter: NSObject {

    private var book: Book?

    init(book: Book?) {
        self.book = book
        super.init()
    }

    func bookName() -> String {
        if let bookName = self.book?.name {
            return bookName
        }
        return ""
    }

    func bookAuthor() -> String {
        if let bookAuthor = book?.author {
            return bookAuthor
        }
        return ""
    }

    func bookDescription() -> String {
        if let bookDescription = book?.desc {
            return bookDescription
        }
        return ""
    }

    func bookPublisher() -> String {
        if let bookPublisher = book?.publisher {
            return bookPublisher
        }
        return ""
    }

    func bookCoverImageURL() -> String {
        if let bookImageURL = book?.imageURL {
            return bookImageURL
        }
        return ""
    }

    func bookRanking() -> Int {
        if let bookRank = book?.rank {
            return bookRank
        }
        return 0
    }
}
