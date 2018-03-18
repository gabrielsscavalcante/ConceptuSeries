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
                    completion([])
                    return
            }
            
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
    
    func loadEpisodes(from show: Show, _ completion: @escaping(_ episodes: [Episode]) -> ()) {
        
        guard let id = show.id else { return }
        let url = "\(baseUrl)shows/\(id)/episodes"
        self.request = Alamofire.request(url).responseJSON(completionHandler: { (response) in
            
            guard let jsonArray = response.result.value as? [JSON],
                let episodesResponse = [EpisodeResponse].from(jsonArray: jsonArray) else {
                print("Coudn't load episodes.")
                return
            }
            
            let episodes = self.responseToEpisodes(episodesResponse, and: show)
            
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
    
    private func responseToShows(_ response: [ShowResponse]) -> [Show] {

        var shows: [Show] = []
        
        for show in response {

            let newShow = daoShow.new()
            newShow.name = show.name
            newShow.url = show.url
            newShow.language = show.language
            newShow.scheduleTime = show.scheduleTime?.asTime as NSDate?
            newShow.imageUrl = show.imageUrl
            newShow.type = show.type
            newShow.days = (show.days! as NSObject)
            newShow.genres = (show.genres! as NSObject)
            
            if let id = show.id {
                newShow.id = String(id)
            }
            
            if let summary = show.summary?.cleanSummary() {
                newShow.summary = summary
            }
            
            if let time = show.runtime {
                newShow.runtime = String(describing: time)
            }
            
            if let rating = show.rating {
                newShow.rating = rating
            }
            
            shows.append(newShow)
        }

        return shows
    }
    
    private func responseToEpisodes(_ response: [EpisodeResponse], and show: Show) -> [Episode] {
        
        var episodes: [Episode] = []
        
        for episode in response {
            
            let newEpisode = daoEpisode.new()
            newEpisode.name = episode.name
            newEpisode.url = episode.url
            newEpisode.imageUrl = episode.imageUrl
            
            if let id = episode.id {
                newEpisode.id = String(id)
            }
            
            if let number = episode.number {
                newEpisode.number = String(number)
            }
            
            if let summary = episode.summary?.cleanSummary() {
                newEpisode.summary = summary
            }
            
            if let season = episode.season {
                newEpisode.season = String(season)
            }
            
            show.addToEpisodes(newEpisode)
            
            episodes.append(newEpisode)
        }
        
        return episodes
    }
}
