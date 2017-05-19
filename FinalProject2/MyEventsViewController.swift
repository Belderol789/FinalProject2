//
//  MyEventsViewController.swift
//  FinalProject2
//
//  Created by Obiet Panggrahito on 17/05/2017.
//  Copyright © 2017 Burst. All rights reserved.
//
//Cmon

import UIKit

class MyEventsViewController: UIViewController {
    
    var events : [Event] = []
    var selectedIndex : IndexPath?
    var isExpanded : Bool = false
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(StackTableViewCell.cellNib, forCellReuseIdentifier: StackTableViewCell.cellIdentifier)
            tableView.allowsSelection = false
            tableView.separatorStyle = .none
            tableView.delegate = self
            tableView.dataSource = self
            tableView.isUserInteractionEnabled = true
            tableView.allowsSelection = true
            
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
        addEvents()
    }

    func addBarButtonTapped () {
        
    }
    
    func menuBarButtonTapped () {
        
    }
    
    func addEvents() {
        events.append(Event(name: "Dinner", venue: "Pedas pedas", date: "Tomorrow", host: "Changhui", desc: "Anyone want to go eat?", color: UserInterfaceDesign.foodCategory, id: 0))
        events.append(Event(name: "Football", venue: "xxxx", date: "Today", host: "Ad", desc: "Looking for a good game", color: UserInterfaceDesign.sportCategory, id: 1))
        
    }
    
}

extension MyEventsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isExpanded == true && selectedIndex == indexPath {
            return 320
        } else {
            return 75
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StackTableViewCell.cellIdentifier, for: indexPath) as! StackTableViewCell
        let event = events[indexPath.row]
        
     
            cell.aboutLabel.text = event.eventDesc
            cell.hostLabel.text = event.eventHost
            cell.nameLabel.text = event.eventName
            cell.nameLabel.backgroundColor = event.eventColor

        
        UIView.animate(withDuration: 0.3) {
            cell.contentView.layoutIfNeeded()
        }
        
        return cell
    }
    
    func cellOpened() {
        isExpanded = !isExpanded
        guard let rowIndex = selectedIndex else {return}
        tableView.reloadRows(at: [rowIndex], with: .fade)
        
        
       
        tableView.scrollToRow(at: rowIndex, at: .bottom, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath
        cellOpened()
        
    }
    
    
    
    
}
