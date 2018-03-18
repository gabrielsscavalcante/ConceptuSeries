//
//  Show+CoreDataProperties.swift
//  
//
//  Created by Gabriel Cavalcante on 18/03/2018.
//
//

import Foundation
import CoreData


extension Show {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Show> {
        return NSFetchRequest<Show>(entityName: "Show")
    }

    @NSManaged public var days: NSObject?
    @NSManaged public var genres: NSObject?
    @NSManaged public var id: String?
    @NSManaged public var image: NSData?
    @NSManaged public var imageUrl: String?
    @NSManaged public var language: String?
    @NSManaged public var name: String?
    @NSManaged public var rating: Double
    @NSManaged public var runtime: String?
    @NSManaged public var scheduleTime: NSDate?
    @NSManaged public var summary: String?
    @NSManaged public var type: String?
    @NSManaged public var url: String?
    @NSManaged public var favorite: Bool
    @NSManaged public var relationship: NSSet?

}

// MARK: Generated accessors for relationship
extension Show {

    @objc(addRelationshipObject:)
    @NSManaged public func addToRelationship(_ value: Episode)

    @objc(removeRelationshipObject:)
    @NSManaged public func removeFromRelationship(_ value: Episode)

    @objc(addRelationship:)
    @NSManaged public func addToRelationship(_ values: NSSet)

    @objc(removeRelationship:)
    @NSManaged public func removeFromRelationship(_ values: NSSet)

}
