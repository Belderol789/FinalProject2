//
//  MyEventsViewController.swift
//  FinalProject2
//
//  Created by Obiet Panggrahito on 17/05/2017.
//  Copyright © 2017 Burst. All rights reserved.
//
//Cmon

import UIKit
import Firebase

class MyEventsViewController: UIViewController {
    
    var hostedEvents : [Event] = []
    var joinedEvents : [Event] = []
    var userDetails : [User] = []
    var imageURL : String = ""
    
    var arrayOfCategories : [Int] = []
    var selectedIndex : IndexPath?
    var isExpanded : Bool = false
    var currentUserID : Int = 0
    var eventID : Int = 0
    var userID : Int = 0
    var numberOfEvents : Int = 0
    
    @IBOutlet weak var avatarImageView: UIImageView! {
        didSet {
            avatarImageView.layer.cornerRadius = avatarImageView.frame.width/2
            avatarImageView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var nameTextField: UILabel!
    @IBOutlet weak var positionTextField: UILabel!
    
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
        getUserDetails()
        handleImage()
        
        
        tableView.tableFooterView = UIView()
    }
    
    func eventsBarButtonTapped () {
        let controller = storyboard?.instantiateViewController(withIdentifier: "EventsViewController") as? EventsViewController
        
        controller?.categoryIDs = self.arrayOfCategories
        present(controller!, animated: true, completion: nil)
    }
    
    func uploadImage(_ image: UIImage) {
       
        let ref = Storage.storage().reference().child("profile_images").child("\(userID).jpg")
        guard let imageData = UIImageJPEGRepresentation(image, 0.5) else {return}
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        ref.putData(imageData, metadata: nil, completion: { (meta, error) in
            
            if let downloadPath = meta?.downloadURL()?.absoluteString {
                //save to firebase database
                self.saveImagePath(downloadPath)
            }
            
        })
        
        
    }
    
    func saveImagePath(_ path: String) {
        
        let profilePictureValue : [String: Any] = ["profileImageUrl": path]
        
        Database.database().reference().child("users").child("\(userID)").updateChildValues(profilePictureValue)
        
        listenToFirebase()
    }
    
    func listenToFirebase() {
        
        Database.database().reference().child("users").child("\(userID)").observe(.value, with: { (snapshot) in
            
            guard let dictionary = snapshot.value as? [String : Any] else {return}
            
            guard let profileImageUrl = dictionary["profileImageUrl"] as? String else {return}
            
            self.sendUserAvatar(ImageUrl: profileImageUrl)
            
            self.avatarImageView.loadImageUsingCacheWithUrlString(urlString: profileImageUrl)
            
            
        })
        
        
        
    }

    
    func chooseProfileImage(){
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func handleImage() {
        
        avatarImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(chooseProfileImage))
        avatarImageView.addGestureRecognizer(tap)
        
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
    
    
    
    func getUserDetails () {
        guard let userToken = UserDefaults.standard.value(forKey: "AUTH_TOKEN") else {return}
        
        guard let url = URL(string: "http://192.168.1.116:3000/api/v1/users?remember_token=\(userToken)") else {return}
        
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
                            
                            let userDetail = User(dict: each)
                            
                            self.nameTextField.text = userDetail.name
                            
                            self.imageURL = userDetail.imageURL
                            
                            self.avatarImageView.loadImageUsingCacheWithUrlString(urlString: self.imageURL)
                            
                            //                            self.positionTextField.text = userDetail.position
                        }
                    } catch let jsonError as NSError {
                        print(jsonError)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    func getJoinedEvents (){
        
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
                            
                            for each in validJSON {
                                let joinedEvent = Event(eventDict: each)
                                self.joinedEvents.append(joinedEvent)
                                
                            }
                            //self.claims = validJSON
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                            
                        }
                        
                    } catch let jsonError as NSError {
                        print(jsonError)
                    }
                }
            }
        }
        
        dataTask.resume()
        
    }
    
    
    func sendUserAvatar(ImageUrl : String) {
        
        let userID = UserDefaults.standard.integer(forKey: "USER_ID")
        guard let userToken = UserDefaults.standard.value(forKey: "AUTH_TOKEN") else {return}
        
        
        let url = URL(string: "http://192.168.1.116:3000/api/v1/users?remember_token=\(userToken)&id=\(userID)")
        var urlRequest = URLRequest(url: url!)
        
        urlRequest.httpMethod = "PUT"
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        let params :[String: Any] = [
            "avatar" : ImageUrl
            
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
                print("Sending Image:\(httpResponse.statusCode)")
                
                if httpResponse.statusCode == 200 {
                    
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        
                        
                        guard let validJSON = jsonResponse as? [String:Any] else { return }
                        print("Json\(validJSON)")

                        DispatchQueue.main.async {
                            
                        }
                        
                        
                    } catch let jsonError as NSError {
                        print("\(jsonError)")
                    }
                    
                }
            }
            
        }
        
        dataTask.resume()
        
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        
        guard let userToken = UserDefaults.standard.value(forKey: "AUTH_TOKEN") else {return}
        
        guard let url = URL(string: "http://192.168.1.116:3000/api/v1/session?remember_token=\(userToken)") else {return}
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "DELETE"
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            
            if let validError = error {
                print(validError.localizedDescription)
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Logout Status Code = \(httpResponse.statusCode)")
                let controller = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
                self.present(controller!, animated: true, completion: nil)
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

extension UIImageView {
    
    func loadImageUsingCacheWithUrlString(urlString: String) {
        
        self.image = nil
        let imageCache = NSCache<AnyObject, AnyObject>()
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage as? UIImage
            return
        }
        
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            if error != nil {
                print(error!)
                
                return
            }
            DispatchQueue.main.async(execute: {
                
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                    self.image = downloadedImage
                }
            })
        }).resume()
    }
}


extension MyEventsViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        print("User canceled out of picker")
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        var selectedImageFromPicker: UIImage?
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage
        {
            selectedImageFromPicker = editedImage
          
            
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage
        {
            selectedImageFromPicker = originalImage
            
        }
        
        if let selectedImage = selectedImageFromPicker
        {
            avatarImageView.image = selectedImage
            
            
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}

