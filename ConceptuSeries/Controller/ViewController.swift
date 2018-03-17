//
//  ViewController.swift
//  ConceptuSeries
//
//  Created by Gabriel Cavalcante on 16/03/2018.
//  Copyright © 2018 Gabriel Cavalcante. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        TVMazeAPI().loadShows { (showsResponse) in
            
            print("Completion OK")
            print(showsResponse.first)
        }
        
        TVMazeAPI().loadEpisodes(from: 1) { (episodesResponse) in
            
            print("CompletionEpi OK")
            print(episodesResponse.first)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

