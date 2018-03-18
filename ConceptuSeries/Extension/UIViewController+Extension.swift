//
//  UIViewController+Extension.swift
//  ConceptuSeries
//
//  Created by Gabriel Cavalcante on 18/03/2018.
//  Copyright © 2018 Gabriel Cavalcante. All rights reserved.
//

import UIKit

extension UIViewController {
    
    enum StatusBarColor {
        case black
        case white
    }
    
    func changeLargeNavigationBar(_ bool: Bool) {
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = bool
        } else {
            // Fallback on earlier versions
        }
    }
    
    func navigationBar(with title: String) {
        
        self.navigationItem.title = title
        self.navigationItem.backBarButtonItem?.title = ""
    }
    
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
    
    func statusBar(_ color: StatusBarColor) {
        
        if color == .white {
            UIApplication.shared.statusBarStyle = .lightContent
        } else {
            UIApplication.shared.statusBarStyle = .default
        }
    }
}
