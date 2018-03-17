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
    var type: String?
    
    init?(json: JSON) {
        
        var showJson: JSON = json
        if let newJson: JSON = "show" <~~ json {
            showJson = newJson
        }
        
        self.id = "id" <~~ showJson
        self.name = "name" <~~ showJson
        self.url = "url" <~~ showJson
        self.language = "language" <~~ showJson
        self.summary = "summary" <~~ showJson
        self.genres = "genres" <~~ showJson
        self.runtime = "runtime" <~~ showJson
        self.type = "type" <~~ showJson
        
        if let recImage: Dictionary<String, Any?>? = "image" <~~ showJson,
            let recImageUrl = recImage!["original"] as? String {
            self.imageUrl = recImageUrl
        }
        
        if let recRating: Dictionary<String, Any?>? = "rating" <~~ showJson,
            let recAverage = recRating!["average"] as? Double {
            self.rating = recAverage
        }
        
        if let recSchedule: Dictionary<String, Any?>? = "schedule" <~~ showJson,
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
