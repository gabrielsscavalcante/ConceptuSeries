//
//  Favorites+CoreDataProperties.swift
//  
//
//  Created by Gabriel Cavalcante on 18/03/2018.
//
//

import Foundation
import CoreData


extension Favorites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorites> {
        return NSFetchRequest<Favorites>(entityName: "Favorites")
    }

    @NSManaged public var shows: NSSet?

}

// MARK: Generated accessors for shows
extension Favorites {

    @objc(addShowsObject:)
    @NSManaged public func addToShows(_ value: Show)

    @objc(removeShowsObject:)
    @NSManaged public func removeFromShows(_ value: Show)

    @objc(addShows:)
    @NSManaged public func addToShows(_ values: NSSet)

    @objc(removeShows:)
    @NSManaged public func removeFromShows(_ values: NSSet)

}
