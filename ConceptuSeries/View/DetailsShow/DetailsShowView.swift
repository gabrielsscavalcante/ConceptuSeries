//
//  DetailsShowView.swift
//  ConceptuSeries
//
//  Created by Gabriel Cavalcante on 17/03/2018.
//  Copyright © 2018 Gabriel Cavalcante. All rights reserved.
//

import UIKit

class DetailsShowView: UIView {

    fileprivate var headerView: DetailsHeaderView!
    fileprivate var tableView: UITableView!
    fileprivate var headerHeightConstraint: NSLayoutConstraint!
    fileprivate var show: Show!
    
    fileprivate struct Constant {
        
        static let maxHeaderHeight: CGFloat = 375.0
        static let minHeaderHeight: CGFloat = 0.0
    }
    
    init(with show: Show) {
        super.init(frame: .zero)
        
        self.show = show
        self.setUpHeader()
//        self.setUpTableView()
    }
    
    public func setHeaderHeight() {
        
        self.headerHeightConstraint.constant = Constant.maxHeaderHeight
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setUpHeader() {
        self.headerView = DetailsHeaderView(with: self.show)
        self.headerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.headerView)
        
        self.headerHeightConstraint = self.headerView.heightAnchor
            .constraint(equalToConstant: self.headerView.frame.height)
        self.headerHeightConstraint.isActive = true
        
        //-94 for iPhone X
        let constraints:[NSLayoutConstraint] = [
            self.headerView.topAnchor.constraint(equalTo: self.topAnchor, constant: -84.0),
            self.headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    fileprivate func setUpTableView() {
        self.tableView = UITableView(frame: .zero, style: .plain)
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
        self.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints:[NSLayoutConstraint] = [
            self.tableView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension DetailsShowView: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! UITableViewCell
        
        return cell
    }
}
