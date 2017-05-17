//
//  ViewController.swift
//  FinalProject2
//
//  Created by Kemuel Clyde Belderol on 17/05/2017.
//  Copyright © 2017 Burst. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var categories : [String] = ["Food", "Worklife-Balance", "Sports!", "Going out tonight", "Photography", "#Trending"]
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    var collectionViewLayout: CustomImageFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func setupCollectionView() {
        collectionViewLayout = CustomImageFlowLayout()
        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.backgroundColor = .white
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

extension MainViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        cell.categoryLabel.text = categories[indexPath.row]
        
        return cell
        
    }
}


