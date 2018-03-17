//
//  EpisodeResponse.swift
//  ConceptuSeries
//
//  Created by Gabriel Cavalcante on 17/03/2018.
//  Copyright © 2018 Gabriel Cavalcante. All rights reserved.
//

import Alamofire
import Gloss

struct EpisodeResponse: Glossy {
    var id: Int?
    var url: String?
    var name: String?
    var season: String?
    var number: Int?
    var airdate: String?
    var airtime: String?
    var summary: String?
    var imageUrl: String?
    
    init?(json: JSON) {
        self.id = "id" <~~ json
        self.name = "name" <~~ json
        self.url = "url" <~~ json
        self.number = "number" <~~ json
        self.season = "season" <~~ json
        self.summary = "summary" <~~ json
        self.airdate = "airdate" <~~ json
        self.airtime = "airtime" <~~ json
        
        if let recImage: Dictionary<String, Any?>? = "image" <~~ json,
            let recImageUrl = recImage!["original"] as? String {
            self.imageUrl = recImageUrl
        }
    }
    
    func toJSON() -> JSON? {
        return nil
    }
}
