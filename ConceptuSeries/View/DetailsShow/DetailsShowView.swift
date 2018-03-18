//
//  DetailsShowView.swift
//  ConceptuSeries
//
//  Created by Gabriel Cavalcante on 17/03/2018.
//  Copyright © 2018 Gabriel Cavalcante. All rights reserved.
//

import UIKit

protocol DetailsShowViewDelegate: NSObjectProtocol {
    
    func didChangeNavigationBar(_ bool: Bool)
}

class DetailsShowView: UIView {

    fileprivate var headerView: DetailsHeaderView!
    fileprivate var tableView: UITableView!
    fileprivate var headerHeightConstraint: NSLayoutConstraint!
    fileprivate var oldContentOffset = CGPoint.zero
    fileprivate let topConstraintRange = (Constant.minHeaderHeight..<Constant.maxHeaderHeight)
    fileprivate var show: Show!
    
    public weak var delegate: DetailsShowViewDelegate?
    
    fileprivate struct Constant {
        
        static let descriptionCell: String = "DescriptionTableViewCell"
        static let maxHeaderHeight: CGFloat = 425.0
        static let minHeaderHeight: CGFloat = 0.0
        static let subHeaderHeight: CGFloat = 53.0
    }
    
    init(with show: Show) {
        super.init(frame: .zero)
        
        self.show = show
        self.setUpHeader()
        self.setUpTableView()
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
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.registerCells()
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
    
    fileprivate func registerCells() {
        
        self.tableView.register(UINib(nibName: Constant.descriptionCell, bundle: nil),
                                forCellReuseIdentifier: Constant.descriptionCell)
    }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
    
        let rect = CGRect(x: 0, y: 0,
                          width: (self.window?.frame.size.width)!,
                          height: Constant.subHeaderHeight)
        
        if section == 1 {
            
            return SubHeaderView(frame: rect,
                                 title: "Schedule")
            
        } else if section > 1 {
            
            return SubHeaderView(frame: rect,
                                 title: "Season \(section-1)")
        }
        
        return nil
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section >= 1 {
            
            return Constant.subHeaderHeight
        } else {
            
            return 0.0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.descriptionCell) as! DescriptionTableViewCell
        
        if let summary = self.show.summary {
            
            cell.initCell(with: summary)
        }
        
        return cell
    }
    
    fileprivate func animateHeader() {
        
        self.headerHeightConstraint.constant = Constant.maxHeaderHeight
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.5,
                       options: [.curveEaseInOut, .allowUserInteraction],
                       animations: {
                        
                        self.layoutIfNeeded()
                        
        }, completion: nil)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let delta = scrollView.contentOffset.y - self.oldContentOffset.y
        
        //Compress the top view
        if delta > 0 && self.headerHeightConstraint.constant > self.topConstraintRange.lowerBound && scrollView.contentOffset.y > 0 {
            self.headerHeightConstraint.constant -= delta
            scrollView.contentOffset.y -= delta
        }
        
        //Expand the top view
        if delta < 0 && scrollView.contentOffset.y < 0 {
            self.headerHeightConstraint.constant -= delta
            scrollView.contentOffset.y -= delta
            
        }
        
        self.oldContentOffset = scrollView.contentOffset
        
        if self.headerHeightConstraint.constant <= 125 {

            self.delegate?.didChangeNavigationBar(false)

        } else {

            self.delegate?.didChangeNavigationBar(true)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if self.headerHeightConstraint.constant > Constant.maxHeaderHeight {
            
            animateHeader()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if self.headerHeightConstraint.constant > Constant.maxHeaderHeight {
            
            animateHeader()
        }
    }
}
