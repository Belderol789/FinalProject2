//
//  LoginViewController.swift
//  Group2
//
//  Created by Obiet Panggrahito on 16/05/2017.
//  Copyright © 2017 Obiet Panggrahito. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UIScrollViewDelegate {
    
    var userID : Int = 0
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var mascotIcon: UIImageView! 
    @IBOutlet weak var emailTextField: CustomTextField! {
        didSet {
            emailTextField.placeholderText = "Email"
        }
    }
    
    @IBOutlet weak var passwordTextField: SecondCustomTextField! {
        didSet {
            passwordTextField.placeholderText = "Password"
        }
    }
    
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
            loginButton.layer.cornerRadius = 20
            loginButton.layer.masksToBounds = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pageControl.currentPage = 0
        titleLabel.text = "Company Culture"
        contentLabel.text = "is one of the key points"
        animateBackground()
        checkIfSomeoneSignedIn()
        
        if UserDefaults.standard.value(forKeyPath: "AUTH_TOKEN") != nil {
            print(UserDefaults.standard.value(forKeyPath: "AUTH_TOKEN")!)
        }
        
    }
    
    
    func checkIfSomeoneSignedIn() {
        if UserDefaults.standard.value(forKeyPath: "AUTH_TOKEN") != nil {
            
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let goToMainPage = storyboard.instantiateViewController(withIdentifier: "MainViewController")
            present(goToMainPage, animated: true, completion: nil)
            
        } else {
            return
        }
        
    }
    
    
    func animateBackground() {
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
        self.scrollView.frame = CGRect(x:0, y:0, width:self.view.frame.width, height:self.view.frame.height)
        let scrollViewWidth:CGFloat = self.scrollView.frame.width
        let scrollViewHeight:CGFloat = self.scrollView.frame.height
        let imgOne = UIImageView(frame: CGRect(x:0, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgOne.image = #imageLiteral(resourceName: "entertaintment")
        let imgTwo = UIImageView(frame: CGRect(x:scrollViewWidth, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgTwo.image = #imageLiteral(resourceName: "sport")
        let imgThree = UIImageView(frame: CGRect(x:scrollViewWidth*2, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgThree.image = #imageLiteral(resourceName: "discussion")
        let imgFour = UIImageView(frame: CGRect(x:scrollViewWidth*3, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgFour.image = #imageLiteral(resourceName: "vacation")
        self.scrollView.addSubview(imgOne)
        self.scrollView.addSubview(imgTwo)
        self.scrollView.addSubview(imgThree)
        self.scrollView.addSubview(imgFour)
        self.scrollView.contentSize = CGSize(width:self.scrollView.frame.width * 4, height:self.scrollView.frame.height)
        self.scrollView.delegate = self
       
    }
    
    func moveToNextPage() {
        let pageWidth:CGFloat = self.scrollView.frame.width
        let maxWidth:CGFloat = pageWidth * 4
        let contentOffset:CGFloat = self.scrollView.contentOffset.x
        
        var slideToX = contentOffset + pageWidth
        
        if  contentOffset + pageWidth == maxWidth
        {
            slideToX = 0
            self.pageControl.currentPage = 0
        }
        self.scrollView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.scrollView.frame.height), animated: true)
        
        let currentPage = self.pageControl.currentPage
        
        if Int(currentPage) == 0{
            titleLabel.text = "Company Culture"
            contentLabel.text = "is one of the key points for success"
            loginButton.backgroundColor = UIColor(red: 222.0/255.0, green: 53.0/255.0, blue: 75.0/255.0, alpha: 1.0)
        }else if Int(currentPage) == 1{
            titleLabel.text = "Interests"
            contentLabel.text = "connect people within a company"
            loginButton.backgroundColor = UserInterfaceDesign.foodCategory
        }else if Int(currentPage) == 2{
            titleLabel.text = "Find People"
            contentLabel.text = "based on interests"
            loginButton.backgroundColor = UIColor(red: 0/255.0, green: 88.0/255.0, blue: 175.0/255.0, alpha: 1.0)
        }else{
            titleLabel.text = "Create Events"
            contentLabel.text = "for a healthier and happier Company Culture"
            loginButton.backgroundColor = .yellow
        }

        self.pageControl.currentPage += 1
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
      
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
      
        self.pageControl.currentPage = Int(currentPage);
        if Int(currentPage) == 0{
            titleLabel.text = "Company Culture"
            contentLabel.text = "is one of the key points for success"
        }else if Int(currentPage) == 1{
            titleLabel.text = "Interests"
            contentLabel.text = "connect people within a company"
        }else if Int(currentPage) == 2{
            titleLabel.text = "Find People"
            contentLabel.text = "based on these interests"
        }else{
            titleLabel.text = "Create Events"
            contentLabel.text = "for a healthier and happier Company Culture"
        }
    }
    
    
    func loginButtonTapped() {
        
        
        let username = "abc@gmail.com"
        let password =  "12345678"
        
        
        let url = URL(string: "http://192.168.1.116:3000/api/v1/sessions")
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
                print("Login:\(httpResponse.statusCode)")
                
                if httpResponse.statusCode == 200 {
                    
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        
                        
                        guard let validJSON = jsonResponse as? [String:Any] else { return }
                        
                        
                        UserDefaults.standard.setValue(validJSON["remember_token"], forKey: "AUTH_TOKEN")
                        UserDefaults.standard.setValue(validJSON["id"], forKey: "USER_ID")
                        
                        self.userID = UserDefaults.standard.value(forKey: "USER_ID") as! Int
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
        
        controller?.currentUserID = userID
        
        present(controller!, animated: true, completion: nil)
    }
}
