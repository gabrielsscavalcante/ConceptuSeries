//
//  ShowResponse.swift
//  ConceptuSeries
//
//  Created by Gabriel Cavalcante on 17/03/2018.
//  Copyright © 2018 Gabriel Cavalcante. All rights reserved.
//

import Alamofire
import Gloss

struct ShowResponse: Glossy {
    var id: Int?
    var url: String?
    var name: String?
    var language: String?
    var summary: String?
    var imageUrl: String?
    var scheduleTime: String?
    var runtime: Int?
    var rating: Double?
    var days: [String]?
    var genres: [String]?
    
    init?(json: JSON) {
        self.id = "id" <~~ json
        self.name = "name" <~~ json
        self.url = "url" <~~ json
        self.language = "language" <~~ json
        self.summary = "summary" <~~ json
        self.genres = "genres" <~~ json
        self.runtime = "runtime" <~~ json
        
        if let recImage: Dictionary<String, Any?>? = "image" <~~ json,
            let recImageUrl = recImage!["original"] as? String {
            self.imageUrl = recImageUrl
        }
        
        if let recRating: Dictionary<String, Any?>? = "rating" <~~ json,
            let recAverage = recRating!["average"] as? Double {
            self.rating = recAverage
        }
        
        if let recSchedule: Dictionary<String, Any?>? = "schedule" <~~ json,
            let recTime = recSchedule!["time"] as? String,
            let recDays = recSchedule!["days"] as? [String] {
            self.scheduleTime = recTime
            self.days = recDays
        }
    }
    
    func toJSON() -> JSON? {
        return nil
    }
}
