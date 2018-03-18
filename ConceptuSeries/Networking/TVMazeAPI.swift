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
import CoreData

class TVMazeAPI: NSObject {
    
    let baseUrl = "http://api.tvmaze.com/"
    var request: DataRequest?
    private let daoShow = CoreDataDAO<Show>()
    private let daoEpisode = CoreDataDAO<Episode>()
    
    func loadShows(_ completion: @escaping(_ shows: [Show]) -> ()) {
        let url = "\(baseUrl)shows"
        self.request = Alamofire.request(url).responseJSON(completionHandler: { (response) in

            guard let jsonArray = response.result.value as? [JSON],
                let showsResponse = [ShowResponse].from(jsonArray: jsonArray) else {
                    print("Coudn't load shows.")
                    return
            }
            
            self.saveGenres(with: showsResponse)
            
            let shows = self.responseToShows(showsResponse)
            
            completion(shows)
        })
    }
    
    func loadShows(by name: String, _ completion: @escaping(_ shows: [Show]) -> ()) {
        let url = "\(baseUrl)search/shows?q=\(name.lowercased().replacingOccurrences(of: " ", with: "-"))"
        self.request = Alamofire.request(url).responseJSON(completionHandler: { (response) in
            
            guard let jsonArray = response.result.value as? [JSON],
                let showsResponse = [ShowResponse].from(jsonArray: jsonArray) else {
                    print("Coudn't load shows with name: \(name).")
                    return
            }
            
            let shows = self.responseToShows(showsResponse)
            
            completion(shows)
        })
    }
    
    func loadEpisodes(from showId: Int, _ completion: @escaping(_ episodes: [Episode]) -> ()) {
        let url = "\(baseUrl)shows/\(showId)/episodes"
        self.request = Alamofire.request(url).responseJSON(completionHandler: { (response) in
            
            guard let jsonArray = response.result.value as? [JSON],
                let episodesResponse = [EpisodeResponse].from(jsonArray: jsonArray) else {
                print("Coudn't load episodes.")
                return
            }
            
            let episodes = self.responseToEpisodes(episodesResponse)
            
            completion(episodes)
        })
    }
    
    func loadImage(with photoReference: String, image: @escaping(_ image: UIImage, _ url: String) -> Void){
        guard let urlRequest = URL(string: photoReference) else {return}
        
        Alamofire.request(urlRequest).responseImage { (response) in
            if let catPicture = response.result.value {
                if let urlString = response.response?.url?.absoluteString {
                    image(catPicture, urlString)
                }
            }
        }
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
    
    private func responseToShows(_ response: [ShowResponse]) -> [Show] {

        var shows: [Show] = []
        
        for show in response {

            let newShow = daoShow.newObject()
            newShow.name = show.name
            newShow.id = String(describing: show.id)
            newShow.url = show.url
            newShow.language = show.language
            newShow.summary = show.summary
            newShow.scheduleTime = show.scheduleTime?.asTime as NSDate?
            newShow.imageUrl = show.imageUrl
            
            if let time = show.runtime {
                newShow.runtime = String(describing: time)
            }
            
            if let rating = show.rating {
                newShow.rating = rating
            }
            
            newShow.type = show.type
            newShow.days = (show.days! as NSObject)
            newShow.genres = (show.genres! as NSObject)

            daoShow.fetch(element: newShow, { (exists) in
                
                if !exists {
                    
                    newShow.favorite = false
                    
                } else {
                    
                    newShow.favorite = true
                }
            })
            
            shows.append(newShow)
        }

        return shows
    }
    
    private func responseToEpisodes(_ response: [EpisodeResponse]) -> [Episode] {
        
        var episodes: [Episode] = []
        
        for episode in response {
            
            let newEpisode = daoEpisode.new()
            newEpisode.name = episode.name
            newEpisode.id = String(describing: episode.id)
            newEpisode.url = episode.url
            newEpisode.number = String(describing: episode.number)
            newEpisode.summary = episode.summary
            newEpisode.imageUrl = episode.imageUrl
            newEpisode.season = String(describing: episode.season)
            
            episodes.append(newEpisode)
        }
        
        return episodes
    }
}
