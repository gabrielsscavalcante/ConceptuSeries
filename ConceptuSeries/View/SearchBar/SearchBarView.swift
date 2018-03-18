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
    
    let constraint = ConstraintManager()
    
    init() {
        super.init(frame: .zero)
        
        let nibView = Bundle.main.loadNibNamed("SearchBarView",
                                               owner: self,
                                               options: nil)?.first as! UIView
        nibView.frame = frame
        self.backgroundColor = UIColor.clear
        self.addSubview(nibView)
        
        self.textFieldView.dropShadow(color: .black, opacity: 0.3,
                                      offSet: CGSize(width: 1, height: 1),
                                      radius: 4, scale: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
