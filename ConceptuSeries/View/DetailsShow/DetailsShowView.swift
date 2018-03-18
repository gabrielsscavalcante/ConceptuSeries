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
    
    func didSelect(_ episode: Episode)
}

class DetailsShowView: UIView {

    fileprivate var headerView: DetailsHeaderView!
    fileprivate var tableView: UITableView!
    fileprivate var headerHeightConstraint: NSLayoutConstraint!
    fileprivate var oldContentOffset = CGPoint.zero
    fileprivate let topConstraintRange = (Constant.minHeaderHeight..<Constant.maxHeaderHeight)
    fileprivate var show: Show!
    fileprivate var dicEpisodes: Dictionary<String, Array<Any>> = [:]
    
    public weak var delegate: DetailsShowViewDelegate?
    
    fileprivate struct Constant {
        
        static let descriptionCell: String = "DescriptionTableViewCell"
        static let episodeCell: String = "EpisodeTableViewCell"
        static let maxHeaderHeight: CGFloat = 375.0
        static let minHeaderHeight: CGFloat = 0.0
        static let subHeaderHeight: CGFloat = 53.0
    }
    
    init(with show: Show) {
        super.init(frame: .zero)
        
        self.show = show
        self.setUpHeader()
        self.setUpTableView()
        self.headerHeightConstraint.constant = Constant.maxHeaderHeight
        self.loadEpisodes()
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
    
    fileprivate func loadEpisodes() {
        
        if let show = self.show {
            
            TVMazeAPI().loadEpisodes(from: show) { (episodes) in
                
                self.setDictionary(from: episodes)
                self.tableView.reloadData()
            }
        }
    }
    
    //Create dictionary to organize episodes by sections
    fileprivate func setDictionary(from episodes: [Episode]) {
        
        for episode in episodes {

            guard let season = episode.season else { return }
            let seasonKey = "Season \(season)"
            if self.dicEpisodes[seasonKey] == nil {
                self.dicEpisodes[seasonKey] = [episode]
            } else {
                self.dicEpisodes[seasonKey]?.append(episode)
            }
        }
    }
}


extension DetailsShowView: UITableViewDataSource, UITableViewDelegate {
    
    fileprivate func registerCells() {
        
        self.tableView.register(UINib(nibName: Constant.descriptionCell, bundle: nil),
                                forCellReuseIdentifier: Constant.descriptionCell)
        self.tableView.register(UINib(nibName: Constant.episodeCell, bundle: nil),
                                forCellReuseIdentifier: Constant.episodeCell)
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
        
        if self.dicEpisodes.count > 0 {
            
            return self.dicEpisodes.count+2
        }
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section <= 1 {
            
            return 1
            
        } else {

            if self.dicEpisodes.count > 0 {
                
                return (self.dicEpisodes["Season \(section-1)"]?.count)!
            }
            
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.descriptionCell) as! DescriptionTableViewCell
            
            if let summary = self.show.summary {
                
                cell.initCell(with: summary)
            }
            
            return cell
            
        } else if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.descriptionCell) as! DescriptionTableViewCell
            
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "hh:mm"
            
            if let time = self.show.scheduleTime,
                let days = (self.show.days as? Array<String>)?.joined(separator: ", ") {
                
                cell.initCell(with: "\(dateformatter.string(from:time as Date)) - \(days)")
            }
            
            return cell
            
        } else {
         
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.episodeCell) as! EpisodeTableViewCell
            
            let episode = self.dicEpisodes["Season \(indexPath.section-1)"]![indexPath.row] as! Episode
            
            cell.initCell(with: episode)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section > 1 {
            
            let episode = self.dicEpisodes["Season \(indexPath.section-1)"]![indexPath.row] as! Episode
            self.delegate?.didSelect(episode)
        }
    }
}

extension DetailsShowView {
    
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
        if delta > 0 && self.headerHeightConstraint.constant >
            self.topConstraintRange.lowerBound && scrollView.contentOffset.y > 0 {
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
