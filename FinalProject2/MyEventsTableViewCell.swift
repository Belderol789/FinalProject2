//
//  MyEventsTableViewCell.swift
//  Group2
//
//  Created by Obiet Panggrahito on 17/05/2017.
//  Copyright © 2017 Obiet Panggrahito. All rights reserved.
//

import UIKit

class MyEventsTableViewCell: UITableViewCell {
    
    
    var date : String = ""
    
    
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
    
    //"2017-05-22T09:38:11.000Z"
    
    func stringToDate(_ railsdate: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = dateFormatter.date(from:railsdate) else {return}
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
        let finalDate = calendar.date(from:components)
    
        dateToString(finalDate!)
    }
    
    func dateToString(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd, MM, yyyy"
        let newDate = dateFormatter.string(from: date)
        dateAndTime.text = newDate
    }

    
}
