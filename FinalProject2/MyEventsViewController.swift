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
    var t_count: Int = 0
    var lastCell : StackTableViewCell = StackTableViewCell()
    var button_tag : Int = -1
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(StackTableViewCell.cellNib, forCellReuseIdentifier: StackTableViewCell.cellIdentifier)
            tableView.delegate = self
            tableView.dataSource = self
            
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
        events.append(Event(name: "Dinner", place: "Pedas pedas", date: "Tomorrow", host: "Changhui", about: "Anyone want to go eat?", color: .red))
        events.append(Event(name: "Football", place: "xxxx", date: "Today", host: "Ad", about: "Looking for a good game", color: .blue))
    }
    
}

extension MyEventsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StackTableViewCell.cellIdentifier, for: indexPath) as? StackTableViewCell else {return UITableViewCell()}
        let newEvent = events[indexPath.row]
        
        
        if !cell.cellExist {
            cell.open.setTitle("Hello", for: .normal)
            cell.aboutLabel.text = newEvent.eventAbout
            cell.stuffView.backgroundColor = newEvent.eventColor
            cell.openView.backgroundColor = newEvent.eventColor
            cell.open.tag = t_count
            cell.open.addTarget(self, action: #selector(cellOpened(sender:)), for: .touchUpInside)
            t_count += 1
            cell.placeLabel.text = newEvent.eventPlace
            cell.hostLabel.text = newEvent.eventHost
            cell.dateLabel.text = String(describing: newEvent.eventDate)
        }

        UIView.animate(withDuration: 0, animations: {
            cell.contentView.layoutIfNeeded()
        })
        
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == button_tag {
            return 300
        } else {
            return 60
        }
    }
    
    func cellOpened(sender: UIButton){
        self.tableView.beginUpdates()
        
        let previousCellTag = button_tag
        
        if lastCell.cellExist {
            self.lastCell.animate(duration: 0.2, c: {
                self.view.layoutIfNeeded()
            })
            
            if sender.tag == button_tag {
                button_tag = -1
                lastCell = StackTableViewCell()
            }
        }
        
        if sender.tag != previousCellTag {
            button_tag = sender.tag
            lastCell = tableView.cellForRow(at: IndexPath(row: button_tag, section: 0)) as! StackTableViewCell
            self.lastCell.animate(duration: 0.5, c: {
                self.view.layoutIfNeeded()
            })
        }
        
        
        self.tableView.endUpdates()
    }
    
    
    
    
}