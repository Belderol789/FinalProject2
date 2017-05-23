//
//  TravelTableView.swift
//  FinalProject2
//
//  Created by Obiet Panggrahito on 23/05/2017.
//  Copyright © 2017 Burst. All rights reserved.
//

import UIKit

class TravelTableView: UIView {

    override func draw(_ rect: CGRect) {
        UserInterfaceDesign.drawTravelTableView(frame: self.bounds, resizing: .stretch)
    }

}
