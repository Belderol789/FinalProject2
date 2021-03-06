//
//  MainViewController.swift
//  Group2
//
//  Created by Obiet Panggrahito on 16/05/2017.
//  Copyright © 2017 Obiet Panggrahito. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var currentUserID : Int = 0
    var userToken : String = ""
    var category : String = ""
    var categoryID : Int = 0
    
    var categories : [String] = []
    var categoryIDs : [Int] = []
    var chosenCategoriesIDs : [Int] = []
    
    var backgroundColors : [UIColor] = [UIColor.red,UIColor.blue, UIColor.green, UIColor.yellow, UIColor.orange, UIColor.purple ]
    var collectionViewLayout: CustomImageFlowLayout!
    var chosenCategories : [String] = []
    
    var button1Pressed : Bool = false
    var button2Pressed : Bool = false
    var button3Pressed : Bool = false
    var button4Pressed : Bool = false
    var button5Pressed : Bool = false
    var button6Pressed : Bool = false
    
    var params : [[String:Any]] = [[:]]
    
    
    @IBOutlet weak var doneButton: UIButton! {
        didSet {
            doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
            doneButton.layer.masksToBounds = true
            doneButton.layer.cornerRadius = 20
            
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        self.userToken = UserDefaults.standard.string(forKey: "AUTH_TOKEN")!
        getCategories()
        
        
        
    }
    
    func setupCollectionView() {
        collectionViewLayout = CustomImageFlowLayout()
        collectionView.collectionViewLayout = collectionViewLayout
        
    }
    
    func getCategories() {
        
        let url = URL(string: "http://192.168.1.116:3000/api/v1/categories?remember_token=\(self.userToken)")
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
                            let id = each["id"] as? Int
                            let name = each["name"] as? String
                            
                            self.categories.append(name!)
                            self.categoryIDs.append(id!)
                            
                        }
                        //self.claims = validJSON
                        DispatchQueue.main.async {
                            
                            self.collectionView.reloadData()
                        }
                        
                    } catch let jsonError as NSError {
                        print(jsonError)
                    }
                    
                }
            }
        }
        
        dataTask.resume()
        
    }
    
    
    func doneButtonTapped () {
        
        guard
            let choosenCategories : [Int] =  self.chosenCategoriesIDs
            else { return }
        
        let url = URL(string: "http://192.168.1.116:3000/api/v1/user_categories?remember_token=\(self.userToken)")
        var urlRequest = URLRequest(url: url!)
        
        urlRequest.httpMethod = "POST"
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        if choosenCategories.count == 0 {
            print("choose up to 3 categories")
            return
        }
        else if choosenCategories.count == 1 {
            self.params = [
                ["category_id" : choosenCategories[0],
                 "user_id" : UserDefaults.standard.value(forKey: "USER_ID") ?? 0]
            ]
            UserDefaults.standard.setValue(choosenCategories, forKey: "CATEGORY_ID")
        }
        else if choosenCategories.count == 2 {
            
            self.params = [
                ["category_id" : choosenCategories[0],
                 "user_id" : UserDefaults.standard.value(forKey: "USER_ID") ?? 0],
                ["category_id" : choosenCategories[1],
                 "user_id" : UserDefaults.standard.value(forKey: "USER_ID") ?? 0]
            ]
            UserDefaults.standard.setValue(choosenCategories, forKey: "CATEGORY_ID")
        }
        else {
            
            self.params = [
                
                ["category_id" : choosenCategories[0],
                 "user_id" : UserDefaults.standard.value(forKey: "USER_ID") ?? 0],
                ["category_id" : choosenCategories[1],
                 "user_id" : UserDefaults.standard.value(forKey: "USER_ID") ?? 0],
                ["category_id" : choosenCategories[2],
                 "user_id" : UserDefaults.standard.value(forKey: "USER_ID") ?? 0]
            ]
            UserDefaults.standard.setValue(choosenCategories, forKey: "CATEGORY_ID")
        }
        
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
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                        let eventsPage = storyboard.instantiateViewController(withIdentifier: "MyEventsViewController") as! MyEventsViewController
                        
                        let chosenCat = choosenCategories.sorted{ $0 < $1}
                        
                        eventsPage.arrayOfCategories = chosenCat
                        self.present(eventsPage, animated: true, completion: nil)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
}

