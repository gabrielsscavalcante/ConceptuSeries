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
    
    func checkStringSpace() -> String{
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    func cleanSummary() -> String {
        
        return self.replace(target: "<p>", withString: "").replace(target: "<b>", withString: "").replace(target: "</p>", withString: "").replace(target: "</b>", withString: "")
    }
    
    func replace(target: String, withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
}
