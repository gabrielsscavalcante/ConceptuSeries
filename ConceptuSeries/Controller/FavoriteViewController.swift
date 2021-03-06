//
//  FavoriteViewController.swift
//  ConceptuSeries
//
//  Created by Gabriel Cavalcante on 17/03/2018.
//  Copyright © 2018 Gabriel Cavalcante. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    private var emptyState: EmptyState!
    private var feedView: FeedView!
    private var constraint = ConstraintManager()
    private var shows: [Show] = []
    fileprivate var selectedShow: Show!
    
    fileprivate struct Constant {
        
        static let segueForDetails: String = "SegueForDetails"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationBar(with: "Favorites")
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        
        self.shows = FavoritesManager().allFavorites()
        
        if self.shows.count == 0 {
            
            self.setupEmptyState()
            self.emptyState.show()
            
        } else {
            
            self.feedView.reloadTableView(with: self.shows)
            
            if self.emptyState != nil {
                
                self.emptyState.dismiss()
            }
        }
    }
    
    private func setupEmptyState() {
        self.emptyState = EmptyState(with: "Seems like you don't watch TVShows, hãn? :)")
        self.view.addSubview(emptyState)
        self.emptyState.setConstraints()
    }
}

extension FavoriteViewController: FeedViewDelegate {
    func didSelect(_ show: Show) {
        self.selectedShow = show
        performSegue(withIdentifier: Constant.segueForDetails, sender: nil)
    }
    
    func didUpdateTable() {
        self.loadShows()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constant.segueForDetails {
            let controller = segue.destination as! DetailsShowViewController
            controller.show = self.selectedShow
        }
    }
}
