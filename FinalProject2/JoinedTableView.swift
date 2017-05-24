//
//  JoinedTableView.swift
//  FinalProject2
//
//  Created by Obiet Panggrahito on 24/05/2017.
//  Copyright © 2017 Burst. All rights reserved.
//

import UIKit

class JoinedTableView: UIView {
 
    override func draw(_ rect: CGRect) {
        UserInterfaceDesign.drawJoinedTableView(frame: self.bounds, resizing: .aspectFill)
    }

}
