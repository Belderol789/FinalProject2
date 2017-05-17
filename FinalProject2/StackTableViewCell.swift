//
//  StackTableViewCell.swift
//  FinalProject2
//
//  Created by Kemuel Clyde Belderol on 17/05/2017.
//  Copyright © 2017 Burst. All rights reserved.
//

import UIKit

class StackTableViewCell: UITableViewCell {
    var cellExist: Bool = false
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var hostLabel: UILabel!
    @IBOutlet weak var aboutLabel: UITextView!
    @IBOutlet weak var open: UIButton!
    
    @IBOutlet weak var openView: UIView!
    @IBOutlet weak var stuffView: UIView!{
        didSet{
            stuffView.isHidden = true
            stuffView.alpha = 0
        }
    }
    
    
    static let cellIdentifier = "StackTableViewCell"
    static let cellNib = UINib(nibName: StackTableViewCell.cellIdentifier, bundle: Bundle.main)

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func animate(duration: Double, c: @escaping() -> Void) {
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModePaced, animations: {UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: duration, animations: {
            self.stuffView.isHidden = !self.stuffView.isHidden
            if self.stuffView.alpha == 1 {
                self.stuffView.alpha = 0.5
            } else {
                self.stuffView.alpha = 1
            }
        })
            
        }, completion: { (finished: Bool) in
            print("Animation finished")
            c()
            
        })
    }
    
}
