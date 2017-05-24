//
//  HostedTableView.swift
//  FinalProject2
//
//  Created by Obiet Panggrahito on 24/05/2017.
//  Copyright © 2017 Burst. All rights reserved.
//

import UIKit

class HostedTableView: UIView {

    override func draw(_ rect: CGRect) {
        UserInterfaceDesign.drawHostedTableView(frame: self.bounds, resizing: .aspectFill)
    }

}
