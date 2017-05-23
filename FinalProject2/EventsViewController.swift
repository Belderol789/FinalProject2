//
//  EventsViewController.swift
//  FinalProject2
//
//  Created by Obiet Panggrahito on 17/05/2017.
//  Copyright © 2017 Burst. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController {
    
    
    var userToken : String = ""
    var userID : Int = 0
    
    var params : [[String:Any]] = [[:]]
    var firstEvents : [Event] = []
    var secondEvents : [Event] = []
    var thirdEvents : [Event] = []
    var fourthEvents : [Event] = []
    var fifthEvents : [Event] = []
    var sixthEvents : [Event] = []
    
    var eventID : Int = 0
    var isExpanded : Bool = false
    var selectedIndex : IndexPath?
    
    var categories : [String] = []
    var categoryIDs : [Int] = []
    
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(StackTableViewCell.cellNib, forCellReuseIdentifier: StackTableViewCell.cellIdentifier)
            self.tableView.delegate = self
            self.tableView.dataSource = self
        }
    }
    
    @IBAction func segmentedControlTapped(_ sender: Any) {
        
        tableView.reloadData()
    }
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var myEventsBarButton: UIButton! {
        didSet {
            myEventsBarButton.setBackgroundImage(UserInterfaceDesign.imageOfMyEvents(pressed: false), for: .normal)
            myEventsBarButton.addTarget(self, action: #selector(myEventsBarButtonTapped), for: .touchUpInside)
            
        }
    }
    
    @IBOutlet weak var eventsBarButton: UIButton! {
        didSet {
            eventsBarButton.setBackgroundImage(UserInterfaceDesign.imageOfEvents(pressed: true), for: .normal)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userToken = UserDefaults.standard.string(forKey: "AUTH_TOKEN")!
        self.userID = UserDefaults.standard.integer(forKey: "USER_ID")
        getMyCategories()
        tableView.tableFooterView = UIView()
    }
    
    
    
    func myEventsBarButtonTapped () {
        dismiss(animated: true, completion: nil)
    }
    
    func getHostedCategories() {
        
    }
    
    func getMyCategories() {
        
        let url = URL(string: "http://192.168.1.116:3000/api/v1/events?remember_token=\(self.userToken)")
        
        var urlRequest = URLRequest(url: url!)
        
        urlRequest.httpMethod = "GET"
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            
            
            if let validError = error {
                print(validError.localizedDescription)
            }
            
            
            if let httpResponse = response as? HTTPURLResponse {
                print("EventsVC:\(httpResponse.statusCode)")
                
                if httpResponse.statusCode == 200 {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        
                        
                        guard let validJSON = jsonResponse as? [[String:Any]] else { return }
                        
                        for each in validJSON {
                            
                            let newEvent = Event(dict: each)
                            
                            if newEvent.categoryID == 1 {
                                self.firstEvents.append(newEvent)
                            } else if newEvent.categoryID == 2 {
                                self.secondEvents.append(newEvent)
                            } else if newEvent.categoryID == 3 {
                                self.thirdEvents.append(newEvent)
                            } else if newEvent.categoryID == 4 {
                                self.fourthEvents.append(newEvent)
                            } else if newEvent.categoryID == 5 {
                                self.fifthEvents.append(newEvent)
                            } else {
                                self.sixthEvents.append(newEvent)
                            }
                            
                            self.eventID = newEvent.categoryID
                            
                        }
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
    
    func joinButtonTapped () {
        
        let url = URL(string: "http://192.168.1.116:3000/api/v1/event_users?remember_token=\(self.userToken)")
        
        var urlRequest = URLRequest(url: url!)
        
        urlRequest.httpMethod = "POST"
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        self.params = [
            ["event_id" : eventID,
             "user_id" : userID]
        ]
        
        var data: Data?
        do {
            data = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        urlRequest.httpBody = data
        
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        
        let dataTask = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            
            if let validError = error {
                print(validError.localizedDescription)
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                
                if httpResponse.statusCode == 200 || httpResponse.statusCode == 204 {
                    
                    DispatchQueue.main.async {
                        print("Data sent!")
                        
                        let eventsPage = self.storyboard?.instantiateViewController(withIdentifier: "MyEventsViewController") as! MyEventsViewController
                        self.present(eventsPage, animated: true, completion: nil)
                    }
                }
            }
        }
        dataTask.resume()
    }
}

extension EventsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isExpanded == true && selectedIndex == indexPath {
            return 360
        } else {
            return 70
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfEvents = 0
        
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            numberOfEvents = firstEvents.count
            tableView.backgroundView = FoodTableView()
        case 1:
            numberOfEvents = secondEvents.count
            tableView.backgroundView = SportTableView()
        case 2:
            numberOfEvents = thirdEvents.count
            tableView.backgroundView = EntertainmentTableView()
        case 3:
            numberOfEvents = fourthEvents.count
            tableView.backgroundView = WorkTableView()
        case 4:
            numberOfEvents = fifthEvents.count
            tableView.backgroundView = CharityTableView()
        case 5:
            numberOfEvents = sixthEvents.count
            tableView.backgroundView = TravelTableView()
        default:
            break
        }
        
        return numberOfEvents
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StackTableViewCell.cellIdentifier, for: indexPath) as? StackTableViewCell else {return UITableViewCell()}
        
        cell.backgroundColor = UIColor.clear
        
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            let allEvent = firstEvents[indexPath.row]
            cell.aboutTextView.text = allEvent.eventDesc
            cell.hostLabel.text = allEvent.eventHost
            cell.nameLabel.text = allEvent.eventName
            cell.stringToDate(allEvent.eventDate)
            cell.dateLabel.text = allEvent.eventDate
            cell.placeLabel.text = allEvent.eventVenue
            //cell.detailView.backgroundColor = UserInterfaceDesign.foodCategory
//            cell.titleView.backgroundColor = UserInterfaceDesign.foodCategory
            
            break
        case 1:
            let allEvent = secondEvents[indexPath.row]
            cell.aboutTextView.text = allEvent.eventDesc
            cell.hostLabel.text = allEvent.eventHost
            cell.nameLabel.text = allEvent.eventName
            cell.stringToDate(allEvent.eventDate)
            cell.dateLabel.text = allEvent.eventDate
            cell.placeLabel.text = allEvent.eventVenue
//            cell.detailView.backgroundColor = UserInterfaceDesign.sportCategory
//            cell.titleView.backgroundColor = UserInterfaceDesign.sportCategory
            break
        case 2:
            let allEvent = thirdEvents[indexPath.row]
            cell.aboutTextView.text = allEvent.eventDesc
            cell.hostLabel.text = allEvent.eventHost
            cell.nameLabel.text = allEvent.eventName
            cell.stringToDate(allEvent.eventDate)
            cell.dateLabel.text = allEvent.eventDate
            cell.placeLabel.text = allEvent.eventVenue
//            cell.detailView.backgroundColor = UserInterfaceDesign.entertainmentCategory
//            cell.titleView.backgroundColor = UserInterfaceDesign.entertainmentCategory
            break
        case 3:
            let allEvent = fourthEvents[indexPath.row]
            cell.aboutTextView.text = allEvent.eventDesc
            cell.hostLabel.text = allEvent.eventHost
            cell.nameLabel.text = allEvent.eventName
            cell.stringToDate(allEvent.eventDate)
            cell.dateLabel.text = allEvent.eventDate
            cell.placeLabel.text = allEvent.eventVenue
//            cell.detailView.backgroundColor = UserInterfaceDesign.discussionCategory
//            cell.titleView.backgroundColor = UserInterfaceDesign.discussionCategory
            break
        case 4:
            let allEvent = fifthEvents[indexPath.row]
            cell.aboutTextView.text = allEvent.eventDesc
            cell.hostLabel.text = allEvent.eventHost
            cell.nameLabel.text = allEvent.eventName
            cell.stringToDate(allEvent.eventDate)
            cell.dateLabel.text = allEvent.eventDate
            cell.placeLabel.text = allEvent.eventVenue
//            cell.detailView.backgroundColor = UserInterfaceDesign.artCategory
//            cell.titleView.backgroundColor = UserInterfaceDesign.artCategory
            break
        case 5:
            let allEvent = sixthEvents[indexPath.row]
            cell.aboutTextView.text = allEvent.eventDesc
            cell.hostLabel.text = allEvent.eventHost
            cell.nameLabel.text = allEvent.eventName
            cell.stringToDate(allEvent.eventDate)
            cell.dateLabel.text = allEvent.eventDate
            cell.placeLabel.text = allEvent.eventVenue
//            cell.detailView.backgroundColor = UserInterfaceDesign.vacationCategory
//            cell.titleView.backgroundColor = UserInterfaceDesign.vacationCategory
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
                
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                cell.detailView.alpha = 0
                
            })
        }
        self.selectedIndex = indexPath
        
        switch (segmentedControl.selectedSegmentIndex) {
        case 0: eventID = firstEvents[indexPath.row].eventID
        case 1: eventID = secondEvents[indexPath.row].eventID
        case 2: eventID = thirdEvents[indexPath.row].eventID
        case 3: eventID = fourthEvents[indexPath.row].eventID
        case 4: eventID = fifthEvents[indexPath.row].eventID
        case 5: eventID = sixthEvents[indexPath.row].eventID
        default:
            break
        }
        
        cell.joinButton.addTarget(self, action: #selector(joinButtonTapped), for: .touchUpInside)
        cellOpened()
    }
    
}

