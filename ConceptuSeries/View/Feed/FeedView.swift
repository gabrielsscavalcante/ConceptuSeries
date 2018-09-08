//
//  ExploreView.swift
//  ConceptuSeries
//
//  Created by Gabriel Cavalcante on 17/03/2018.
//  Copyright © 2018 Gabriel Cavalcante. All rights reserved.
//

import UIKit
import AutoLayouty

enum FeedViewType {
    case explore
    case favorites
}

protocol FeedViewDelegate: NSObjectProtocol {
    
    func didSelect(_ show: Show)
    func didUpdateTable()
}

class FeedView: UIView {

    fileprivate let constraint = AutoLayouty()
    fileprivate var searchBarHeightConstraint: NSLayoutConstraint!
    fileprivate var previousScrollOffset: CGFloat = 0.0
    fileprivate var searchBar: SearchBarView!
    fileprivate var tableView: UITableView!
    fileprivate var type: FeedViewType!
    fileprivate var shows: [Show] = []
    
    public weak var delegate: FeedViewDelegate?
    
    fileprivate struct Constant {
        
        static let minSearchBarHeight: CGFloat = 64
        static let searchBarHeight: CGFloat = 110
        static let nibCellName: String = "ShowTableViewCell"
    }
    
    init(type: FeedViewType) {
        super.init(frame: .zero)
        
        self.type = type
        self.setupTableView()
        
        //No search bar for Favorite
        if type == .explore {
            self.setupSearchBar()
        }
        self.setStatusBarColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSearchBar() {
        
        self.searchBar = SearchBarView()
        self.searchBar.delegate = self
        self.addSubview(self.searchBar)
        
        //Constraints
        self.constraint.setTop(distance: -20, for: self.searchBar, from: self)
        self.searchBarHeightConstraint = self.constraint.set(returningheight: Constant.searchBarHeight, to: self.searchBar)
        self.constraint.setEqualCentralWidth(to: self.searchBar, from: self)
    }
    
    private func setupTableView() {
        
        self.tableView = UITableView(frame: .zero, style: .plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.registerCell()
        self.addSubview(self.tableView)
        
        //FavoriteViewController doesn't have searchBar
        if self.type == .explore {
            self.tableView.sectionHeaderHeight = Constant.searchBarHeight
        }
        
        //Constraints
        self.constraint.setEqualCentralWidth(to: self.tableView, from: self)
        self.constraint.setEqualCentralHeight(to: self.tableView, from: self)
    }
    
    private func setStatusBarColor() {
        
        let statusBarView = UIView(frame: .zero)
        statusBarView.backgroundColor = UIColor.white
        self.addSubview(statusBarView)
        
        //Constraints
        self.constraint.set(height: 64.0, to: statusBarView)
        self.constraint.setEqualCentralWidth(to: statusBarView, from: self)
        self.constraint.setTop(distance: 0.0, for: statusBarView, from: self)
        
        if self.searchBar != nil {
            self.bringSubview(toFront: self.searchBar)
        }
    }
}

extension FeedView: UITableViewDelegate, UITableViewDataSource {
    
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
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        self.delegate?.didSelect(self.shows[indexPath.row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollDiff = scrollView.contentOffset.y - self.previousScrollOffset
        
        var verticallingUp: Bool = false
        let absoluteTop: CGFloat = 0;
        let absoluteBottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height;
        let isScrollingUp = scrollDiff > 0 && scrollView.contentOffset.y > absoluteTop
        let isScrollingDown = scrollDiff < 0 && scrollView.contentOffset.y < absoluteBottom
        
        var newHeight = self.searchBarHeightConstraint.constant
        if isScrollingUp {
            newHeight = max(Constant.minSearchBarHeight, self.searchBarHeightConstraint.constant - abs(scrollDiff))
            
            verticallingUp = true
            
            if newHeight != self.searchBarHeightConstraint.constant {
                self.searchBarHeightConstraint.constant = newHeight
            }
        } else if isScrollingDown {
            
            verticallingUp = false
            
            if self.searchBarHeightConstraint.constant >= Constant.searchBarHeight {
                self.animateBack()
            } else {
                if scrollDiff < 0 && scrollView.contentOffset.y < 0 {
                    self.searchBarHeightConstraint.constant -= scrollDiff
                    scrollView.contentOffset.y -= scrollDiff
                }
            }
        }
        
        self.previousScrollOffset = scrollView.contentOffset.y
        self.searchBar.updateHeight(with: self.previousScrollOffset, verticallingUp: verticallingUp)
    }
    
    private func animateBack() {
        UIView.animate(withDuration: 1.3, delay: 0.0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.4,
                       options: [.allowUserInteraction],
                       animations: {
                        self.searchBarHeightConstraint.constant = Constant.searchBarHeight
                        self.layoutIfNeeded()
        })
    }
}

extension FeedView: SearchBarViewDelegate {
    
    func didSearch(with query: String) {
        
        if query == ""{
           
            TVMazeAPI().loadShows() { (shows) in
                
                self.reloadTableView(with: shows)
            }
            
        } else {
            
            TVMazeAPI().loadShows(by: query) { (shows) in
                
                self.reloadTableView(with: shows)
            }
        }
    }
}

extension FeedView: ShowTableViewCellDelegate {
    
    func didRemoveFavorite(_ show: Show) {
        
        if self.type == .favorites {
            self.shows = self.shows.filter { $0 != show }
            self.tableView.reloadData()
            self.delegate?.didUpdateTable()
        }
    }
}
