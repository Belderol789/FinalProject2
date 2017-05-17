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
            let numberOfColumns: CGFloat = 3
            
            let itemWidth = (self.collectionView!.frame.width - (numberOfColumns - 1)) / numberOfColumns
            return CGSize(width: itemWidth, height: itemWidth)
        }
    }
    
    func setupLayout(){
        
        minimumInteritemSpacing = -10
        minimumLineSpacing = -10
        scrollDirection = .vertical
    }
    
}
