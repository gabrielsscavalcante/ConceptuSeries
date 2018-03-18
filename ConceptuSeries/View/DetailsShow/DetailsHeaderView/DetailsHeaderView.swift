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

    private var show: Show!
    
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
        
        let daoShow = CoreDataDAO<Show>()
        daoShow.fetch(element: show) { (exists) in
                        
                        if !exists {
                            self.favoriteButton.setImage(#imageLiteral(resourceName: "iconHeartNormal"), for: .normal)
                        } else {
                            self.favoriteButton.setImage(#imageLiteral(resourceName: "iconHeartSelected"), for: .normal)
                        }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func addFavorite(_ sender: UIButton) {
        
        if self.show.favorite {
            self.show.favorite = false
            self.favoriteButton.setImage(#imageLiteral(resourceName: "iconHeartNormal"), for: .normal)
        } else {
            self.show.favorite = true
            self.favoriteButton.setImage(#imageLiteral(resourceName: "iconHeartSelected"), for: .normal)
        }
    }
}
