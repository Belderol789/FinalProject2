//
//  MyEventsTableViewCell.swift
//  Group2
//
//  Created by Obiet Panggrahito on 17/05/2017.
//  Copyright © 2017 Obiet Panggrahito. All rights reserved.
//

import UIKit

class MyEventsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var profileImage: UIImageView!{
        didSet{
            profileImage.layer.cornerRadius = profileImage.frame.width/2
            profileImage.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var nameLabel: UILabel!{
        didSet{
            nameLabel.layer.cornerRadius = 10
            nameLabel.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var dateAndTime: UILabel!{
        didSet{
            dateAndTime.layer.cornerRadius = 10
            dateAndTime.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var hostLabel: UILabel!{
        didSet{
            hostLabel.layer.cornerRadius = 10
            hostLabel.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var venueLabel: UILabel!{
        didSet{
            venueLabel.layer.cornerRadius = 10
            venueLabel.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var aboutLabel: UITextView!{
        didSet{
            aboutLabel.layer.cornerRadius = 10
            aboutLabel.layer.masksToBounds = true
        }
    }
    
    static let cellIdentifier = "MyEventsTableViewCell"
    static let cellNib = UINib(nibName: MyEventsTableViewCell.cellIdentifier, bundle: Bundle.main)
    

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
