//
//  MainViewController.swift
//  Group2
//
//  Created by Obiet Panggrahito on 16/05/2017.
//  Copyright © 2017 Obiet Panggrahito. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var category : String = ""
    var categoryID : String = ""
    
    var categories : [String] = []
    var categoryIDs : [Int] = []
    
    var chosenCategoriesIDs : [Int] = []
    
    var backgroundColors : [UIColor] = [UIColor.red,UIColor.blue, UIColor.green, UIColor.yellow, UIColor.orange, UIColor.purple ]
    var collectionViewLayout: CustomImageFlowLayout!
    var chosenCategories : [String] = []
    var buttonPressed : Bool = false
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        getCategories()
    }
    
    func setupCollectionView() {
        collectionViewLayout = CustomImageFlowLayout()
        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.backgroundColor = .white
        
    }
    
    func getCategories() {
        
            let url = URL(string: "http://192.168.1.16:3000/api/v1/categories")
            
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
        
        var categoryImage : [UIImage] = [UserInterfaceDesign.imageOfCanvas3(pressed: buttonPressed), UserInterfaceDesign.imageOfCanvas4(pressed: buttonPressed), UserInterfaceDesign.imageOfCanvas5(pressed: buttonPressed), UserInterfaceDesign.imageOfCanvas6(pressed: buttonPressed), UserInterfaceDesign.imageOfCanvas7(pressed: buttonPressed), UserInterfaceDesign.imageOfCanvas8(pressed: buttonPressed)]
    
        cell.imageView.image = categoryImage[indexPath.row]
        cell.isUserInteractionEnabled = true
        
        return cell
        
    }
}

extension MainViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell
        buttonPressed = true
        cell?.imageView.setNeedsDisplay()
        
        if self.chosenCategoriesIDs.count < 3 {
            self.chosenCategoriesIDs.append(categoryIDs[indexPath.row])
        }
        
        
        
    }
}

