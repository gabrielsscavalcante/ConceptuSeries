//
//  FavoriteManager.swift
//  ConceptuSeries
//
//  Created by Gabriel Cavalcante on 18/03/2018.
//  Copyright © 2018 Gabriel Cavalcante. All rights reserved.
//

import UIKit
import CoreData

struct FavoritesManager {
    
    var daoFavorites = CoreDataDAO<Favorites>()
    
    public func allFavorites() -> [Show] {
        guard let favorites = daoFavorites.all().first,
            let shows = favorites.shows else {
                return []
        }
        
        return shows.allObjects as! Array<Show>
    }
    
    public func isFavorite(_ show: Show) -> Bool {
        
        var favorites: Favorites
        let all = daoFavorites.all()
        
        if all.count == 0 {
            favorites = daoFavorites.new()
            favorites.addToShows(show)
            daoFavorites.insert(object: favorites)
        } else {
            favorites = all.first!
            if !self.contains(show, in: self.allFavorites()) {
                favorites.addToShows(show)
                return true
            } else {
                favorites.removeFromShows(show)
                return false
            }
        }
        
        return false
    }
    
    public func contains(_ show: Show, in shows: [Show]) -> Bool{
        
        for showName in shows {
            if showName.name == show.name {
                return true
            }
        }
        
        return false
    }
}
