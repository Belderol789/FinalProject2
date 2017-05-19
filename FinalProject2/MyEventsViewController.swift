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
            tableView.allowsSelection = false
            tableView.separatorStyle = .none
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

    @IBOutlet weak var menuViewLeadingSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuView: UIView! {
        didSet {
            menuView.layer.shadowOpacity = 1
            menuView.layer.shadowRadius = 4
        }
    }
    
    @IBOutlet weak var tabBar: UITabBar! {
        didSet {
            tabBar.target(forAction: #selector(tabBarTapped), withSender: UITabBar())
        }
    }
    
    @IBAction func swipeLeft(_ recognizer: UISwipeGestureRecognizer) {
        switch recognizer.direction {
        case UISwipeGestureRecognizerDirection.left:
            NSLog("left swipe")
            menuBarButtonTapped()
        default:
            NSLog("wrong swipe")
        }
    }
    
    var menuViewShowing = false

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft(_ :)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        addEvents()
    }

    func addBarButtonTapped () {
        
    }
    
    func tabBarTapped (tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        switch item.tag {
            
        case 1:
            let controller = storyboard?.instantiateViewController(withIdentifier: "MyEventsViewController") as! MyEventsViewController
            present(controller, animated: true, completion: nil)
        case 2:
            let controller = storyboard?.instantiateViewController(withIdentifier: "EventsViewController") as! EventsViewController
            present(controller, animated: true, completion: nil)
        default:
            break
        }
    }
    
    func menuBarButtonTapped () {
        
        if menuViewShowing {
            menuViewLeadingSpaceConstraint.constant = -270
            
            UIView.animate(withDuration: 0.15, animations: {
                self.view.layoutIfNeeded()
                self.tableView.frame = self.tableView.frame.applying(CGAffineTransform(translationX: 0, y: 0))
            })
            tableView.isUserInteractionEnabled = true
        }
        else {
            menuViewLeadingSpaceConstraint.constant = 0
            
            UIView.animate(withDuration: 0.15, animations: {
                self.view.layoutIfNeeded()
                self.tableView.frame = self.tableView.frame.applying(CGAffineTransform(translationX: 270, y: 0))
            })
            tableView.isUserInteractionEnabled = false
        }
        
        menuViewShowing = !menuViewShowing
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        if menuViewShowing {
            menuViewLeadingSpaceConstraint.constant = -270
            tableView.isUserInteractionEnabled = true
            menuViewShowing = !menuViewShowing
        }
    }
    
    func addEvents() {
        events.append(Event(name: "Dinner", place: "Pedas pedas", date: "Tomorrow", host: "Changhui", about: "Anyone want to go eat?", color: UserInterfaceDesign.foodCategory))
        events.append(Event(name: "Football", place: "xxxx", date: "Today", host: "Ad", about: "Looking for a good game", color: UserInterfaceDesign.sportCategory))
        
    }
    
}

extension MyEventsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == button_tag {
            return 320
        } else {
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StackTableViewCell.cellIdentifier, for: indexPath) as! StackTableViewCell
        let event = events[indexPath.row]
        
        if !cell.cellExist {
            cell.aboutLabel.text = event.eventAbout
            cell.hostLabel.text = event.eventHost
            cell.open.setTitle(event.eventName, for: .normal)
            cell.openView.backgroundColor = event.eventColor
            cell.stuffView.backgroundColor = event.eventColor
            cell.open.tag = t_count
            cell.open.addTarget(self, action: #selector(cellOpened(sender:)), for: .touchUpInside)
            t_count += 1
            cell.cellExist = true
        }
        
        UIView.animate(withDuration: 0) {
            cell.contentView.layoutIfNeeded()
        }
        
        return cell
    }
    
    func cellOpened(sender:UIButton) {
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
            self.lastCell.animate(duration: 0.2, c: {
                self.view.layoutIfNeeded()
            })
        }
        self.tableView.endUpdates()
    }
    
    
    
}
