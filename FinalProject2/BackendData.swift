//
//  BackendData.swift
//  FinalProject2
//
//  Created by Kemuel Clyde Belderol on 17/05/2017.
//  Copyright © 2017 Burst. All rights reserved.
//

import UIKit

class WebData {
    
    func data(webUrl : String, method : String, params : Any) {
        let url = URL(string: "http://192.168.1.50:3000/api/v1/\(webUrl)")
        var urlRequest = URLRequest(url: url!)
        
        urlRequest.httpMethod = method
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        var data: Data?
        do {
            data = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        urlRequest.httpBody = data
        
        
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        
        let dataTask = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            
            
            if let validError = error {
                print(validError.localizedDescription)
            }
            
            
            if let httpResponse = response as? HTTPURLResponse {
                
                if httpResponse.statusCode == 200 {
                    
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        
                        
                        guard let validJSON = jsonResponse as? [String:Any] else { return }
                        
                        
                        UserDefaults.standard.setValue(validJSON["private_token"], forKey: "AUTH_TOKEN")
                        UserDefaults.standard.synchronize()
                        
                        DispatchQueue.main.async {
                            self.displayClaims()
                        }
                        
                        print(jsonResponse)
                        
                    } catch let jsonError as NSError {
                        print("\(jsonError)")
                    }
                    
                }
            }
            
        }
        
        dataTask.resume()
        
    }
    
}




