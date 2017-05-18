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
    
    var testCategories : [Any] = []
    
    var backgroundColors : [UIColor] = [UIColor.red,UIColor.blue, UIColor.green, UIColor.yellow, UIColor.orange, UIColor.purple ]
    var collectionViewLayout: CustomImageFlowLayout!
    
    var chosenCategories : [String] = []
    
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

extension MainViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell {
            self.chosenCategories.append(cell.categoryLabel.text!)
            
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        cell.categoryLabel.text = categories[indexPath.row]
        
        cell.backgroundColor = backgroundColors[indexPath.row]
        //cell.isUserInteractionEnabled = true
        
        return cell
        
    }
}

