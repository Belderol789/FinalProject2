//
//  TutorialViewController.swift
//  FinalProject2
//
//  Created by Kemuel Clyde Belderol on 18/05/2017.
//  Copyright © 2017 Burst. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var button: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
        //1
        self.scrollView.frame = CGRect(x:0, y:0, width:self.view.frame.width, height:self.view.frame.height)
        let scrollViewWidth:CGFloat = self.scrollView.frame.width
        let scrollViewHeight:CGFloat = self.scrollView.frame.height
        //2
        textView.textAlignment = .center
        textView.text = "Abcdefg"
        textView.textColor = .black
        self.button.layer.cornerRadius = 4.0
        //3
        let imgOne = UIImageView(frame: CGRect(x:0, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgOne.image = #imageLiteral(resourceName: "entertaintment")
        let imgTwo = UIImageView(frame: CGRect(x:scrollViewWidth, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgTwo.image = #imageLiteral(resourceName: "food")
        let imgThree = UIImageView(frame: CGRect(x:scrollViewWidth*2, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgThree.image = #imageLiteral(resourceName: "sport")
        let imgFour = UIImageView(frame: CGRect(x:scrollViewWidth*3, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgFour.image = #imageLiteral(resourceName: "entertaintmentBlackAndWhite")
        
        self.scrollView.addSubview(imgOne)
        self.scrollView.addSubview(imgTwo)
        self.scrollView.addSubview(imgThree)
        self.scrollView.addSubview(imgFour)
        //4
        self.scrollView.contentSize = CGSize(width:self.scrollView.frame.width * 4, height:self.scrollView.frame.height)
        self.scrollView.delegate = self
        self.pageControl.currentPage = 0

       

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
  
    func moveToNextPage (){
        
        let pageWidth:CGFloat = self.scrollView.frame.width
        let maxWidth:CGFloat = pageWidth * 4
        let contentOffset:CGFloat = self.scrollView.contentOffset.x
        
        var slideToX = contentOffset + pageWidth
        
        if  contentOffset + pageWidth == maxWidth
        {
            slideToX = 0
            self.pageControl.currentPage = 0
            self.button.alpha = 1
        }
        self.scrollView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.scrollView.frame.height), animated: true)
        self.pageControl.currentPage += 1
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        // Test the offset and calculate the current page after scrolling ends
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        // Change the indicator
        self.pageControl.currentPage = Int(currentPage);
        
        // Change the text accordingly
        if Int(currentPage) == 0{
            textView.text = "Abcdefg"
        }else if Int(currentPage) == 1{
            textView.text = "Hijklmnop"
        }else if Int(currentPage) == 2{
            textView.text = "qrstuv"
        }else{
            textView.text = "wxyz"
            // Show the "Let's Start" button in the last slide (with a fade in animation)                     UIView.animate(withDuration: 1.0, animations: { () -> Void in
            self.button.alpha = 1.0
        }
    }
}


  

