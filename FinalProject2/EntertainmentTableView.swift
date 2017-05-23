//
//  EntertainmentTableView.swift
//  FinalProject2
//
//  Created by Obiet Panggrahito on 23/05/2017.
//  Copyright © 2017 Burst. All rights reserved.
//

import UIKit

class EntertainmentTableView: UIView {

    override func draw(_ rect: CGRect) {
        UserInterfaceDesign.drawFunTableView(frame: self.bounds, resizing: .stretch)
    }

}
