//
//  ViewController.swift
//  ConceptuSeries
//
//  Created by Gabriel Cavalcante on 16/03/2018.
//  Copyright © 2018 Gabriel Cavalcante. All rights reserved.
//

import UIKit
import CoreData

class ExploreViewController: UIViewController {

    var constraint = ConstraintManager()
    var exploreView: ExploreView!
    var shows: [Show] = []
    var selectedShow: Show?
    
    fileprivate struct Constant {
        
        static let segueForDetails: String = "SegueForDetails"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.loadShows()
        self.setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupView() {
        
        self.exploreView = ExploreView()
        self.exploreView.delegate = self
        self.view.addSubview(self.exploreView)
        self.constraint.setEqualWidth(to: self.exploreView, from: self.view)
        self.constraint.setEqualHeight(to: self.exploreView, from: self.view)
    }
    
    private func loadShows() {
        
        TVMazeAPI().loadShows { (shows) in
            
            self.shows = shows
            self.exploreView.reloadTableView(with: self.shows)
        }
    }
}

extension ExploreViewController: ExploreViewDelegate {
    
    func didSelect(_ show: Show) {
        
        self.selectedShow = show
        performSegue(withIdentifier: Constant.segueForDetails, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constant.segueForDetails {
            let controller = segue.destination as! DetailsShowViewController
            controller.show = self.selectedShow
        }
    }
}

