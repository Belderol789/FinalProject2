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
    
    var hostedEvents : [Event] = []
    var joinedEvents : [Event] = []
    var arrayOfCategories : [Int] = []
    var selectedIndex : IndexPath?
    var isExpanded : Bool = false
    var currentUserID : Int = 0
    var eventID : Int = 0
    var userID : Int = 0
    var numberOfEvents : Int = 0
    
    
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func segmentedControlTapped(_ sender: Any) {
        
        tableView.reloadData()
    }
    
    
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
    
    @IBOutlet weak var navBar: UINavigationBar!
    
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
    
    @IBOutlet weak var profileMenu: UIView! {
        didSet {
            profileMenu.isUserInteractionEnabled = true
            //assign a tap gesture
        }
    }
    
    var menuViewShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipeRecognizer()
        getHostedEvents()
        getJoinedEvents()
        
        
        tableView.tableFooterView = UIView()
    }
    
    func eventsBarButtonTapped () {
        let controller = storyboard?.instantiateViewController(withIdentifier: "EventsViewController") as? EventsViewController
        
        controller?.categoryIDs = self.arrayOfCategories
        present(controller!, animated: true, completion: nil)
    }
    
    func swipeRecognizer () {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft(_ :)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    func addBarButtonTapped () {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "AddCategoryViewController") as? AddCategoryViewController {
            controller.currentUserID = currentUserID
            present(controller, animated: true, completion: nil)
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
    
    
    func getHostedEvents() {
        
        
        guard let userToken = UserDefaults.standard.value(forKey: "AUTH_TOKEN") else {return}
        let userID = UserDefaults.standard.integer(forKey: "USER_ID")
        
        let url = URL(string: "http://192.168.1.116:3000/api/v1/events?remember_token=\(userToken)&host=\(userID)")
        
        var urlRequest = URLRequest(url: url!)
        
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            
            if let validError = error {
                print(validError.localizedDescription)
            }
            
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Hosted\(httpResponse.statusCode)")
                
                if httpResponse.statusCode == 200 {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        
                        
                        guard let validJSON = jsonResponse as? [[String:Any]] else { return }
                        
                        for each in validJSON {
                            
                            let hostedEvent = Event(eventDict: each)
                            
                            self.hostedEvents.append(hostedEvent)
                            
                            
                        }

                        
                        //self.claims = validJSON
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        
                    } catch let jsonError as NSError {
                        print(jsonError)
                    }
                }
            }
        }
        
        dataTask.resume()
    }
    
    
    func getJoinedEvents() {
        
        guard let userToken = UserDefaults.standard.value(forKey: "AUTH_TOKEN") else {return}
        
        guard let url = URL(string: "http://192.168.1.116:3000/api/v1/event_users?remember_token=\(userToken)") else {return}
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            
            
            if let validError = error {
                print(validError.localizedDescription)
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                
                print("Joined\(httpResponse.statusCode)")
                
                if httpResponse.statusCode == 200 {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        
                        
                        guard let validJSON = jsonResponse as? [[String:Any]] else { return }
                        
                        for each in validJSON {
                            
                            let joinedEvent = Event(eventDict: each)
                            
                            self.joinedEvents.append(joinedEvent)
                            
                            
                        }
                        //self.claims = validJSON
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        
                    } catch let jsonError as NSError {
                        print(jsonError)
                    }
                }
            }
        }
        
        dataTask.resume()
        
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
        
        
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            self.numberOfEvents = hostedEvents.count
        case 1:
            self.numberOfEvents =  joinedEvents.count
        default:
            break
        }
        
        return self.numberOfEvents
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StackTableViewCell.cellIdentifier, for: indexPath) as! StackTableViewCell
        
        switch (segmentedControl.selectedSegmentIndex) {
            
        case 0:
            let event = hostedEvents[indexPath.row]
            cell.aboutTextView.text = event.eventDesc
            cell.hostLabel.text = event.eventHost
            cell.nameLabel.text = event.eventName
            cell.stringToDate(event.eventDate)
            cell.dateLabel.text = event.eventDate
            cell.placeLabel.text = event.eventVenue
            cell.titleView.backgroundColor = event.eventColor
            cell.detailView.backgroundColor = event.eventColor
            break
        case 1:
            
            let event = joinedEvents[indexPath.row]
            cell.aboutTextView.text = event.eventDesc
            cell.hostLabel.text = event.eventHost
            cell.nameLabel.text = event.eventName
            cell.stringToDate(event.eventDate)
            cell.dateLabel.text = event.eventDate
            cell.placeLabel.text = event.eventVenue
            cell.titleView.backgroundColor = .yellow
            cell.detailView.backgroundColor = .yellow
            
            break
        default:
            break
        }
        return cell
    }
    
    func cellOpened() {
        guard let rowIndex = selectedIndex else {return}
        tableView.reloadRows(at: [rowIndex], with: .fade)
        tableView.scrollToRow(at: rowIndex, at: .bottom, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isExpanded = !isExpanded
        
        let cell = tableView.dequeueReusableCell(withIdentifier: StackTableViewCell.cellIdentifier, for: indexPath) as! StackTableViewCell
        if isExpanded == true {
            UIView.animate(withDuration: 0.3, animations: {
                cell.detailView.alpha = 0.95
                cell.titleView.alpha = 0
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                cell.detailView.alpha = 0
                cell.titleView.alpha = 1
                
            })
        }
        self.selectedIndex = indexPath
        cellOpened()
        
    }
    
    
}
