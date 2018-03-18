//
//  Episode+CoreDataProperties.swift
//  
//
//  Created by Gabriel Cavalcante on 18/03/2018.
//
//

import Foundation
import CoreData


extension Episode {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Episode> {
        return NSFetchRequest<Episode>(entityName: "Episode")
    }

    @NSManaged public var id: String?
    @NSManaged public var image: NSData?
    @NSManaged public var imageUrl: String?
    @NSManaged public var name: String?
    @NSManaged public var number: String?
    @NSManaged public var season: String?
    @NSManaged public var summary: String?
    @NSManaged public var url: String?
    @NSManaged public var relationship: Show?

}
