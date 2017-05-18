//
//  TutorialViewController.swift
//  FinalProject2
//
//  Created by Kemuel Clyde Belderol on 18/05/2017.
//  Copyright © 2017 Burst. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.scrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
        let scrollViewHeight = self.scrollView.frame.height
        let scrollViewWidth = self.scrollView.frame.width
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

  

}
