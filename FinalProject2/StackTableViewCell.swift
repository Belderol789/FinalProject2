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
    
    @IBOutlet weak var dateLabel: UILabel!{
        didSet{
            dateLabel.layer.cornerRadius = 10
            dateLabel.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var placeLabel: UILabel!{
        didSet{
            placeLabel.layer.cornerRadius = 10
            placeLabel.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var hostLabel: UILabel!{
        didSet{
            hostLabel.layer.cornerRadius = 10
            hostLabel.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var aboutLabel: UITextView!{
        didSet{
            aboutLabel.layer.cornerRadius = 10
            aboutLabel.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var open: UIButton!{
        didSet{
            open.setTitleColor(.white, for: .normal)
        }
    }
    
    @IBOutlet weak var openView: UIView!{
        didSet{
            openView.layer.cornerRadius = 10
            openView.layer.masksToBounds = true
            openView.layer.borderColor = UIColor.white.cgColor
            openView.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var stuffView: UIView!{
        didSet{
            stuffView.layer.cornerRadius = 10
            stuffView.layer.masksToBounds = true
            stuffView.isHidden = true
            stuffView.alpha = 0
            stuffView.backgroundColor = UIColor.lightGray
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
    
    func animate(duration:Double, c: @escaping () -> Void) {
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModePaced, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: duration, animations: {
                
                self.stuffView.isHidden = !self.stuffView.isHidden
                if self.stuffView.alpha == 1 {
                    self.stuffView.alpha = 0.5
                } else {
                    self.stuffView.alpha = 1
                }
                
            })
        }, completion: {  (finished: Bool) in
            print("animation complete")
            c()
        })
    }
}
