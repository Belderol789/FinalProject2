//
//  MyEventsViewController.swift
//  FinalProject2
//
//  Created by Obiet Panggrahito on 17/05/2017.
//  Copyright © 2017 Burst. All rights reserved.
//

import UIKit

class MyEventsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            
        }
    }
    
    @IBOutlet weak var addBarButton: UIBarButtonItem! {
        didSet {
            addBarButton.target = self
            addBarButton.action = #selector(addBarButtonTapped)
        }
    }
    
    @IBOutlet weak var menuBarButton: UIBarButtonItem! {
        didSet {
            menuBarButton.target = self
            menuBarButton.action = #selector(menuBarButtonTapped)
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func addBarButtonTapped () {
        
    }
    
    func menuBarButtonTapped () {
        
    }
}
