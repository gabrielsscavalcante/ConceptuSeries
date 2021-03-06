//
//  ShowTableViewCell.swift
//  ConceptuSeries
//
//  Created by Gabriel Cavalcante on 17/03/2018.
//  Copyright © 2018 Gabriel Cavalcante. All rights reserved.
//

import UIKit

protocol ShowTableViewCellDelegate: NSObjectProtocol {
    
    func didRemoveFavorite(_ show: Show)
}

class ShowTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    private var show: Show!
    
    public weak var delegate: ShowTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func initCell(with show: Show) {
        
        self.show = show
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
        
        self.loadButton()
    }
    
    private func loadButton() {
        let favorites = FavoritesManager()
        if !favorites.contains(self.show, in: favorites.allFavorites()) {
            self.favoriteButton.setImage(#imageLiteral(resourceName: "iconHeartNormal"), for: .normal)
        } else {
            self.favoriteButton.setImage(#imageLiteral(resourceName: "iconHeartSelected"), for: .normal)
        }
    }
    
    @IBAction func selectFavorite(_ sender: UIButton) {
        self.didSelect()
    }
    
    private func didSelect() {
        guard let show = self.show else { return }
        if FavoritesManager().isFavorite(show) {
            
            self.favoriteButton.setImage(#imageLiteral(resourceName: "iconHeartSelected"), for: .normal)
            
        } else {
            
            self.favoriteButton.setImage(#imageLiteral(resourceName: "iconHeartNormal"), for: .normal)
            self.delegate?.didRemoveFavorite(show)
        }
    }
}
