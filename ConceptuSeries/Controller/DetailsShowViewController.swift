//
//  DetailsShowViewController.swift
//  ConceptuSeries
//
//  Created by Gabriel Cavalcante on 18/03/2018.
//  Copyright © 2018 Gabriel Cavalcante. All rights reserved.
//

import UIKit

class DetailsShowViewController: UIViewController {

    private var constraint = ConstraintManager()
    private var detailsShowView: DetailsShowView!
    public var show: Show?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar(isTranparent: true)

        // Do any additional setup after loading the view.
        if let show = self.show {
            
            self.detailsShowView = DetailsShowView(with: show)
            self.view.addSubview(self.detailsShowView)
            self.constraint.setEqualWidth(to: self.detailsShowView, from: self.view)
            self.constraint.setEqualHeight(to: self.detailsShowView, from: self.view)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.detailsShowView.setHeaderHeight()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
