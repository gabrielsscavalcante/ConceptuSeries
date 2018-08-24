//
//  SearchBarView.swift
//  ConceptuSeries
//
//  Created by Gabriel Cavalcante on 17/03/2018.
//  Copyright © 2018 Gabriel Cavalcante. All rights reserved.
//

import UIKit

protocol SearchBarViewDelegate: NSObjectProtocol {
    
    func didSearch(with query: String)
}

class SearchBarView: UIView {
    
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var leftTextViewConstraint: NSLayoutConstraint!
    
    private var currentHeight: CGFloat = 110
    
    public weak var delegate: SearchBarViewDelegate?
    private let constraint = ConstraintManager()
    
    fileprivate struct Constants {
        
        static let minLeftSize: CGFloat = 17
        static let maxLeftSize: CGFloat = 35
    }
    
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
        self.textField.delegate = self
        self.cancelButton.alpha = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.textField.text = ""
        self.textField.resignFirstResponder()
    }
    
    private func appearCancel() {
        UIView.animate(withDuration: 0.3, animations: {
            self.cancelButton.alpha = 1
        }, completion: nil)
    }
    
    private func disappearCancel() {
        UIView.animate(withDuration: 0.3, animations: {
            self.cancelButton.alpha = 0
        }, completion: nil)
    }
    
    public func updateHeight(with constant: CGFloat, verticallingUp: Bool) {
        
        let sizeComparision = self.currentHeight - constant
    
        print(sizeComparision)
        print(verticallingUp)
        
        if verticallingUp {
            
        } else {
            
        }
        
        if self.leftTextViewConstraint.constant <= Constants.maxLeftSize && self.leftTextViewConstraint.constant >= Constants.minLeftSize {
            
        } else {
            
        }
        
        self.currentHeight = constant
    }
}

extension SearchBarView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.appearCancel()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.disappearCancel()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.delegate?.didSearch(with: textField.text!)
        
        return false
    }
}
