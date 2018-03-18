//
//  ExploreView.swift
//  ConceptuSeries
//
//  Created by Gabriel Cavalcante on 17/03/2018.
//  Copyright © 2018 Gabriel Cavalcante. All rights reserved.
//

import UIKit

protocol ExploreViewDelegate: NSObjectProtocol {
    
    func didSelect(_ show: Show)
}

class ExploreView: UIView {

    fileprivate let constraint = ConstraintManager()
    fileprivate var searchBar: SearchBarView!
    fileprivate var tableView: UITableView!
    fileprivate var shows: [Show] = []
    
    public weak var delegate: ExploreViewDelegate?
    
    fileprivate struct Constant {
        
        static let searchBarHeight: CGFloat = 96.0
        static let nibCellName: String = "ShowTableViewCell"
    }
    
    init() {
        super.init(frame: .zero)
        
        self.setupTableView()
        self.setupSearchBar()
        self.setStatusBarColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSearchBar() {
        
        self.searchBar = SearchBarView()
        self.searchBar.delegate = self
        self.addSubview(self.searchBar)
        self.constraint.set(height: Constant.searchBarHeight, to: self.searchBar)
        self.constraint.setEqualCentralWidth(to: self.searchBar, from: self)
    }
    
    private func setupTableView() {
        
        self.tableView = UITableView(frame: .zero, style: .plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.sectionHeaderHeight = Constant.searchBarHeight
        self.tableView.separatorStyle = .none
        self.registerCell()
        self.addSubview(self.tableView)
        self.constraint.setEqualCentralWidth(to: self.tableView, from: self)
        self.constraint.setEqualCentralHeight(to: self.tableView, from: self)
    }
    
    private func setStatusBarColor() {
        let statusBarView = UIView(frame: .zero)
        statusBarView.backgroundColor = UIColor.white
        self.addSubview(statusBarView)
        self.constraint.set(height: 40.0, to: statusBarView)
        self.constraint.setEqualCentralWidth(to: statusBarView, from: self)
        self.constraint.setTop(distance: 0.0, for: statusBarView, from: self)
    }
}

extension ExploreView: UITableViewDelegate, UITableViewDataSource {
    
    public func reloadTableView(with shows: [Show]) {
        
        self.shows = shows
        self.tableView.reloadData()
    }
    
    fileprivate func registerCell() {
        
        self.tableView.register(UINib(nibName: Constant.nibCellName, bundle: nil),
                                forCellReuseIdentifier: Constant.nibCellName)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shows.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0,
                                        width: self.tableView.frame.width,
                                        height: Constant.searchBarHeight))
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.nibCellName) as! ShowTableViewCell
        
        cell.initCell(with: self.shows[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.delegate?.didSelect(self.shows[indexPath.row])
    }
}

extension ExploreView: SearchBarViewDelegate {
    
    func didSearch(with query: String) {
        
        TVMazeAPI().loadShows(by: query) { (shows) in
            
            self.reloadTableView(with: shows)
        }
    }
}
