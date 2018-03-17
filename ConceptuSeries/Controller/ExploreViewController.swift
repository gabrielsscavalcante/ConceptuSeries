//
//  ViewController.swift
//  ConceptuSeries
//
//  Created by Gabriel Cavalcante on 16/03/2018.
//  Copyright © 2018 Gabriel Cavalcante. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController {

    var constraint = ConstraintManager()
    var exploreView: ExploreView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.exploreView = ExploreView()
        self.view.addSubview(self.exploreView)
        self.constraint.setEqualWidth(to: self.exploreView, from: self.view)
        self.constraint.setEqualHeight(to: self.exploreView, from: self.view)
        print(self.exploreView.frame)
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

}

