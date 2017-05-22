//
//  Events.swift
//  FinalProject2
//
//  Created by Kemuel Clyde Belderol on 17/05/2017.
//  Copyright © 2017 Burst. All rights reserved.
//

import UIKit

class Event {
    
    var eventID : Int = 0
    var eventName : String = ""
    var eventVenue : String = ""
    var eventDate : String = ""
    var eventHost : String = ""
    var eventDesc : String = ""
    var eventColor : UIColor = .black
    var categoryID : Int = 0
    var categoryLogo : UIImage?
    var numberOfGuests : [String] = []
    
    init(anEventID : Int, name : String, venue : String, date : String, host : String, desc : String, color : UIColor, id: Int, logo : UIImage) {
        eventID = anEventID
        eventName = name
        eventVenue = venue
        eventDate = date
        eventHost = host
        eventDesc = desc
        eventColor = color
        categoryID = id
        categoryLogo = logo
        
    }
    
    init(dict : [String : Any]) {
        eventName = dict["name"] as? String ?? "Default Name"
        if let contact = dict["host"] as? [String : Any] {
            eventHost = contact["fullname"] as? String ?? ""
        }
        eventVenue = dict["venue"] as? String ?? "Default Venue"
        eventDate = dict["event_time"] as? String ?? "Default Time"
        eventDesc = dict["description"] as? String ?? "Default Description"
        categoryID = dict["category_id"] as? Int ?? 100
        eventID = dict["id"] as? Int ?? 100
    }
    
    init(eventDict: [String : Any]) {
       if let event = eventDict["event"] as? [String : Any] {
            eventName = event["name"] as? String ?? "No name"
            eventVenue = event["venue"] as? String ?? "No venue"
            eventDesc = event["description"] as? String ?? "No description"
            eventDate = event["event_time"] as? String ?? "No date available"
        }
        
        if let guests = eventDict["guests"] as? [String : Any] {
            numberOfGuests = guests["fullname"] as? [String] ?? []
        }
        
    }
    
    
    
}
