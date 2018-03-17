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
        let url = "\(baseUrl)shows"
        self.request = Alamofire.request(url).responseJSON(completionHandler: { (response) in

            guard let jsonArray = response.result.value as? [JSON],
                let showsResponse = [ShowResponse].from(jsonArray: jsonArray) else {
                    print("Coudn't load shows.")
                    return
            }
            
            self.saveGenres(with: showsResponse)
            
            completion(showsResponse)
        })
    }
    
    func loadShows(by name: String, _ completion: @escaping(_ shows: [ShowResponse]) -> ()) {
        let url = "\(baseUrl)search/shows?q=\(name)"
        self.request = Alamofire.request(url).responseJSON(completionHandler: { (response) in
            
            guard let jsonArray = response.result.value as? [JSON],
                let showsResponse = [ShowResponse].from(jsonArray: jsonArray) else {
                    print("Coudn't load shows with name: \(name).")
                    return
            }
            
            completion(showsResponse)
        })
    }
    
    func loadEpisodes(from showId: Int, _ completion: @escaping(_ episodes: [EpisodeResponse]) -> ()) {
        let url = "\(baseUrl)shows/\(showId)/episodes"
        self.request = Alamofire.request(url).responseJSON(completionHandler: { (response) in
            
            guard let jsonArray = response.result.value as? [JSON],
                let episodesResponse = [EpisodeResponse].from(jsonArray: jsonArray) else {
                print("Coudn't load episodes.")
                return
            }
            
            completion(episodesResponse)
        })
    }
    
    func saveGenres(with showsResponse: [ShowResponse]) {
        guard let _ = UserDefaults.standard.array(forKey: "genres") else {
            
            var genres: [String] = []
            
            for show in showsResponse where show.genres != nil {
                for genre in show.genres! {
                    if !genres.contains(genre) {
                        genres.append(genre)
                    }
                }
            }
            
            UserDefaults.standard.set(genres, forKey: "genres")
            
            return
        }
    }
}
