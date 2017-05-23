//
//  AddCategoryViewController.swift
//  FinalProject2
//
//  Created by Obiet Panggrahito on 21/05/2017.
//  Copyright © 2017 Burst. All rights reserved.
//

import UIKit

class AddCategoryViewController: UIViewController {
    
    var currentUserID : Int = 0
    var userToken : String = ""
    var category : String = ""
    var categoryID : Int = 0
    
    var categories : [String] = []
    var categoryIDs : [Int] = []
    var chosenCategoriesID : Int = 0
    
    var backgroundColors : [UIColor] = [UIColor.red,UIColor.blue, UIColor.green, UIColor.yellow, UIColor.orange, UIColor.purple ]
    var collectionViewLayout: CustomImageFlowLayout!
    var chosenCategories : [String] = []
    
    var params : [[String:Any]] = [[:]]
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        self.userToken = UserDefaults.standard.string(forKey: "AUTH_TOKEN")!
        self.currentUserID = UserDefaults.standard.integer(forKey: "USER_ID")
        getCategories()
    }
    
    func setupCollectionView() {
        collectionViewLayout = CustomImageFlowLayout()
        collectionView.collectionViewLayout = collectionViewLayout
        
    }
    
    func getCategories() {
        let url = URL(string: "http://192.168.1.150:3000/api/v1/categories?remember_token=\(self.userToken)")
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
}

extension AddCategoryViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        var categoryImage : [UIImage] = [UserInterfaceDesign.imageOfFoodCategory(pressed: true), UserInterfaceDesign.imageOfSportCategory(pressed: true), UserInterfaceDesign.imageOfEntertainmentCategory(pressed: true), UserInterfaceDesign.imageOfDiscussionCategory(pressed: true), UserInterfaceDesign.imageOfArtCategory(pressed: true), UserInterfaceDesign.imageOfVacationCategory(pressed: true)]
        
        cell.imageView.image = categoryImage[indexPath.row]
        cell.isUserInteractionEnabled = true
        
        return cell
    }
}

extension AddCategoryViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3, animations: {
            
        })
        
        switch indexPath.row {
        case 0 :    chosenCategoriesID = 1
        case 1 :    chosenCategoriesID = 2
        case 2 :    chosenCategoriesID = 3
        case 3 :    chosenCategoriesID = 4
        case 4 :    chosenCategoriesID = 5
        case 5 :    chosenCategoriesID = 6
        default : break
        }
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "AddEventViewController") as! AddEventViewController
        controller.categoryID = chosenCategoriesID
        
        controller.userToken = userToken
        
        controller.currentUserID = currentUserID
        
        present(controller, animated: true, completion: nil)
    }
}






