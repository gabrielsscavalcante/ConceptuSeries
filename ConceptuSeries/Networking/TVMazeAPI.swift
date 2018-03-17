//
//  TVMazeAPI.swift
//  ConceptuSeries
//
//  Created by Gabriel Cavalcante on 17/03/2018.
//  Copyright © 2018 Gabriel Cavalcante. All rights reserved.
//

import Alamofire
import AlamofireImage
import Gloss

class TVMazeAPI: NSObject {
    
    let baseUrl = "http://api.tvmaze.com/"
    var request: DataRequest?
    
    func loadShows(_ completion: @escaping(_ shows: [ShowResponse]) -> ()) {
        let url = baseUrl+"shows"
        print(url)
        self.request = Alamofire.request(url).responseJSON(completionHandler: { (response) in

            guard let showsResponse = [ShowResponse].from(jsonArray: response.result.value as! [JSON]) else {
                    print("Coudn't load shows.")
                    return
            }
            
            completion(showsResponse)
        })
    }
}
