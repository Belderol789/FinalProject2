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
    
    @IBOutlet weak var labelPlace: UILabel!
    @IBOutlet weak var labelDateAndTime: UILabel!
    
    @IBOutlet weak var joinButton: UIButton!
    
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
    @IBOutlet weak var aboutTextView: UITextView!{
        didSet{
            aboutTextView.layer.cornerRadius = 10
            aboutTextView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!{
        didSet {
            profileImageView.layer.cornerRadius = profileImageView.frame.width/2
            profileImageView.layer.masksToBounds = true
           
        }
    }
    
    @IBOutlet weak var iconImageView: UIImageView!{
        didSet{
            iconImageView.layer.cornerRadius = iconImageView.frame.width/2
            iconImageView.layer.masksToBounds = true
        }
    }
   
    @IBOutlet weak var detailView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!{
        didSet{
            nameLabel.textColor = .white
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
    
    func stringToDate(_ date: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-mm-yyyy"
        guard let date = dateFormatter.date(from: date) else {return}
        print(date)
        
        dateToString(date)
    }
    
    func dateToString(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM dd, yyyy"
        let newDate = dateFormatter.string(from: date)
        print(newDate)
    }
    

}
