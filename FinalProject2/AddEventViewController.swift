//
//  AddEventViewController.swift
//  FinalProject2
//
//  Created by Obiet Panggrahito on 20/05/2017.
//  Copyright © 2017 Burst. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController {
    var categoryID : Int = 0
    var foodEvents : [UIImage] = []
    var
   
    @IBOutlet weak var displayView: iCarousel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var venueTextField: UITextField!
    @IBOutlet weak var aboutTextView: UITextView!
 
    @IBOutlet weak var dateAndTimePicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }
 
    func submitButtonTapped() {
        guard let name = nameTextField.text,
            let venue = venueTextField.text,
            let dateAndTime = dateAndTimeTextField.text,
            let about = aboutTextView.text else {return}
        
        sendToDatabase(name: name, venue: venue, dateAndTime: dateAndTime, about: about)
    }
 
    func sendToDatabase(name: String, venue : String, dateAndTime : String, about : String) {
        
        let url = URL(string: "http://192.168.1.116:3000/api/v1/sessions")
        var urlRequest = URLRequest(url: url!)
        
        urlRequest.httpMethod = "POST"
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        let params :[String: Any] = [
            "name" : name,
            "host" : ["fullname" : "Yohan"],
            "venue" : venue,
            "event_time" : dateAndTime,
            "description" : about,
            "category_id" : self.categoryID
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
                print("Login:\(httpResponse.statusCode)")
                
                if httpResponse.statusCode == 200 {
                    print("Add \(httpResponse.statusCode)")
                    
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        
                        
                        guard let validJSON = jsonResponse as? [String:Any] else { return }
                        
                        
                        DispatchQueue.main.async {
                            print("Success")
                        }
                        
                        print(jsonResponse)
                        
                    } catch let jsonError as NSError {
                        print("\(jsonError)")
                    }
                    
                }
            }
            
        }
        
        dataTask.resume()
    }

}


extension AddEventViewController : iCarouselDataSource, iCarouselDelegate {
    
  
    
    
    
    
    
    
}
