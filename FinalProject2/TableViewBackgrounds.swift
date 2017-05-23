//
//  TableViewBackgrounds.swift
//  FinalProject2
//
//  Created by Obiet Panggrahito on 23/05/2017.
//  Copyright © 2017 Burst. All rights reserved.
//

import UIKit

class TableViewBackgrounds: UIView {

    var typeBackGround = 1
    
    override func draw(_ rect: CGRect) {
        
        if typeBackGround == 1 {
            UserInterfaceDesign.drawFoodTableView(frame: self.bounds, resizing: .stretch)
        }
        else if typeBackGround == 2 {
            UserInterfaceDesign.drawSportTableView(frame: self.bounds, resizing: .stretch)
        }
        else if typeBackGround == 3 {
            UserInterfaceDesign.drawFunTableView(frame: self.bounds, resizing: .stretch)
        }
        else if typeBackGround == 4 {
            UserInterfaceDesign.drawWorkTableView(frame: self.bounds, resizing: .stretch)
        }
        else if typeBackGround == 5 {
            UserInterfaceDesign.drawCharityTableView(frame: self.bounds, resizing: .stretch)
        }
        else if typeBackGround == 6 {
            UserInterfaceDesign.drawTravelTableView(frame: self.bounds, resizing: .stretch)
        }
        
    }

}
