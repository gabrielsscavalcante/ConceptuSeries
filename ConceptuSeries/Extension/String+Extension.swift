//
//  String+Extension.swift
//  ConceptuSeries
//
//  Created by Gabriel Cavalcante on 18/03/2018.
//  Copyright © 2018 Gabriel Cavalcante. All rights reserved.
//

import UIKit

extension String {
    
    var asDateAndTime: Date? {
        return Date.Formatter.full.date(from: self)
    }
    var asDate: Date? {
        return Date.Formatter.onlyDate.date(from: self)
    }
    
    var asTime: Date? {
        return Date.Formatter.onlyTime.date(from: self)
    }
    
    func asDateFormatted(with dateFormat: String) -> Date? {
        return DateFormatter(dateFormat: dateFormat).date(from: self)
    }
}
