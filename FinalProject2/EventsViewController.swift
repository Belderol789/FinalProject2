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
    
    var categories : [String] = []
    var categoryIDs : [Int] = []
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            
        }
    }
    
    @IBOutlet weak var segmentedControl: UISegmentedControl! {
        didSet {
            
        }
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
                        
                        
                        guard let validJSON = jsonResponse as? [[[String:Any]]] else { return }
                        
                        for each in validJSON {
                            for every in each {
                                let id = every["id"] as? Int
                                let name = every["name"] as? String
                                
                            }
                            
                            
                            //let eventName = each["name"] as? [[String : Any]]
                            
                            
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
