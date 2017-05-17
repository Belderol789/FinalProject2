//
//  GradientColors.swift
//  Group2
//
//  Created by Kemuel Clyde Belderol on 17/05/2017.
//  Copyright © 2017 Obiet Panggrahito. All rights reserved.
//

import UIKit

var gradientLayer : CAGradientLayer!

func createGradientLayer(view : UIView) {
    
    gradientLayer = CAGradientLayer()
    
    gradientLayer.frame = view.bounds
    
    gradientLayer.colors = [UIColor]
}
