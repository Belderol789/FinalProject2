//
//  MainViewController.swift
//  Group2
//
//  Created by Obiet Panggrahito on 16/05/2017.
//  Copyright © 2017 Obiet Panggrahito. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var categories : [String] = ["Food", "Worklife-Balance", "Sports!", "Going out tonight", "Photography", "#Trending"]
    
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
    }
    
    func setupCollectionView() {
        collectionViewLayout = CustomImageFlowLayout()
        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.backgroundColor = .white
        
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

