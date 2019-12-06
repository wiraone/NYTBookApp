//
//  BookCoreDataParser.swift
//  NYTBookApp
//
//  Created by wirawan on 6/12/19.
//  Copyright © 2019 wirawan. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class BookCoreDataParser: NSObject {
    
    func storeBookToCoreData(books: [Book]) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Books", in: context)

        for book in books {

            if isBookNameExist(bookName: book.name ?? "") == false {
                let newBook = NSManagedObject(entity: entity!, insertInto: context)
                newBook.setValue(book.name, forKey: "name")
                newBook.setValue(book.author, forKey: "author")
                newBook.setValue(book.publisher, forKey: "publisher")
                newBook.setValue(book.rank, forKey: "rank")
                newBook.setValue(book.imageURL, forKey: "imageURL")
                newBook.setValue(book.desc, forKey: "desc")

                do {
                    try context.save()
                } catch {
                    print("Failed saving")
                }
            }
        }
    }

    func isBookNameExist(bookName: String) -> Bool {
        var isExist = false
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Books")
        request.predicate = NSPredicate(format: "name == %@", bookName)
        request.returnsObjectsAsFaults = false

        do {
            let result = try context.fetch(request)
            isExist = result.count > 0
        } catch {
            print("Failed")
        }
        return isExist
    }

    func getBookFromCoreData() -> [Book] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Books")
        request.returnsObjectsAsFaults = false
        var bookList:[Book] = []

        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let storedBook = book(data: data)
                bookList.append(storedBook)
            }
        } catch {
            print("Failed")
        }
        return bookList
    }

    func deleteAllBookOnCoreData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Books")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                context.delete(objectData)
            }
        } catch let error {
            print("Detele all data in Books error :", error)
        }
    }

    private func book(data: NSManagedObject) -> Book {
        let book = Book()
        book.name = data.value(forKey: "name") as? String
        book.author = data.value(forKey: "author") as? String
        book.publisher = data.value(forKey: "publisher") as? String
        book.desc = data.value(forKey: "desc") as? String
        book.rank = data.value(forKey: "rank") as? Int
        book.imageURL = data.value(forKey: "imageURL") as? String
        return book
    }
}
