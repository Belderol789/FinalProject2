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
    var params : [[String:Any]] = [[:]]
    var firstEvents : [Event] = []
    var secondEvents : [Event] = []
    var thirdEvents : [Event] = []
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
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userToken = UserDefaults.standard.string(forKey: "AUTH_TOKEN")!
        getMyCategories()
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
                            } else {
                                self.thirdEvents.append(newEvent)
                            }
                            
                            
                            
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
    
}

extension EventsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isExpanded == true && selectedIndex == indexPath {
            return 320
        } else {
            return 75
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfEvents = 0
        
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            numberOfEvents = firstEvents.count
        case 1:
            numberOfEvents = secondEvents.count
        case 2:
            numberOfEvents = thirdEvents.count
        default:
            break
        }
        
        return numberOfEvents
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StackTableViewCell.cellIdentifier, for: indexPath) as? StackTableViewCell else {return UITableViewCell()}
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            let allEvent = firstEvents[indexPath.row]
            cell.aboutLabel.text = allEvent.eventDesc
            cell.hostLabel.text = allEvent.eventHost
            cell.nameLabel.text = allEvent.eventName
            cell.dateLabel.text = allEvent.eventDate
            cell.placeLabel.text = allEvent.eventVenue
            cell.nameLabel.backgroundColor = .blue
            
            break
        case 1:
            let allEvent = secondEvents[indexPath.row]
            cell.aboutLabel.text = allEvent.eventDesc
            cell.hostLabel.text = allEvent.eventHost
            cell.nameLabel.text = allEvent.eventName
            cell.dateLabel.text = allEvent.eventDate
            cell.placeLabel.text = allEvent.eventVenue
            cell.nameLabel.backgroundColor = .red
            break
        case 2:
            let allEvent = thirdEvents[indexPath.row]
            cell.aboutLabel.text = allEvent.eventDesc
            cell.hostLabel.text = allEvent.eventHost
            cell.nameLabel.text = allEvent.eventName
            cell.dateLabel.text = allEvent.eventDate
            cell.placeLabel.text = allEvent.eventVenue
            cell.nameLabel.backgroundColor = .green
            
            break
        default:
            break
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

