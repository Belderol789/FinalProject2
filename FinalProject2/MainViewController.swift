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
    var buttonPressed : Bool = false
    
    var params : [[String:Any]] = [[:]]
   
    
    @IBOutlet weak var doneButton: UIButton! {
        didSet {
            doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
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
        collectionView.backgroundColor = .white
        
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
        }
        else if choosenCategories.count == 1 {
            self.params = [
                ["category_id" : choosenCategories[0],
                 "user_id" : UserDefaults.standard.value(forKey: "USER_ID") ?? 0]
            ]
        }
        else if choosenCategories.count == 2 {
            self.params = [
                ["category_id" : choosenCategories[0],
                 "user_id" : UserDefaults.standard.value(forKey: "USER_ID") ?? 0],
                ["category_id" : choosenCategories[1],
                 "user_id" : UserDefaults.standard.value(forKey: "USER_ID") ?? 0]
            ]
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
                
                if httpResponse.statusCode == 200 {
                
                    
                    DispatchQueue.main.async {
                        print("Data sent!")
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
        
        var categoryImage : [UIImage] = [UserInterfaceDesign.imageOfFoodCategory(pressed: buttonPressed), UserInterfaceDesign.imageOfSportCategory(pressed: buttonPressed), UserInterfaceDesign.imageOfEntertainmentCategory(pressed: buttonPressed), UserInterfaceDesign.imageOfArtCategory(pressed: buttonPressed), UserInterfaceDesign.imageOfVacationCategory(pressed: buttonPressed), UserInterfaceDesign.imageOfDiscussionCategory(pressed: buttonPressed)]
    
        cell.imageView.image = categoryImage[indexPath.row]
        cell.isUserInteractionEnabled = true
    
        return cell
        
    }
}

extension MainViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        buttonPressed = !buttonPressed
        cell.imageView.setNeedsDisplay()
        
        if self.chosenCategoriesIDs.count < 3 {
            self.chosenCategoriesIDs.append(categoryIDs[indexPath.row])
        }
        
        print("Cell tapped")
        collectionView.reloadItems(at: [indexPath])
    }
}

