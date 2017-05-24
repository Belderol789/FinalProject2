////
////  SegmentedControl.swift
////  FinalProject2
////
////  Created by Kemuel Clyde Belderol on 24/05/2017.
////  Copyright © 2017 Burst. All rights reserved.
////
//
//import UIKit
//
//@IBDesignable class SegmentedControl : UIControl {
//    
//    private var labels = [UILabel]()
//    var thumbView = UIView()
//    
//    var items: [String] = ["item1", "item2", "item3"] {
//        didSet{
//            setupLabels()
//        }
//    }
//    
//    
//    var selectedIndex : Int = 0 {
//        didSet {
//            displayNewSelectedIndex()
//        }
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame : frame)
//        setupView()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: coder)
//        setupView()
//    }
//    
//    
//    func setupView() {
//        layer.cornerRadius = frame.height/2
//        layer.borderColor = UIColor(white: 1.0, alpha: 0.5).cgColor
//        layer.borderWidth = 2
//        
//        backgroundColor = UIColor.clear
//        
//        setupLabels()
//        insertSubview(thumbView, at: 0)
//    }
//    
//    func setupLabels() {
//        for label in labels {
//            label.removeFromSuperview()
//        }
//        
//        labels.removeAll(keepingCapacity: true)
//        
//        for index in 1...items.count {
//            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
//            label.text = items[index - 1]
//            label.textAlignment = .center
//            label.textColor = UIColor(white: 0.5, alpha: 1.0)
//            self.addSubview(label)
//            labels.append(label)
//        }
//    }
//    
//    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
//        let location = touch.location(in: self)
//        var calculatedIndex : Int?
//        
//        for(index, item) in enumerate(labels) {
//            if item.frame.contains(location) {
//                calculatedIndex = index
//            }
//            
//        }
//        
//        if calculatedIndex != nil {
//            selectedIndex = calculatedIndex!
//            sendActions(for: .valueChanged)
//        }
//        
//        return false
//        
//        
//    }
//    
//    
//    
//    func displayNewSelectedIndex() {
//        var label = labels[selectedIndex]
//        self.thumbView.frame = label.frame
//    }
//    
//    
//}
//
//
//
//
