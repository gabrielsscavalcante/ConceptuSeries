//
//  EmptyState.swift
//  ConceptuSeries
//
//  Created by Gabriel Cavalcante on 18/03/2018.
//  Copyright © 2018 Gabriel Cavalcante. All rights reserved.
//

import UIKit

class EmptyState: UIView {

    var messageLabel: UILabel!
    let constraint = ConstraintManager()
    
    init(with message: String) {
        super.init(frame: .zero)
        
        self.setupMessageLabel()
        self.messageLabel.text = message
        self.alpha = 0.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupMessageLabel() {
        
        self.messageLabel = UILabel(frame: .zero)
        self.messageLabel.textAlignment = .center
        self.messageLabel.font = UIFont(name: "Avenir-Heavy", size: 17)
        self.messageLabel.textColor = UIColor.darkGray
        self.addSubview(self.messageLabel)
    }
    
    public func show() {
        
        UIView.animate(withDuration: 0.5) {
            
            self.alpha = 1.0
        }
    }
    
    public func dismiss() {
    
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0.0
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    public func setConstraints() {
        
        guard let superview = self.superview else { return }
        self.constraint.setEqualCentralWidth(to: self, from: superview)
        self.constraint.setEqualCentralHeight(to: self, from: superview)
        
        //Label
        self.constraint.setEqualCentralWidth(to: self.messageLabel, from: self)
        self.constraint.setEqualCentralHeight(to: self.messageLabel, from: self)
    }

}
