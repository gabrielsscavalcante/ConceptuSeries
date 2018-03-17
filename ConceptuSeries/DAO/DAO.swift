//
//  DAO.swift
//  ConceptuSeries
//
//  Created by Gabriel Cavalcante on 17/03/2018.
//  Copyright © 2018 Gabriel Cavalcante. All rights reserved.
//

import UIKit
import CoreData


public protocol DAO {
    
    associatedtype Object
    
    func insert(object: Object)
    
    func delete(object: Object)
    
    func all() -> [Object]
    
}
