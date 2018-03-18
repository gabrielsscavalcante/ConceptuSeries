//
//  EpisodeHeaderView.swift
//  ConceptuSeries
//
//  Created by Gabriel Cavalcante on 18/03/2018.
//  Copyright © 2018 Gabriel Cavalcante. All rights reserved.
//

import UIKit
import CoreData

class DetailsHeaderView: UIView {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var iconRating: UIImageView!
    @IBOutlet weak var iconSettings: UIImageView!
    @IBOutlet weak var iconTime: UIImageView!
    
    private var show: Show?
    private var episode: Episode?
    
    init(with show: Show) {
        super.init(frame: .zero)
        
        let nibView = Bundle.main.loadNibNamed("DetailsHeaderView",
                                               owner: self,
                                               options: nil)?.first as! UIView
        nibView.frame = frame
        self.addSubview(nibView)
        
        self.show = show
        
        self.nameLabel.text = show.name
        self.showImageView.loadImage(with: show.imageUrl)
        self.ratingLabel.text = "\(show.rating)"
        self.languageLabel.text = show.language
        
        if let time = show.runtime {
            
            self.timeLabel.text = time
        }
        
        if let genres = show.genres as? Array<String> {
            
            self.genreLabel.text = "\(genres.joined(separator: ", "))"
        }
        
//        let daoShow = CoreDataDAO<Show>()
//        daoShow.fetch(element: show) { (exists) in
//                        
//                        if !exists {
//                            self.favoriteButton.setImage(#imageLiteral(resourceName: "iconHeartNormal"), for: .normal)
//                        } else {
//                            self.favoriteButton.setImage(#imageLiteral(resourceName: "iconHeartSelected"), for: .normal)
//                        }
//        }
    }
    
    init(with episode: Episode) {
        super.init(frame: .zero)
        
        let nibView = Bundle.main.loadNibNamed("DetailsHeaderView",
                                               owner: self,
                                               options: nil)?.first as! UIView
        nibView.frame = frame
        self.addSubview(nibView)
        
        self.episode = episode
        self.favoriteButton.isHidden = true
        self.languageLabel.isHidden = true
        self.timeLabel.isHidden = true
        self.ratingLabel.isHidden = true
        self.iconTime.isHidden = true
        self.iconRating.isHidden = true
        self.iconSettings.isHidden = true
        
        self.nameLabel.text = episode.name
        self.showImageView.loadImage(with: episode.imageUrl)
        if let season = episode.season, let number = episode.number {
            
            self.genreLabel.text = "Season \(String(describing: season)) - Number \(String(describing: number))"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func addFavorite(_ sender: UIButton) {
        
        guard let show = self.show else { return }
        if FavoritesManager().isFavorite(show) {
            
            self.favoriteButton.setImage(#imageLiteral(resourceName: "iconHeartSelected"), for: .normal)
            
        } else {
            
            self.favoriteButton.setImage(#imageLiteral(resourceName: "iconHeartNormal"), for: .normal)
        }
        
//
//        let daoFavorites = CoreDataDAO<Favorites>()
//        var favorites: Favorites
//
//        if daoFavorites.all().count == 0 {
//            favorites = daoFavorites.new()
//            favorites.addToShows(show)
//            daoFavorites.insert(object: favorites)
//        } else {
//            favorites = daoFavorites.all().first!
//            guard let shows = favorites.shows else { return }
//            if !shows.contains(show) {
//                favorites.addToShows(show)
//                self.favoriteButton.setImage(#imageLiteral(resourceName: "iconHeartSelected"), for: .normal)
//            } else {
//                favorites.removeFromShows(show)
//                self.favoriteButton.setImage(#imageLiteral(resourceName: "iconHeartNormal"), for: .normal)
//            }
//
//            print(shows.count)
//        }
    }
}
