//
//  SliderMenuView.swift
//  FinalProject2
//
//  Created by Obiet Panggrahito on 21/05/2017.
//  Copyright © 2017 Burst. All rights reserved.
//

import UIKit

class SliderMenuView: UIView {

    override func draw(_ rect: CGRect) {
         UserInterfaceDesign.drawSliderMenu(frame: self.bounds, resizing: .aspectFill)
    }

}
