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
    
    private var context: NSManagedObjectContext
    
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
}

