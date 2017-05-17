//
//  LoginViewController.swift
//  Group2
//
//  Created by Obiet Panggrahito on 16/05/2017.
//  Copyright © 2017 Obiet Panggrahito. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var mascotIcon: UIImageView! {
        didSet {
            mascotIcon.layer.cornerRadius = mascotIcon.frame.width/2
            mascotIcon.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    func loginButtonTapped() {
        
        guard
            let username = emailTextField.text,
            let password =  passwordTextField.text
            else { return }
        
        let url = URL(string: "http://192.168.1.50:3000/api/v1/sessions")
        var urlRequest = URLRequest(url: url!)
        
        urlRequest.httpMethod = "POST"
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        let params :[String: String] = [
            "email" : username,
            "password" : password
        ]
        
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
    
    func displayClaims(){
        let controller = storyboard?.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController
        
        present(controller!, animated: true, completion: nil)
    }
}
