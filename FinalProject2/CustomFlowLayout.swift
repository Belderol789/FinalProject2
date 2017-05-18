//
//  CustomFlowLayout.swift
//  FinalProject2
//
//  Created by Kemuel Clyde Belderol on 17/05/2017.
//  Copyright © 2017 Burst. All rights reserved.
//

import UIKit

class CustomImageFlowLayout: UICollectionViewFlowLayout {
    
    override init(){
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
        
    }
    
    override var itemSize: CGSize{
        set {
         
            
        }
        get {
            let itemWidth = (self.collectionView!.frame.width/2)
           // let itemHeight = ((self.collectionView?.frame.height)!/3)
            return CGSize(width: itemWidth, height: itemWidth)
        }
    }
    
    func setupLayout(){
        
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = .vertical
    }
    
}