extension MainViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        var categoryImage : [UIImage] = [UserInterfaceDesign.imageOfFoodCategory(pressed: button1Pressed), UserInterfaceDesign.imageOfSportCategory(pressed: button2Pressed), UserInterfaceDesign.imageOfEntertainmentCategory(pressed: button3Pressed), UserInterfaceDesign.imageOfDiscussionCategory(pressed: button4Pressed), UserInterfaceDesign.imageOfVacationCategory(pressed: button5Pressed), UserInterfaceDesign.imageOfArtCategory(pressed: button6Pressed)]
        
        cell.imageView.image = categoryImage[indexPath.row]
        cell.isUserInteractionEnabled = true
        
        return cell
    }
}

func -= ( left: inout [Int], right: Int){
    left = left.filter{$0 != right}
}

extension MainViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            UIView.animate(withDuration: 0.3, animations: {
                
                self.doneButton.alpha = 1
            })
        
        switch indexPath.row {
        case 0 : button1Pressed = !button1Pressed
        
        if button1Pressed == false {
            if chosenCategoriesIDs.count > 0 {
                chosenCategoriesIDs -= 1
            }
        }
    
        if button1Pressed == true {
            if chosenCategoriesIDs.count < 3 {
                chosenCategoriesIDs.append(categoryIDs[indexPath.row])
            }
            else {
                button1Pressed = !button1Pressed
            }
        }

        case 1 : button2Pressed = !button2Pressed
            
        if button2Pressed == false {
            if chosenCategoriesIDs.count > 0 {
                chosenCategoriesIDs -= 2
            }
        }
        
        if button2Pressed == true {
            if chosenCategoriesIDs.count < 3 {
                chosenCategoriesIDs.append(categoryIDs[indexPath.row])
            }
            else {
                button2Pressed = !button2Pressed
            }
        }
            
        case 2 : button3Pressed = !button3Pressed
            
        if button3Pressed == false {
            if chosenCategoriesIDs.count > 0 {
                chosenCategoriesIDs -= 3
            }
        }
        
        if button3Pressed == true {
            if chosenCategoriesIDs.count < 3 {
                chosenCategoriesIDs.append(categoryIDs[indexPath.row])
            }
            else {
                button3Pressed = !button3Pressed
            }
        }
            
        case 3 : button4Pressed = !button4Pressed
            
        if button4Pressed == false {
            if chosenCategoriesIDs.count > 0 {
                chosenCategoriesIDs -= 4
            }
        }
        
        if button4Pressed == true {
            if chosenCategoriesIDs.count < 3 {
                chosenCategoriesIDs.append(categoryIDs[indexPath.row])
            }
            else {
                button4Pressed = !button4Pressed
            }
        }
   
        case 4 : button5Pressed = !button5Pressed
            
        if button5Pressed == false {
            if chosenCategoriesIDs.count > 0 {
                chosenCategoriesIDs -= 5
            }
        }
        
        if button5Pressed == true {
            if chosenCategoriesIDs.count < 3 {
                chosenCategoriesIDs.append(categoryIDs[indexPath.row])
            }
            else {
                button5Pressed = !button5Pressed
            }
        }
    
        case 5 : button6Pressed = !button6Pressed
            
        if button6Pressed == false {
            if chosenCategoriesIDs.count > 0 {
                chosenCategoriesIDs -= 6
            }
        }
        
        if button6Pressed == true {
            if chosenCategoriesIDs.count < 3 {
                chosenCategoriesIDs.append(categoryIDs[indexPath.row])
            }
            else {
                button6Pressed = !button6Pressed
            }
        }
    
        default : break
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.imageView.setNeedsDisplay()
        
        collectionView.reloadItems(at: [indexPath])
    }
}

