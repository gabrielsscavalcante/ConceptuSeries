//
//  UIImageView+Extension.swift
//  ConceptuSeries
//
//  Created by Gabriel Cavalcante on 18/03/2018.
//  Copyright © 2018 Gabriel Cavalcante. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func loadImage(with reference: String?) {
        if let photoReference = reference {
            TVMazeAPI().loadImage(with: photoReference, image: { (image, url) in
                self.image = image
            })
        }
    }
}
