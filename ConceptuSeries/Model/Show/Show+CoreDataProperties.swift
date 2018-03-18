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
    @NSManaged public var imageUrl: String?
    @NSManaged public var language: String?
    @NSManaged public var name: String?
    @NSManaged public var rating: Double
    @NSManaged public var runtime: String?
    @NSManaged public var scheduleTime: NSDate?
    @NSManaged public var summary: String?
    @NSManaged public var type: String?
    @NSManaged public var url: String?
    @NSManaged public var episodes: NSSet?
    @NSManaged public var favorite: Favorites?

}

// MARK: Generated accessors for episodes
extension Show {

    @objc(addEpisodesObject:)
    @NSManaged public func addToEpisodes(_ value: Episode)

    @objc(removeEpisodesObject:)
    @NSManaged public func removeFromEpisodes(_ value: Episode)

    @objc(addEpisodes:)
    @NSManaged public func addToEpisodes(_ values: NSSet)

    @objc(removeEpisodes:)
    @NSManaged public func removeFromEpisodes(_ values: NSSet)

}
