//
//  FavoriteViewController.swift
//  ConceptuSeries
//
//  Created by Gabriel Cavalcante on 17/03/2018.
//  Copyright © 2018 Gabriel Cavalcante. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    private var feedView: FeedView!
    private var constraint = ConstraintManager()
    private var shows: [Show] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationBar(with: "Favorites")
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadShows()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setupView() {
        
        self.feedView = FeedView(type: .favorites)
        self.feedView.delegate = self
        self.view.addSubview(self.feedView)
        self.constraint.setEqualWidth(to: self.feedView, from: self.view)
        self.constraint.setEqualHeight(to: self.feedView, from: self.view)
    }
    
    private func loadShows() {
        
        let daoFavorites = CoreDataDAO<Favorites>()
        if let favorites = daoFavorites.all().first, let shows = favorites.shows {
            self.shows = shows.allObjects as! Array<Show>
            self.feedView.reloadTableView(with: self.shows)
        }
    }
}

extension FavoriteViewController: FeedViewDelegate {
    func didSelect(_ show: Show) {
        print("Select show \(show.name!)")
    }
}
