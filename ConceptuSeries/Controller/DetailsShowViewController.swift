//
//  DetailsShowViewController.swift
//  ConceptuSeries
//
//  Created by Gabriel Cavalcante on 18/03/2018.
//  Copyright © 2018 Gabriel Cavalcante. All rights reserved.
//

import UIKit

class DetailsShowViewController: UIViewController {

    private var constraint = ConstraintManager()
    private var detailsShowView: DetailsShowView!
    private var selectedEpisode: Episode?
    public var show: Show?
    
    fileprivate struct Constant {
        
        static let segueIdentifier: String = "SegueForEpisode"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar(isTranparent: true)

        // Do any additional setup after loading the view.
        if let show = self.show {
            
            self.detailsShowView = DetailsShowView(with: show)
            self.detailsShowView.delegate = self
            self.view.addSubview(self.detailsShowView)
            self.constraint.setEqualWidth(to: self.detailsShowView, from: self.view)
            self.constraint.setEqualHeight(to: self.detailsShowView, from: self.view)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        self.navigationController?.navigationBar.tintColor = UIColor.black
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
                if let name = self.show?.name {
                    self.navigationBar(with: name)
                }
            }
        }
    }
}

extension DetailsShowViewController: DetailsShowViewDelegate {
    
    func didChangeNavigationBar(_ bool: Bool) {
        self.navigationIsHidden(bool)
    }
    
    func didSelect(_ episode: Episode) {
        
        self.selectedEpisode = episode
        performSegue(withIdentifier: Constant.segueIdentifier, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.segueIdentifier {
            let controller = segue.destination as! EpisodeViewController
            controller.episode = self.selectedEpisode
        }
    }
}
