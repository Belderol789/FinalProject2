//
//  Events.swift
//  FinalProject2
//
//  Created by Kemuel Clyde Belderol on 17/05/2017.
//  Copyright © 2017 Burst. All rights reserved.
//

import UIKit

class Event {
    
    var eventName : String = ""
    var eventPlace : String = ""
    var eventDate : Date
    var eventHost : String = ""
    var eventColor : UIColor

    init(name : String, place : String, date : Date, host : String, color : UIColor) {
        eventName = name
        eventPlace = place
        eventDate = date
        eventHost = host
        eventColor = color
      
    }
    
    
}
