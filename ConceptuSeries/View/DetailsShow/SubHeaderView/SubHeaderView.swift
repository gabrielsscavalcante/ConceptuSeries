//
//  SubHeaderView.swift
//  ConceptuSeries
//
//  Created by Gabriel Cavalcante on 18/03/2018.
//  Copyright © 2018 Gabriel Cavalcante. All rights reserved.
//

import UIKit

class SubHeaderView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    
    init(frame: CGRect, title: String) {
        super.init(frame: frame)
        
        let nibView = Bundle.main.loadNibNamed("SubHeaderView",
                                               owner: self,
                                               options: nil)?.first as! UIView
        nibView.frame = frame
        self.addSubview(nibView)
        
        self.titleLabel.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
