//
//  Date+Extension.swift
//  ConceptuSeries
//
//  Created by Gabriel Cavalcante on 18/03/2018.
//  Copyright © 2018 Gabriel Cavalcante. All rights reserved.
//

import Foundation

extension Date {
    
    struct Formatter {
        static let full = DateFormatter(dateFormat: "d/M/yyyy HH:mm")
        static let onlyDate = DateFormatter(dateFormat: "d/M/yyyy")
        static let onlyTime = DateFormatter(dateFormat: "HH:mm")
        static let nameDateWeakDay = DateFormatter(dateFormat: "EEE")
        static let nameDateDay = DateFormatter(dateFormat: "d")
        static let nameDateMonth = DateFormatter(dateFormat: "MMMM")
    }
}
