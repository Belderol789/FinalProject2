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
    
    @IBOutlet weak var menuViewLeadingSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuView: UIView! {
        didSet {
            menuView.layer.shadowOpacity = 1
            menuView.layer.shadowRadius = 4
        }
    }
    
    @IBAction func swipeLeft(_ recognizer: UISwipeGestureRecognizer) {
        switch recognizer.direction {
        case UISwipeGestureRecognizerDirection.left:
            if menuViewShowing {
                menuBarButtonTapped()
            }
        default:
            if !menuViewShowing {
                menuBarButtonTapped()
            }
        }
    }
    
    @IBOutlet weak var myEventsBarButton: UIButton! {
        didSet {
            myEventsBarButton.setBackgroundImage(UserInterfaceDesign.imageOfMyEvents(pressed: true), for: .normal)
        }
    }
    
    @IBOutlet weak var eventsBarButton: UIButton! {
        didSet {
            eventsBarButton.setBackgroundImage(UserInterfaceDesign.imageOfEvents(pressed: false), for: .normal)
            eventsBarButton.addTarget(self, action: #selector(eventsBarButtonTapped), for: .touchUpInside)
        }
    }
    
    
    var menuViewShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipeRecognizer()
        addEvents()
    }
    
    func eventsBarButtonTapped () {
            let controller = storyboard?.instantiateViewController(withIdentifier: "EventsViewController") as? EventsViewController
            present(controller!, animated: true, completion: nil)
    }
    
    func swipeRecognizer () {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft(_ :)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    func addBarButtonTapped () {
        
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
        events.append(Event(name: "Dinner", venue: "Pedas pedas", date: "Tomorrow", host: "Changhui", desc: "Anyone want to go eat?", color: UserInterfaceDesign.foodCategory, id: 0, logo: #imageLiteral(resourceName: "restaurant-cutlery-circular-symbol-of-a-spoon-and-a-fork-in-a-circle")))
        events.append(Event(name: "Football", venue: "xxxx", date: "Today", host: "Ad", desc: "Looking for a good game", color: UserInterfaceDesign.sportCategory, id: 1, logo: #imageLiteral(resourceName: "soccer-ball-variant")))
        
    }
    
}

extension MyEventsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isExpanded == true && selectedIndex == indexPath {
            return 360
        } else {
            return 70
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StackTableViewCell.cellIdentifier, for: indexPath) as! StackTableViewCell
        let event = events[indexPath.row]
        
        
        cell.aboutTextView.text = event.eventDesc
        cell.hostLabel.text = event.eventHost
        cell.nameLabel.text = event.eventName
        cell.titleView.backgroundColor = event.eventColor
        cell.dateLabel.text = event.eventDate
        cell.placeLabel.text = event.eventVenue
        cell.detailView.backgroundColor = event.eventColor
        cell.iconImageView.image = event.categoryLogo
        
 
        
        
//        UIView.animate(withDuration: 0.3) {
//            cell.contentView.layoutIfNeeded()
//        }
        
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
