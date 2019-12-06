//
//  Books+CoreDataProperties.swift
//  
//
//  Created by wirawan on 6/12/19.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Books {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Books> {
        return NSFetchRequest<Books>(entityName: "Books")
    }

    @NSManaged public var author: String?
    @NSManaged public var desc: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var name: String?
    @NSManaged public var publisher: String?
    @NSManaged public var rank: Int16

}
