//
//  Models.swift
//  FinalProject2
//
//  Created by Obiet Panggrahito on 19/05/2017.
//  Copyright © 2017 Burst. All rights reserved.
//

import Foundation

//class Venue {
//    
//    static let clientID = "UDQAIPHGVMU4XSXX52U02MY3ZJSBJUVD1XBVISO4M1WPDRYP"
//    static let clientSecret = "YXJCLGTBECWMZ2CA3AZXQNJG1JHNSJR2NJS5EHG0NDCINNQS"
//    
//    var name : String = ""
//    var phone : String = ""
//    var address : String = ""
//    var formattedAddress : [String] = []
//    var category : String = ""
//    var url : String = ""
//    var completeAddress: String = ""
//    var id : String = ""
//    var lat : Double = 0
//    var long : Double = 0
//    
//    init() {
//    }
//    
//    init(dict : [String : Any]) {
//        name = dict["name"] as? String ?? "Default Name"
//        url = dict["url"] as? String ?? ""
//        
//        phone = ""
//        if let contact = dict["contact"] as? [String : Any] {
//            phone = contact["phone"] as? String ?? ""
//        }
//        
//        address = ""
//        if let location = dict["location"] as? [String : Any] {
//            address = location["address"] as? String ?? ""
//        }
//        
//        formattedAddress = []
//        if let location = dict["location"] as? [String : Any] {
//            formattedAddress = location["formattedAddress"] as? [String] ?? []
//            for each in formattedAddress {
//                completeAddress += each
//            }
//        }
//        
//        category = ""
//        if let categories = dict["categories"] as? [[String : Any]] {
//            if let categoryInfo = categories[0] as? [String : Any] {
//                category = categoryInfo["shortName"] as? String ?? ""
//            }
//        }
//        
//        id = dict["id"] as? String ?? ""
//        
//        lat = 0
//        if let location = dict["location"] as? [String : Any] {
//            lat = location["lat"] as? Double ?? 0
//        }
//        
//        long = 0
//        if let location = dict["location"] as? [String : Any] {
//            long = location["lng"] as? Double ?? 0
//        }
//    }
//}
