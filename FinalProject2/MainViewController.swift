//
//  MainViewController.swift
//  Group2
//
//  Created by Obiet Panggrahito on 16/05/2017.
//  Copyright © 2017 Obiet Panggrahito. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var categories : [String] = ["entertainment", "food", "sport", "discussion", "vacation", "art"]
    
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
    }
    
    func setupCollectionView() {
        collectionViewLayout = CustomImageFlowLayout()
        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.backgroundColor = .white
        
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
    }
}

