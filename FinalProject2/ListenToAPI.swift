//
//  ListenToAPI.swift
//  Group2
//
//  Created by Obiet Panggrahito on 16/05/2017.
//  Copyright © 2017 Obiet Panggrahito. All rights reserved.
//

import Foundation

class BlogAPI {
    
    static func dataTransfer(dictionary : [String : Any], id : String, method : String) {
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: []) {
            
            let url = NSURL(string: "http://192.168.1.50:3000/api/v1/\(id)")!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = method
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
                if error != nil{
                    print("\(String(describing: error?.localizedDescription))")
                    return
                }
            }
            task.resume()
        }
    }

}
