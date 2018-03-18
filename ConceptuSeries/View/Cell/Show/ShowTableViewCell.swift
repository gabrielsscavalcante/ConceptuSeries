//
//  ShowTableViewCell.swift
//  ConceptuSeries
//
//  Created by Gabriel Cavalcante on 17/03/2018.
//  Copyright © 2018 Gabriel Cavalcante. All rights reserved.
//

import UIKit

class ShowTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func initCell(with show: Show) {
        
        self.nameLabel.text = show.name
        self.showImageView.loadImage(with: show.imageUrl)
        self.languageLabel.text = show.language
        
        if let rating = show.rating as? Double {
            
            self.ratingLabel.text = "\(String(describing: rating))"
        }
        
        if let time = show.runtime {
            
            self.timeLabel.text = "\(time)"
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
}
