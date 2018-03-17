//
//  NSManagedObject+Extension.swift
//  ConceptuSeries
//
//  Created by Gabriel Cavalcante on 17/03/2018.
//  Copyright © 2018 Gabriel Cavalcante. All rights reserved.
//

import CoreData

extension NSManagedObject {
    
    static var className: String {
        return String(describing: self)
    }
}
