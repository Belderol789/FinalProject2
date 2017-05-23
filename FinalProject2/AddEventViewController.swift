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
    var eventID : Int = 0
    var currentUserID : Int = 1
    var dateTime : [String] = []
    var events : [UIImage] = []
    var eventNames : [String] = []
    var userToken : String = ""

   
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var monthPicker: UIPickerView!
    var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    @IBOutlet weak var dayPicker: UIPickerView!
    var days = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31"]
    @IBOutlet weak var timePicker: UIPickerView!
    var times = ["00:00", "00:30", "01:00", "01:30","02:00", "02:30", "03:00", "03:30", "04:00", "04:30", "05:00", "05:30", "06:00", "06:30", "07:00", "07:30", "08:00", "08:30", "09:00", "09:30", "10:00", "10:30", "11:00", "11:30"]
    
    
    @IBOutlet weak var displayView: iCarousel!{
        didSet{
            displayView.type = iCarouselType.invertedCylinder
        }
    }
    @IBOutlet weak var nameTextField: CustomTextField! {
        didSet {
            nameTextField.placeHolderTextCustom = "Name"
        }
    }
    
    @IBOutlet weak var venueTextField: CustomTextField! {
        didSet {
            nameTextField.placeHolderTextCustom = "Venue"
        }
    }
    
    @IBOutlet weak var aboutTextView: UITextView!
    @IBOutlet weak var addEventButton: UIButton!{
        didSet{
            addEventButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        }
    }
    
 
    @IBOutlet weak var dateAndTimePicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImageArrays(categoryID)
        displayView.reloadData()
    }
    
    func setupImageArrays(_ categoryID : Int) {
        
        
        if categoryID == 1 {
            events = [#imageLiteral(resourceName: "Breakfast"), #imageLiteral(resourceName: "Brunch"), #imageLiteral(resourceName: "Lunch"), #imageLiteral(resourceName: "Tea"), #imageLiteral(resourceName: "Dinner")]
            eventNames = [ "Breakfast","Brunch", "Lunch", "Tea", "Dinner"]
        } else if categoryID == 2 {
            events = [#imageLiteral(resourceName: "Basketball"), #imageLiteral(resourceName: "Badminton"), #imageLiteral(resourceName: "Footsal"), #imageLiteral(resourceName: "Football"), #imageLiteral(resourceName: "Pingpong"), #imageLiteral(resourceName: "Jogging"), #imageLiteral(resourceName: "Cycling"), #imageLiteral(resourceName: "Trekking"), #imageLiteral(resourceName: "Yoga")]
            eventNames = ["Basketball", "Badminton", "Futsal", "Football", "Pingpong", "Jogging", "Cycling", "Trekking", "Yoga"]
        } else if categoryID == 3 {
            events = [#imageLiteral(resourceName: "Nightout"), #imageLiteral(resourceName: "Movie"), #imageLiteral(resourceName: "Concert"), #imageLiteral(resourceName: "TheatrePlay"), #imageLiteral(resourceName: "Parties")]
            eventNames = ["Nightout", "Movie", "Concert", "Theatre Play", "Party"]
        } else if categoryID == 4 {
            events = [#imageLiteral(resourceName: "Discussion")]
            eventNames = ["Discussion"]
        } else if categoryID == 5 {
            events = [#imageLiteral(resourceName: "Fundraiser")]
            eventNames = ["Fundraiser"]
        } else {
            events = [#imageLiteral(resourceName: "Leisure"), #imageLiteral(resourceName: "Business"), #imageLiteral(resourceName: "Backpacking")]
            eventNames = ["Leisure", "Business", "Backpacking"]
        }
        
        
        
        
    }
 
    func submitButtonTapped() {
        guard let name = nameTextField.text,
            let venue = venueTextField.text,
            //let dateAndTime = dateAndTimeTextField.text,
            let about = aboutTextView.text else {return}
        
        sendToDatabase(name: name, venue: venue, dateAndTime: "Tomorrow", about: about, categoryID : categoryID, eventID : eventID, currentUserID : currentUserID)
    }
 
    func sendToDatabase(name: String, venue : String, dateAndTime : String, about : String, categoryID : Int, eventID : Int, currentUserID: Int) {
        
        let url = URL(string: "http://192.168.1.116:3000/api/v1/events?remember_token=\(self.userToken)")
        var urlRequest = URLRequest(url: url!)
        
        urlRequest.httpMethod = "POST"
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        let params :[String: Any] = [
            "name" : name,
            "venue" : venue,
            //"event_time" : dateAndTime,
            "description" : about,
            "category_id" : categoryID,
            "subcategory_id" : eventID,
            "user_id" : currentUserID
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
                
                if httpResponse.statusCode == 200 || httpResponse.statusCode == 204 {
                    
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)

                        guard let validJSON = jsonResponse as? [String:Any] else { return }
                        
                       print(validJSON)
                        
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

extension AddEventViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        
        if pickerView == monthPicker {
            return months.count
        } else if pickerView == dayPicker {
            return days.count
        } else if pickerView == timePicker {
            return times.count
        }
        
        
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    
}





extension AddEventViewController : iCarouselDataSource, iCarouselDelegate {
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        var imageView : UIImageView!
        
        if view == nil {
            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 250, height: 128))
            imageView.contentMode = .scaleAspectFit
        } else {
            imageView = view as! UIImageView
        }
        
        imageView.image = events[index]
        print("Image: \(index)")
//        self.eventName.text = eventNames[index]
        print("Name: \(index)")
        
        self.eventID = index
        print(eventID)
        return imageView
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return events.count
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        let index = carousel.currentItemIndex
        if index != -1 {
        self.eventName.text = eventNames[index]
        }
    }

}

