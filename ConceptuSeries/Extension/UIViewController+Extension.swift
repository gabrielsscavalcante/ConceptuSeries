//
//  UIViewController+Extension.swift
//  ConceptuSeries
//
//  Created by Gabriel Cavalcante on 18/03/2018.
//  Copyright © 2018 Gabriel Cavalcante. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func navigationBar(isTranparent bool: Bool) {
        
        if bool {
            
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = bool
            self.navigationController?.view.backgroundColor = .clear
            
        } else {
            
            self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            self.navigationController?.navigationBar.shadowImage = nil
            self.navigationController?.navigationBar.isTranslucent = bool
            self.navigationController?.view.backgroundColor = .white
        }
    }
}
