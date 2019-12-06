//
//  BookParser.swift
//  NYTBookApp
//
//  Created by wirawan on 5/12/19.
//  Copyright © 2019 wirawan. All rights reserved.
//

import Foundation

public class BookParser: NSObject {
    private func book(data: [String: Any]) -> Book {
        let book = Book()
        book.name = data["title"] as? String
        book.author = data["author"] as? String
        book.publisher = data["publisher"] as? String
        book.desc = data["description"] as? String
        book.rank = data["rank"] as? Int
        book.imageURL = data["book_image"] as? String
        return book
    }

    func parseBooks(data:Data) -> [Book] {
        do {
            var bookList:[Book] = []
            if let json = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [String: Any] {
                if let results = json["results"] as? [String: Any] {
                    if let books = results["books"] as? [[String: Any]] {

                        for object in books {
                            let newBook = book(data: object)
                            bookList.append(newBook)
                        }
                    }
                }
                return bookList
            } else {
                return []
            }
        } catch let error as NSError {
            print(error)
        }
        return []
    }

}
