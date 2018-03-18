//
//  ExploreView.swift
//  ConceptuSeries
//
//  Created by Gabriel Cavalcante on 17/03/2018.
//  Copyright © 2018 Gabriel Cavalcante. All rights reserved.
//

import UIKit

class ExploreView: UIView {

    let constraint = ConstraintManager()
    var searchBar: SearchBarView!
    var tableView: UITableView!
    
    fileprivate struct Constant {
        
        static let searchBarHeight: CGFloat = 126.0
        static let nibCellName: String = "ShowTableViewCell"
    }
    
    init() {
        super.init(frame: .zero)
        
        self.setupTableView()
        self.setupSearchBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSearchBar() {
        
        self.searchBar = SearchBarView()
        self.addSubview(self.searchBar)
        self.constraint.set(height: Constant.searchBarHeight, to: self.searchBar)
        self.constraint.setEqualCentralWidth(to: self.searchBar, from: self)
    }
    
    private func setupTableView() {
        
        self.tableView = UITableView(frame: .zero, style: .plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.registerCell()
        self.addSubview(self.tableView)
        self.tableView.tableHeaderView?.frame.size = CGSize(width: self.tableView.frame.width,
                                                            height: Constant.searchBarHeight)
        self.constraint.setEqualCentralWidth(to: self.tableView, from: self)
        self.constraint.setEqualCentralHeight(to: self.tableView, from: self)
    }
}

extension ExploreView: UITableViewDelegate, UITableViewDataSource {
    
    fileprivate func registerCell() {
        
        self.tableView.register(UINib(nibName: Constant.nibCellName, bundle: nil),
                                forCellReuseIdentifier: Constant.nibCellName)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.nibCellName) as! ShowTableViewCell
        
        return cell
    }
}
