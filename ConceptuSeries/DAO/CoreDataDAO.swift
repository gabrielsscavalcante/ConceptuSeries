//
//  CoreDataDAO.swift
//  ConceptuSeries
//
//  Created by Gabriel Cavalcante on 17/03/2018.
//  Copyright © 2018 Gabriel Cavalcante. All rights reserved.
//

import UIKit
import CoreData

public class CoreDataDAO<Element: NSManagedObject>: DAO {
    
    public var context: NSManagedObjectContext
    
    public init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    public func insert(object: Element) {
        context.insert(object)
        save()
    }
    
    public func delete(object: Element) {
        context.delete(object)
        save()
    }
    
    public func all() -> [Element] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Object.className)
        let result =  try! context.fetch(request) as! [Object]
        return result
    }
    
    private func save() {
        try! context.save()
    }
    
    public func new() -> Element {
        return NSEntityDescription.insertNewObject(forEntityName: Element.className, into: context) as! Element
    }
    
//    public func newObject() -> Element {
//        return NSManagedObject(entity: NSEntityDescription.entity(forEntityName: Element.className, in: context)!, insertInto: nil) as! Element
//    }
    
    public func fetch(element: Element,
                      _ completion: @escaping(_ exists: Bool) -> ()) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Element.className)
        let predicate = NSPredicate(format: "favorite == %@", true as CVarArg)
        request.predicate = predicate
        request.fetchLimit = 1
        
        do {
            let count = try context.count(for: request)
            if(count == 0){
                
                print("No results for item.")
                completion(false)
                
            } else{
                
                print("Item found.")
                completion(true)
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
            completion(true)
        }
    }
}

