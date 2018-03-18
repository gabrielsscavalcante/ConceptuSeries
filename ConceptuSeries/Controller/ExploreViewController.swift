//
//  ViewController.swift
//  ConceptuSeries
//
//  Created by Gabriel Cavalcante on 16/03/2018.
//  Copyright © 2018 Gabriel Cavalcante. All rights reserved.
//

import UIKit
import CoreData
import NVActivityIndicatorView

class ExploreViewController: UIViewController {

    private var constraint = ConstraintManager()
    private var activityIndicator: NVActivityIndicatorView!
    private var emptyState: EmptyState!
    private var feedView: FeedView!
    private var shows: [Show] = []
    private var selectedShow: Show?
    
    fileprivate struct Constant {
        
        static let segueForDetails: String = "SegueForDetails"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setupView()
        self.setupEmptyState()
        self.setupActitivyView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.shows.count == 0 {
            self.loadShows()
        }
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupView() {
        
        self.feedView = FeedView(type: .explore)
        self.feedView.delegate = self
        self.view.addSubview(self.feedView)
        self.constraint.setEqualWidth(to: self.feedView, from: self.view)
        self.constraint.setEqualHeight(to: self.feedView, from: self.view)
    }
    
    private func loadShows() {
        
        self.activityIndicator.startAnimating()
        
        TVMazeAPI().loadShows { (shows) in
            
            if shows.count == 0 {
                
                self.emptyState.show()
                
            } else {
                
                self.emptyState.dismiss()
            }
            self.shows = shows
            self.activityIndicator.stopAnimating()
            self.feedView.reloadTableView(with: self.shows)
        }
    }
    
    private func setupActitivyView() {
        self.activityIndicator = NVActivityIndicatorView(frame: .zero,
                                                         type: .audioEqualizer,
                                                         color: .black, padding: 0.6)
        self.view.addSubview(self.activityIndicator)
        self.constraint.set(40.0, 40.0, to: self.activityIndicator)
        self.constraint.setCenter(to: self.activityIndicator, in: self.view)
    }
    
    private func setupEmptyState() {
        self.emptyState = EmptyState(with: "We couldn't load the TVShows for you. :(")
        self.view.addSubview(emptyState)
        self.emptyState.setConstraints()
    }
}

extension ExploreViewController: FeedViewDelegate {
    
    func didSelect(_ show: Show) {
        
        self.selectedShow = show
        performSegue(withIdentifier: Constant.segueForDetails, sender: nil)
    }
    
    func didUpdateTable() { }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constant.segueForDetails {
            let controller = segue.destination as! DetailsShowViewController
            controller.show = self.selectedShow
        }
    }
}

