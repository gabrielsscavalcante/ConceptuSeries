//
//  SearchBarView.swift
//  ConceptuSeries
//
//  Created by Gabriel Cavalcante on 17/03/2018.
//  Copyright © 2018 Gabriel Cavalcante. All rights reserved.
//

import UIKit

class SearchBarView: UIView {
    
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    init() {
        super.init(frame: .zero)
        
        let nibView = Bundle.main.loadNibNamed("SearchBarView",
                                               owner: self,
                                               options: nil)?.first as! UIView
        nibView.frame = frame
        self.backgroundColor = UIColor.clear
        self.addSubview(nibView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
