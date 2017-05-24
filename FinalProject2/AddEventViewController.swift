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
    var selectedDateTime = DateTime()
    
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    @IBOutlet weak var detailView: UIView!{
        didSet{
            detailView.layer.cornerRadius = 10
            detailView.layer.masksToBounds = true
            
        }
    }
    
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var monthPicker: UIPickerView!{
        didSet{
            monthPicker.delegate = self
            monthPicker.dataSource = self
        }
    }
    var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    @IBOutlet weak var dayPicker: UIPickerView!{
        didSet{
            dayPicker.delegate = self
            dayPicker.dataSource = self
        }
    }
    var days = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31"]
    @IBOutlet weak var timePicker: UIPickerView!{
        didSet{
            timePicker.delegate = self
            timePicker.dataSource = self
        }
    }
    var times = ["00:00", "00:30", "01:00", "01:30","02:00", "02:30", "03:00", "03:30", "04:00", "04:30", "05:00", "05:30", "06:00", "06:30", "07:00", "07:30", "08:00", "08:30", "09:00", "09:30", "10:00", "10:30", "11:00", "11:30"]
    
    
    @IBOutlet weak var displayView: iCarousel!{
        didSet{
            displayView.type = iCarouselType.coverFlow2
        }
    }
    @IBOutlet weak var nameTextField: CustomTextField!{
        didSet{
            nameTextField.placeHolderTextCustom = "Event Name"
        }
    }
    
    @IBOutlet weak var venueTextField: CustomTextField!{
        didSet{
            venueTextField.placeHolderTextCustom = "Event Venue"
        }
    }
    
    @IBOutlet weak var aboutTextView: UITextView!{
        didSet{
            aboutTextView.layer.cornerRadius = 10
            aboutTextView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var addEventButton: UIButton!{
        didSet{
            addEventButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
            addEventButton.layer.cornerRadius = 20
            addEventButton.layer.masksToBounds = true
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImageArrays(categoryID)
        displayView.reloadData()
    }
    
    func setupImageArrays(_ categoryID : Int) {
        
        
        if categoryID == 1 {
            events = [#imageLiteral(resourceName: "breakfast"), #imageLiteral(resourceName: "brunch"), #imageLiteral(resourceName: "lunch"), #imageLiteral(resourceName: "tea"), #imageLiteral(resourceName: "dinner"), #imageLiteral(resourceName: "food-others")]
            eventNames = [ "Breakfast","Brunch", "Lunch", "Tea", "Dinner", "Others"]
        } else if categoryID == 2 {
            events = [#imageLiteral(resourceName: "basketball"), #imageLiteral(resourceName: "badminton"), #imageLiteral(resourceName: "football"), #imageLiteral(resourceName: "futsal"), #imageLiteral(resourceName: "pingpong"), #imageLiteral(resourceName: "jogging"), #imageLiteral(resourceName: "cycling"), #imageLiteral(resourceName: "trekking"), #imageLiteral(resourceName: "yoga"), #imageLiteral(resourceName: "sports-others")]
            eventNames = ["Basketball", "Badminton", "Football", "Futsal", "Pingpong", "Jogging", "Cycling", "Trekking", "Yoga", "Others"]
        } else if categoryID == 3 {
            events = [#imageLiteral(resourceName: "nightout"), #imageLiteral(resourceName: "movie"), #imageLiteral(resourceName: "concert"), #imageLiteral(resourceName: "theatreplay"), #imageLiteral(resourceName: "parties"), #imageLiteral(resourceName: "entertainment-others")]
            eventNames = ["Nightout", "Movie", "Concert", "Theatre Play", "Party"]
        } else if categoryID == 4 {
            events = [#imageLiteral(resourceName: "discussion"), #imageLiteral(resourceName: "work-others")]
            eventNames = ["Discussion", "Others"]
        } else if categoryID == 5 {
            events = [#imageLiteral(resourceName: "fundraiser"), #imageLiteral(resourceName: "fundraiser-others")]
            eventNames = ["Fundraiser", "Others"]
        } else {
            events = [#imageLiteral(resourceName: "leisure"), #imageLiteral(resourceName: "business"), #imageLiteral(resourceName: "backpacking"), #imageLiteral(resourceName: "travel-others")]
            eventNames = ["Leisure", "Business", "Backpacking", "Others"]
        }
        
        
        
        
    }
    
    func submitButtonTapped() {
        guard let name = nameTextField.text,
            let venue = venueTextField.text,
            let dateAndTime = dateAndTimeLabel.text,
            let about = aboutTextView.text else {return}
        
        
        sendToDatabase(name: name, venue: venue, dateAndTime: dateAndTime, about: about, categoryID : categoryID, eventID : eventID, currentUserID : currentUserID)
    }
    
    func sendToDatabase(name: String, venue : String, dateAndTime : String, about : String, categoryID : Int, eventID : Int, currentUserID: Int) {
        
        let url = URL(string: "http://192.168.1.116:3000/api/v1/events?remember_token=\(self.userToken)")
        var urlRequest = URLRequest(url: url!)
        
        urlRequest.httpMethod = "POST"
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        let params :[[String: Any]] = [
            ["name" : name,
             "venue" : venue,
             "event_time" : dateAndTime,
             "description" : about,
             "category_id" : categoryID,
             "subcategory_id" : eventID,
             "user_id" : currentUserID]
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
                print("Create Event:\(httpResponse.statusCode)")
                
                if httpResponse.statusCode == 200 || httpResponse.statusCode == 204 {
                    
                    self.dismiss(animated: true, completion: nil)
                    
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        
                        guard let validJSON = jsonResponse as? [[String:Any]] else { return }
                        
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
        
        if pickerView.tag == 0 {
            return days.count
        } else if pickerView.tag == 1 {
            return months.count
        } else {
            return times.count
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 0 {
            
            return days[row]
        } else if pickerView.tag == 1 {
            
            return months[row]
            
        } else {
            return times[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch pickerView.tag {
        case 0:
            selectedDateTime.day = days[row]
        case 1:
            selectedDateTime.month = months[row]
        case 2:
            selectedDateTime.time = times[row]
        default:
            break
        }
        
        self.dateAndTimeLabel.text = selectedDateTime.toString()
        
    }
    
    
}





extension AddEventViewController : iCarouselDataSource, iCarouselDelegate {
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        var imageView : UIImageView!
        
        if view == nil {
            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 250, height: 130))
            imageView.contentMode = .scaleAspectFit
        } else {
            imageView = view as! UIImageView
        }
        
        imageView.image = events[index]
        
        
        
        
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
            
          
            print("Name: \(index)")
            
            if categoryID == 1 {
                if index ==  0 {
                    self.eventID = 1
                } else if index ==  1  {
                    self.eventID = 2
                }  else if index ==  2  {
                    self.eventID = 3
                }  else if index ==  3   {
                    self.eventID = 4
                }  else if index ==  4  {
                    self.eventID = 5
                }  else if index ==  5   {
                    self.eventID = 6
                }
            } else if categoryID == 2 {
                if index ==  0 {
                    self.eventID = 7
                } else if index ==  1  {
                    self.eventID = 8
                }  else if index ==  2  {
                    self.eventID = 9
                }  else if index ==  3   {
                    self.eventID = 10
                }  else if index ==  4  {
                    self.eventID = 11
                }  else if index ==  5   {
                    self.eventID = 12
                } else if index == 6 {
                    self.eventID = 13
                } else if index == 7 {
                    self.eventID = 14
                } else if index == 8 {
                    self.eventID = 15
                } else if index == 9 {
                    self.eventID = 16
                }
            } else if categoryID == 3 {
                if index == 0 {
                    self.eventID = 17
                } else if index == 1 {
                    self.eventID = 18
                } else if index == 2 {
                    self.eventID = 19
                } else if index == 3 {
                    self.eventID = 20
                } else if index == 4 {
                    self.eventID = 21
                } else if index == 5 {
                    self.eventID = 22
                }
            } else if categoryID == 4 {
                if index == 0 {
                    self.eventID = 23
                } else if index == 1 {
                    self.eventID = 24
                }
            } else if categoryID == 5 {
                if index == 0 {
                    self.eventID = 25
                } else if index == 1 {
                    self.eventID = 26
                }
            } else {
                if index == 0 {
                    self.eventID = 27
                } else if index == 1 {
                    self.eventID = 28
                } else if index == 2 {
                    self.eventID = 29
                } else if index == 3 {
                    self.eventID = 30
                }
            }
 
        }
        
    }
    
    
    class DateTime {
        var month = "January"
        var day = "1"
        var time = "00:00"
        
        func toString() -> String {
            return "\(day) \(month) \(time)"
        }
}
