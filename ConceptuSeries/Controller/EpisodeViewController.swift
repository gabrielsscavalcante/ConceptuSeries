//
//  PeopleViewController.swift
//  ConceptuSeries
//
//  Created by Gabriel Cavalcante on 17/03/2018.
//  Copyright © 2018 Gabriel Cavalcante. All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController {

    private var constraint = ConstraintManager()
    private var episodeView: EpisodeView!
    public var episode: Episode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar(isTranparent: true)
        
        // Do any additional setup after loading the view.
        if let episode = self.episode {
            
            self.episodeView = EpisodeView(with: episode)
            self.episodeView.delegate = self
            self.view.addSubview(self.episodeView)
            self.constraint.setEqualWidth(to: self.episodeView, from: self.view)
            self.constraint.setEqualHeight(to: self.episodeView, from: self.view)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.statusBar(.black)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func navigationIsHidden(_ bool: Bool) {
        
        UIView.animate(withDuration: 0.5) {
            
            if bool {
                
                self.navigationBar(isTranparent: true)
                self.navigationBar(with: " ")
                self.navigationController?.navigationBar.barTintColor = UIColor.black
                
            } else {
                
                self.navigationBar(isTranparent: false)
                self.navigationController?.navigationBar.barTintColor = UIColor.white
                if let name = self.episode?.name {
                    self.navigationBar(with: name)
                }
            }
        }
    }
}

extension EpisodeViewController: DetailsShowViewDelegate {
    
    func didChangeNavigationBar(_ bool: Bool) {
        self.navigationIsHidden(bool)
    }
    
    func didSelect(_ episode: Episode) {
        //do nothing
    }
}
